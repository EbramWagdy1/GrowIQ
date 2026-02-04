import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

// ignore: non_constant_identifier_names
void CheckStateChanges() {
  FirebaseAuth.instance
    .authStateChanges()
    .listen((User? user) {
  if (user == null) {
    
    if (kDebugMode) {
      print('User is currently signed out!');
    }
  } else {

    if (kDebugMode) {
      print('User is signed in!');
    }
  }
    });
}