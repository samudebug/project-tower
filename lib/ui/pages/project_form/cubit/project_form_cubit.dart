import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';

part 'project_form_state.dart';

class ProjectFormCubit extends Cubit<ProjectFormState> {
  ProjectFormCubit({required this.projectsBloc}) : super(ProjectFormState());
  ProjectsBloc projectsBloc;
  File? file;

  TextEditingController nameController = TextEditingController();

  saveProject() async {
    final project = Project(name: nameController.text, imageUrl: "");
    projectsBloc.add(SaveProject(project: project));
  }
}