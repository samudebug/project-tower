part of 'projects_bloc.dart';

abstract class ProjectsEvent {
  const ProjectsEvent();
}

class LoadProjects extends ProjectsEvent {}

class SaveProject extends ProjectsEvent {
  const SaveProject({required this.project});
  final Project project;
}