import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
import 'package:growiq/core/utils/app_colors.dart';

class CustomAppLogin extends StatelessWidget {
  const CustomAppLogin({super.key});

  Widget _socialIcon({required Widget icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(100),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.greyShade300),
        ),
        child: Center(child: icon),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _socialIcon(
          icon: const FaIcon(
            FontAwesomeIcons.facebook,
            color: AppColors.facebookBlue,
            size: 32,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 24),
        _socialIcon(
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: AppColors.googleRed,
            size: 32,
          ),
          onTap: () {
            final authCubit = BlocProvider.of<AuthCubit>(context);

            authCubit.signInWithGoogle();
          },
        ),
        const SizedBox(width: 24),
        _socialIcon(
          icon: const FaIcon(
            FontAwesomeIcons.apple,
            color: AppColors.black,
            size: 32,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
