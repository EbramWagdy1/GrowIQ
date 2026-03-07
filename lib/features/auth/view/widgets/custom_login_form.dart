import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/functions/custom_toast.dart';
import 'package:growiq/core/functions/navigation.dart';
import 'package:growiq/core/utils/app_colors.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/utils/regexes.dart';
import 'package:growiq/core/widgets/custom_button.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:growiq/features/auth/view/widgets/custom_form_field.dart';

class CustomLoginForm extends StatelessWidget {
  const CustomLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is SignInSuccessState || state is SignInSuccessState) {
          showToast("Welcome back!");
          customReplacementNavigate(context, "/Home");
        } else if (state is SignInFailureState) {
          showToast(state.errMessage);
        }
      },
      builder: (context, state) {
        AuthCubit authCubit = BlocProvider.of<AuthCubit>(context);
        return Form(
          key: authCubit.formKey,
          child: Column(
            children: [
              CustomTextFormField(
                text: AppStrings.email,
                onChanged: (email) {
                  authCubit.email = email;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email address (e.g., example@example.com)';
                  }
                  return null;
                },
              ),
              SizedBox(height: 15),
              CustomTextFormField(
                text: AppStrings.password,
                obscureText: !authCubit.isPasswordVisible,
                onEyePressed: () {
                  authCubit.togglePasswordVisibility();
                },
                onChanged: (password) {
                  authCubit.password = password;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              state is SignInLoadingState
                  ? CircularProgressIndicator(color: AppColors.primaryColor)
                  : CustomButtom(
                      text: AppStrings.login,
                      onPressed: () {
                        if (authCubit.formKey.currentState!.validate()) {
                          authCubit.signInWithEmailAndPassword();
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
