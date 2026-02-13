//all logic related to Auth Cubit

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? name = '';
  String? email;
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void togglePasswordVisibility(AuthCubit authCubit) {
    authCubit.isPasswordVisible = !authCubit.isPasswordVisible;
    authCubit.emit(PasswordVisibilityChangedState());
  }

  void toggleConfirmPasswordVisibility(AuthCubit authCubit) {
    authCubit.isConfirmPasswordVisible = !authCubit.isConfirmPasswordVisible;
    authCubit.emit(ConfirmPasswordVisibilityChangedState());
  }

  // ignore: strict_top_level_inference
  signUpWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email!, password: password!);

      if (credential.user != null) {
        await credential.user!.updateDisplayName(name);
        await credential.user!.reload();
      }

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

  // ignore: strict_top_level_inference
  signInWithEmailAndPassword() async {
    try {
      emit(SignInLoadingState());
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      emit(SignInSuccessState());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SignInFailureState('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        emit(SignInFailureState('password is wrong for that user'));
      }
    } catch (e) {
      emit(SignInFailureState(e.toString()));
    }
  }

  // Google Sign-In
  Future<void> signInWithGoogle() async {
    try {
      emit(SignInLoadingState());
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        emit(SignInFailureState('Google sign-in aborted'));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(SignInSuccessState());
    } catch (e) {
      emit(SignInFailureState(e.toString()));
    }
  }
}
