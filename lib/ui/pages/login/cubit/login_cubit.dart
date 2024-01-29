import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/ui/pages/login/cubit/login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authBloc}) : super(LoginState());
  AuthBloc authBloc;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login() {
    authBloc.add(AuthLogin(email: emailController.text, password: passwordController.text));
  }
  
}