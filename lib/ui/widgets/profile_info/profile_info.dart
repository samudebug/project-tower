import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/widgets/profile_info/cubit/profile_info_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  getImage({File? file, required String avatarUrl}) {
    if (file != null) {
      return FileImage(file);
    }
    if (avatarUrl.isNotEmpty) {
      return NetworkImage(avatarUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    var avatarUrl = (getIt<AuthBloc>().state as AuthLogged).userModel.avatarUrl;
    return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(type: FileType.image);
                      if (result != null) {
                        context
                            .read<ProfileInfoCubit>()
                            .setImage(File(result.files.single.path!));
                      }
                    },
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.green,
                      foregroundImage: getImage(avatarUrl: avatarUrl, file: state.file),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    (getIt<AuthBloc>().state as AuthLogged).userModel.email,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                )
          ],),
        );
      }
    );
  }
}