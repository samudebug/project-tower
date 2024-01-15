part of 'project_form_cubit.dart';

class ProjectFormState {
  File? file;

  ProjectFormState({this.file});

  ProjectFormState copyWith({File? file}) {
    return ProjectFormState(file: file ?? this.file);
  }
}