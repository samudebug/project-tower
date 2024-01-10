part of 'projects_bloc.dart';

abstract class ProjectsState {
  const ProjectsState();
}

class ProjectsInitial extends ProjectsState {}

class ProjectsLoading extends ProjectsState {}

class ProjectsReady extends ProjectsState {
  const ProjectsReady({required this.projects});
  final List<Project> projects;
}

class ProjectsFailed extends ProjectsState {}