part of 'signup_cubit.dart';
class SignupState {
  String? errorMessage;

  SignupState({this.errorMessage});

  SignupState copyWith({String? errorMessage}) {
    return SignupState(errorMessage: errorMessage);
  }
}