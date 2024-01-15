import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_repository/tasks_repository.dart';

part 'project_detail_state.dart';

class ProjectDetailCubit extends Cubit<ProjectDetailState> {
  ProjectDetailCubit({required this.taskRepository}): super(ProjectDetailInitial());
  TaskRepository taskRepository;
  TextEditingController taskNameController = TextEditingController();
  init(String projectId) async {
    emit(ProjectDetailLoading());
    final result = await taskRepository.getTasks(projectId);
    emit(ProjectDetailReady(tasks: result));
  }

  saveTask(String projectId, Task task) async {
    final result = await taskRepository.saveTask(projectId, task);
    return result;
  }
}