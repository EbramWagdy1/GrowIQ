//all logic related to Auth Cubit

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:growiq/features/auth/view_model/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:growiq/core/services/auth_service.dart';
import 'package:growiq/core/services/cloudinary_service.dart';
import 'dart:io';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService;
  final CloudinaryService _cloudinaryService;

  AuthCubit(this._authService, this._cloudinaryService) : super(AuthInitial());
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;
  String? name = '';
  String? email;
  String? password;
  String? confirmPassword;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Stream<User?> get authStateChanges => _authService.authStateChanges;

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(PasswordVisibilityChangedState());
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ConfirmPasswordVisibilityChangedState());
  }

  // ignore: strict_top_level_inference
  signUpWithEmailAndPassword() async {
    try {
      emit(SignupLoadingState());
      final credential = await _authService.signUpWithEmailAndPassword(
          email: email!, password: password!);

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
      await _authService.signInWithEmailAndPassword(
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
      final credential = await _authService.signInWithGoogle();
      if (credential == null) {
        emit(SignInFailureState('Google sign-in aborted'));
        return;
      }
      emit(SignInSuccessState());
    } catch (e) {
      emit(SignInFailureState(e.toString()));
    }
  }

  Future<void> resetPasswordWithEmail() async {
    if (email == null || email!.isEmpty) {
      emit(ResetPasswordFailureState('Email cannot be empty.'));
      return;
    }

    emit(ResetPasswordLoadingState());

    try {
      await _authService.sendPasswordResetEmail(email: email!);
      emit(ResetPasswordSuccessState());
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email.';
          break;
        case 'invalid-email':
          errorMessage = 'The email address is invalid.';
          break;
        default:
          errorMessage = e.message ?? 'An unexpected error occurred.';
      }
      emit(ResetPasswordFailureState(errorMessage));
    } catch (_) {
      emit(ResetPasswordFailureState('Something went wrong.'));
    }
  }

  // Profile Management
  Future<void> updateProfile({String? newName, File? newImage}) async {
    try {
      emit(ProfileUpdateLoadingState());
      
      if (newName != null && newName.isNotEmpty) {
        await _authService.updateDisplayName(newName);
      }

      if (newImage != null) {
        final imageUrl = await _cloudinaryService.uploadImage(newImage);
        if (imageUrl != null) {
          await _authService.updatePhotoURL(imageUrl);
        }
      }

      emit(ProfileUpdateSuccessState());
    } catch (e) {
      emit(ProfileUpdateFailureState(e.toString()));
    }
  }

  Future<void> signOut() async {
    try {
      await _authService.signOut();
      emit(SignOutSuccessState());
    } catch (e) {
      emit(SignOutFailureState(e.toString()));
    }
  }
}
