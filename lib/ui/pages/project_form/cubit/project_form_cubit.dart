import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';

part 'project_form_state.dart';

class ProjectFormCubit extends Cubit<ProjectFormState> {
  ProjectFormCubit({required this.projectsBloc, required this.storageRepository}) : super(ProjectFormState(translators: [], reviwers: []));
  ProjectsBloc projectsBloc;
  StorageRepository storageRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController addMemberController = TextEditingController();

  saveProject(String userId, String userEmail) async {
    String imageUrl = "";
    if (state.file != null) {
      final downloadUrl = await storageRepository.uploadFile(state.file!);
      imageUrl = downloadUrl;
    }
    final project = Project(name: nameController.text, imageUrl: imageUrl, role: RoleInProject.CREATOR);
    projectsBloc.add(SaveProject(project: project, userId: userId, userEmail: userEmail, translators: state.translators, reviwers: state.reviwers));
  }

  setImage(File file) async {
    emit(state.copyWith(file: file));
  }

  saveMember(ProjectMember member) {
    if (member.role == RoleInProject.TRANSLATOR) {
      state.translators.add(member);
    } else {
      state.reviwers.add(member);
    }
    emit(state.copyWith(translators: state.translators, reviwers: state.reviwers));
  }

  removeMember(RoleInProject role, int index) {
    if (role == RoleInProject.TRANSLATOR) {
      state.translators.removeAt(index);
    } else {
      state.reviwers.removeAt(index);
    }
    emit(state.copyWith(translators: state.translators, reviwers: state.reviwers));
  }
}