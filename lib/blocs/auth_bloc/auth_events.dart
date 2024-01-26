part of 'auth_bloc.dart';

abstract class AuthEvent {
  const AuthEvent();
}

class AuthLoggedIn extends AuthEvent {
  AuthLoggedIn({required this.userModel});
  UserModel userModel;
}

class AuthHasLoggedOut extends AuthEvent {}


class AuthLogin extends AuthEvent {
  const AuthLogin({required this.email, required this.password});
  final String email;
  final String password;
}

class AuthSignup extends AuthEvent {
  const AuthSignup({required this.email, required this.password});
  final String email;
  final String password;
}

class AuthLogout extends AuthEvent {
  
}