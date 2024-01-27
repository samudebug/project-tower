import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:storage_repository/storage_repository.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';

part 'project_form_state.dart';

class ProjectFormCubit extends Cubit<ProjectFormState> {
  ProjectFormCubit({required this.projectsBloc, required this.storageRepository, required this.projectsRepository}) : super(ProjectFormState(translators: [], reviwers: []));
  ProjectsBloc projectsBloc;
  StorageRepository storageRepository;
  ProjectsRepository projectsRepository;
  TextEditingController nameController = TextEditingController();
  TextEditingController addMemberController = TextEditingController();

  init(Project project) async {
    nameController.text = project.name;
    final translators = await projectsRepository.fetchMembersbyType(project.id!, RoleInProject.TRANSLATOR);
    final reviewers = await projectsRepository.fetchMembersbyType(project.id!, RoleInProject.REVIEWER);
    emit(state.copyWith(translators: translators, reviwers: reviewers, imageUrl: project.imageUrl, project: project));
  }

  saveProject(String userId, String userEmail) async {
    String imageUrl = "";
    if (state.file != null) {
      final downloadUrl = await storageRepository.uploadFile(state.file!);
      imageUrl = downloadUrl;
    } else {
      imageUrl = state.imageUrl ?? "";
    }
    if (state.project != null) {
      projectsBloc.add(UpdateProject(project: state.project!.copyWith(name: nameController.text, imageUrl: imageUrl), translators: state.translators, reviwers: state.reviwers));
    } else {

      final project = Project(name: nameController.text, imageUrl: imageUrl, role: RoleInProject.CREATOR);
      projectsBloc.add(SaveProject(project: project, userId: userId, userEmail: userEmail, translators: state.translators, reviwers: state.reviwers));
    }
    projectsBloc.add(LoadProjects(userEmail: userEmail));
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