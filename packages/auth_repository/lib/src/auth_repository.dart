
import 'package:auth_repository/src/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthError extends Error {
  String message;

  AuthError({required this.message});

  @override
  String toString() {
    
    return message;
  }
}

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

  Future<UserModel> signUpUser({required String email, required String password}) async {
    try {
      final credential = await instance.createUserWithEmailAndPassword(email: email, password: password);
    return UserModel.fromFirebase(credential.user!);
    } catch (e) {
      final code = (e as FirebaseAuthException).code;
      switch (code) {
        case 'email-already-in-use':
          throw AuthError(message: "Este email já está em uso");
        case 'invalid-email':
          throw AuthError(message: "Este email é inválido");
        case 'operation-not-allowed':
          throw AuthError(message: "Configuração errada. Reporte se ver este error");
        case 'weak-password':
          throw AuthError(message: "Senha muito fraca");
        default:
          throw AuthError(message: "Ocorreu um erro $code");
      }
    }
  }

  Future<UserModel> updateUser(UserModel userModel) async {
    await instance.currentUser?.updatePhotoURL(userModel.avatarUrl);
    return UserModel.fromFirebase(instance.currentUser!);
  }

  Future<void> logout() async {
    await instance.signOut();
  }
}