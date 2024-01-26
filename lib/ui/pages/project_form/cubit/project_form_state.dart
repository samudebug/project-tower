part of 'project_form_cubit.dart';

class ProjectFormState {
  File? file;
  List<ProjectMember> translators;
  List<ProjectMember> reviwers;
  String? imageUrl;
  Project? project;

  ProjectFormState(
      {this.file,
      this.imageUrl,
      this.project,
      required this.translators,
      required this.reviwers});

  ProjectFormState copyWith(
      {File? file,
      String? imageUrl,
      List<ProjectMember>? translators,
      List<ProjectMember>? reviwers,
      Project? project}) {
    return ProjectFormState(
        file: file ?? this.file,
        imageUrl: imageUrl ?? this.imageUrl,
        translators: translators ?? this.translators,
        reviwers: reviwers ?? this.reviwers,
        project: project ?? this.project);
  }
}
