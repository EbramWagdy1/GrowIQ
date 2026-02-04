import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/utils/app_strings.dart';
import 'package:growiq/core/widgets/custom_Buttom.dart';
import 'package:growiq/feauters/Auth/presentation/Auth_cuibt/cubit/auth_cubit.dart';
import 'package:growiq/feauters/Auth/presentation/Auth_cuibt/cubit/auth_state.dart';
import 'package:growiq/feauters/Auth/widgets/CustomTextField.dart';

class CustomSignupForm extends StatelessWidget {
  const CustomSignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return Form(
          child: Column(
            children: [
              CustomTextFormField(text: AppStrings.name,
              onChanged: (name) {
                BlocProvider.of<AuthCubit>(context).name = name;
              },
              ),
              
              SizedBox(height: 15),
              CustomTextFormField(text: AppStrings.email
              ,onChanged: (email) {
                BlocProvider.of<AuthCubit>(context).email = email;
              },
              ),
              SizedBox(height: 15),
              CustomTextFormField(text: AppStrings.password,
              onChanged: (password) {
                BlocProvider.of<AuthCubit>(context).password = password;
              },
                ),
              SizedBox(height: 15),
              CustomTextFormField(text: AppStrings.confirmPassword
              ,onChanged: (confirmPassword) {
                BlocProvider.of<AuthCubit>(context).confirmPassword = confirmPassword;
              },
              ),
              SizedBox(height: 30),
              CustomButtom(
                text: AppStrings.signup,
                onPressed: () {
                  BlocProvider.of<AuthCubit>(context).signUpWithEmailAndPassword(
                  
                  );
                    
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
