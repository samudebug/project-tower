import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required this.authRepository, required this.authBloc}): super(SignupState());
  AuthRepository authRepository;
  AuthBloc authBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  signup() async {
    try {
      emit(state.copyWith(errorMessage: null));
      final email = emailController.text;
      final password = passwordController.text;
      final result = await authRepository.signUpUser(email: email, password: password);
      authBloc.add(AuthLoggedIn(userModel: result));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}