import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';

part 'projects_events.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({required this.projectsRepository}) : super(ProjectsInitial()) {
    on<LoadProjects>(loadProjects);
    on<SaveProject>(saveProject);
    on<UpdateProject>(updateProject);
  }

  final ProjectsRepository projectsRepository;

  Future<void> loadProjects(LoadProjects event, Emitter<ProjectsState> emit) async {
    try {
      emit(ProjectsLoading());
      final result = await projectsRepository.getProjects(event.userEmail);
      emit(ProjectsReady(projects: result));
    } catch (e) {
      log('Error while fetching projects', error: e);
      emit(ProjectsFailed());
    }
  }

  Future<void> saveProject(SaveProject event, Emitter<ProjectsState> emit) async {
    try {
      await projectsRepository.saveProject(event.project, event.userId, event.userEmail, event.translators, event.reviwers);
    } catch (e) {
      log('Error while fetching projects', error: e);
      emit(ProjectsFailed());
    }
  }

  Future<void> updateProject(UpdateProject event, Emitter<ProjectsState> emit) async {
    try {
      await projectsRepository.updateProject(event.project, event.translators, event.reviwers);
    } catch (e) {
      log('Error while fetching projects', error: e);
      emit(ProjectsFailed());
    }
  }
}