part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthUnlogged extends AuthState {}

class AuthLogged extends AuthState {
  AuthLogged({required this.userModel});
  UserModel userModel;
}