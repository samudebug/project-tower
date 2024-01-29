part of 'profile_info_cubit.dart';

class ProfileInfoState {
  File? file;

  ProfileInfoState({this.file});

  ProfileInfoState copyWith({File? file}) {
    return ProfileInfoState(file: file ?? this.file);
  }
}