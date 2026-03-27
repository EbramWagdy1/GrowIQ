import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/auth/view/widgets/Forget_Password_Header.dart';
import 'package:growiq/features/auth/view/widgets/Resend_Code_Section.dart';
import 'package:growiq/features/auth/view/widgets/Success_Message_Section.dart';
import 'package:growiq/core/functions/custom_toast.dart';
import 'package:growiq/core/utils/regexes.dart';
import 'package:growiq/core/widgets/custom_button.dart';
import 'package:growiq/core/widgets/custom_appBar.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:growiq/features/auth/view/widgets/custom_form_field.dart';
import 'package:growiq/core/l10n/arb/app_localizations.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  int _secondsRemaining = 30;
  Timer? _timer;
  bool _canResend = false;
  bool _isEmailSent = false;

  void _startTimer() {
    setState(() {
      _secondsRemaining = 30;
      _canResend = false;
      _isEmailSent = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() {
          _secondsRemaining--;
        });
      } else {
        setState(() {
          _canResend = true;
        });
        _timer?.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque, 
    onTap: () {
      FocusScope.of(context).unfocus(); 
    },
      child: Scaffold(
        appBar: const CustomAppBar(title: ''),
        body: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccessState) {
              showToast("Reset link sent to your email");
              _startTimer();
            } else if (state is ResetPasswordFailureState) {
              showToast(state.error);
            }
          },
          builder: (context, state) {
            final authCubit = context.read<AuthCubit>();
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Form(
                key: authCubit.formKey,
                child: Column(
                  children: [
                    const ForgetPasswordHeader(),
                    const SizedBox(height: 20),
                    CustomTextFormField(
                      text: AppLocalizations.of(context)!.email,
                      onChanged: (email) => authCubit.email = email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!AppRegex.isEmailValid(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    if (state is ResetPasswordSuccessState)
                      const SuccessMessageSection(),
                    const SizedBox(height: 40),
                    _buildResetButton(state, authCubit),
                    if (_isEmailSent) ...[
                      const SizedBox(height: 30),
                      ResendCodeSection(
                        canResend: _canResend,
                        secondsRemaining: _secondsRemaining,
                        onResend: () => authCubit.resetPasswordWithEmail(),
                      ),
                    ],
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildResetButton(AuthState state, AuthCubit authCubit) {
    if (state is ResetPasswordLoadingState) {
      return CircularProgressIndicator(color: Theme.of(context).colorScheme.primary);
    }
    return CustomButtom(
      text: AppLocalizations.of(context)!.resetPasswordButton,
      onPressed: () {
        if (authCubit.formKey.currentState!.validate()) {
          authCubit.resetPasswordWithEmail();
        }
      },
    );
  }
}




