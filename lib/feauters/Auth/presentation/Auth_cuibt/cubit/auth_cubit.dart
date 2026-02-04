//all logic related to Auth Cubit

import 'package:firebase_auth/firebase_auth.dart';
import 'package:growiq/feauters/Auth/presentation/Auth_cuibt/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  late String name;
  late String email;
  late String password;
  late String confirmPassword;
  // ignore: strict_top_level_inference
  signUpWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
            email: email ,
            password: password ,
          );
      emit(SignupSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        emit(SignupFailureState('The password provided is too weak.'));
      } else if (e.code == 'email-already-in-use') {
        emit(SignupFailureState('The account already exists for that email.'));
      }
    } catch (e) {
      emit(SignupFailureState(e.toString()));
    }
  }
}
