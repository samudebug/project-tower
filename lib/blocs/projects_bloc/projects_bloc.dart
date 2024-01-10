import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';

part 'projects_events.dart';
part 'projects_state.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  ProjectsBloc({required this.projectsRepository}) : super(ProjectsInitial()) {
    on<LoadProjects>(loadProjects);
    on<SaveProject>(saveProject);
  }

  final ProjectsRepository projectsRepository;

  Future<void> loadProjects(LoadProjects event, Emitter<ProjectsState> emit) async {
    try {
      emit(ProjectsLoading());
      final result = await projectsRepository.getProjects();
      emit(ProjectsReady(projects: result));
    } catch (e) {
      log('Error while fetching projects', error: e);
      emit(ProjectsFailed());
    }
  }

  Future<void> saveProject(SaveProject event, Emitter<ProjectsState> emit) async {
    try {
      await projectsRepository.saveProject(event.project);
      add(LoadProjects());
    } catch (e) {
      log('Error while fetching projects', error: e);
      emit(ProjectsFailed());
    }
  }
}