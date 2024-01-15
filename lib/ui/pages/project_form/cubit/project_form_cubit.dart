import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';

part 'project_form_state.dart';

class ProjectFormCubit extends Cubit<ProjectFormState> {
  ProjectFormCubit({required this.projectsBloc, required this.storageRepository}) : super(ProjectFormState());
  ProjectsBloc projectsBloc;
  StorageRepository storageRepository;
  TextEditingController nameController = TextEditingController();

  saveProject() async {
    String imageUrl = "";
    if (state.file != null) {
      final downloadUrl = await storageRepository.uploadFile(state.file!);
      imageUrl = downloadUrl;
    }
    final project = Project(name: nameController.text, imageUrl: imageUrl);
    projectsBloc.add(SaveProject(project: project));
  }

  setImage(File file) async {
    emit(state.copyWith(file: file));
  }
}