part of 'project_form_cubit.dart';

class ProjectFormState {
  File? file;
  List<ProjectMember> translators;
  List<ProjectMember> reviwers;


  ProjectFormState({this.file, required this.translators, required this.reviwers});

  ProjectFormState copyWith({File? file, List<ProjectMember>? translators, List<ProjectMember>? reviwers}) {
    return ProjectFormState(file: file ?? this.file, translators: translators ?? this.translators, reviwers: reviwers ?? this.reviwers);
  }
}