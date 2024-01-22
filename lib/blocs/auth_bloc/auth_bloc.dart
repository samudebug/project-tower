import 'dart:math';

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_events.dart';
part 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    authRepository.registerAuthStateChanged((user) => {
      if (user != null) {
        add(AuthLoggedIn(userModel: UserModel.fromFirebase(user)))
      } else {
        add(AuthHasLoggedOut())
      }
    });
    on<AuthLogin>(loginUser);
    on<AuthLoggedIn>(userHasLoggedIn);
    on<AuthHasLoggedOut>(userHasLoggedOut);
    on<AuthLogout>(logout);
  }

  final AuthRepository authRepository;

  loginUser(AuthLogin event, Emitter<AuthState> emit) async {
    final result = await authRepository.signInUser(email: event.email, password: event.password);
    emit(AuthLogged(userModel: result));
  }

  userHasLoggedIn(AuthLoggedIn event, Emitter<AuthState> emit) async {
    emit(AuthLogged(userModel: event.userModel));
  }

  userHasLoggedOut(AuthHasLoggedOut event, Emitter<AuthState> emit) async {
    emit(AuthUnlogged());
  }

  logout(AuthLogout event, Emitter<AuthState> emit) async {
    authRepository.logout();
    emit(AuthUnlogged());
  }

}