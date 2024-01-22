import 'dart:developer';

import 'package:auth_repository/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  FirebaseAuth instance = FirebaseAuth.instance;

  registerAuthStateChanged(Function(User? user) onAuthStateChanged) {
    instance.authStateChanges().listen((user) {
      onAuthStateChanged(user);
    });
  }

  Future<UserModel> signInUser({required String email, required String password}) async {
    final credential = await instance.signInWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebase(credential.user!);
  }

  Future<void> logout() async {
    await instance.signOut();
  }
}