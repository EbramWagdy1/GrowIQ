import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/features/auth/view_model/auth_cubit.dart';
// Update with your actual import

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
          border: Border.all(color: Colors.grey.shade300),
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
            color: Color(0xFF1877F2),
            size: 32,
          ),
          onTap: () {},
        ),
        const SizedBox(width: 24),
        _socialIcon(
          icon: const FaIcon(
            FontAwesomeIcons.google,
            color: Color(0xFFDB4437),
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
            color: Colors.black,
            size: 32,
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
