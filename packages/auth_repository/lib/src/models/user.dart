import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  String id;
  String name;
  String email;
  String avatarUrl;

  UserModel({required this.id, required this.name, required this.email, required this.avatarUrl});

  factory UserModel.fromFirebase(User user) {
    return UserModel(id: user.uid, email: user.email ?? "", name: user.displayName ?? "", avatarUrl: user.photoURL ?? "");
  }
}