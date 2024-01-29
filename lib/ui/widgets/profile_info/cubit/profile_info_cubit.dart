import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoState());

  setImage(File file) async {
    emit(state.copyWith(file: file));
  }

  saveUser() async {
    if (state.file != null) {
      final downloadUrl = await getIt<StorageRepository>().uploadFile(state.file!);
      final userModel = (getIt<AuthBloc>().state as AuthLogged).userModel;
      getIt<AuthBloc>().add(AuthUpdate(userModel: userModel.copyWith(avatarUrl: downloadUrl)));
    }
  }
}