part of 'projects_bloc.dart';

abstract class ProjectsEvent {
  const ProjectsEvent();
}

class LoadProjects extends ProjectsEvent {
  const LoadProjects({required this.userEmail});
  final String userEmail;
}

class SaveProject extends ProjectsEvent {
  const SaveProject({required this.project, required this.userId, required this.userEmail, required this.translators, required this.reviwers});
  final Project project;
  final String userId;
  final String userEmail;
  final List<ProjectMember> translators;
  final List<ProjectMember> reviwers;
}
