import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/services/auth_service.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Stream<User?> get authStateChanges => _authService.authStateChanges;
  Stream<User?> get userChanges => _authService.userChanges;
  User? get currentUser => _authService.currentUser;

  Future<UserCredential> signUp(String email, String password) async {
    return await _authService.signUpWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _authService.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    return await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  Future<void> resetPassword(String email) async {
    await _authService.sendPasswordResetEmail(email: email);
  }

  Future<void> updateProfile({String? name, String? photoUrl}) async {
    if (name != null) {
      await _authService.updateDisplayName(name);
    }
    if (photoUrl != null) {
      await _authService.updatePhotoURL(photoUrl);
    }
  }
}
