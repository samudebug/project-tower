import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks_repository/tasks_repository.dart';
part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  TaskDetailCubit({required this.taskRepository, required Task task}) : super(TaskDetailState(task));
  final TaskRepository taskRepository;

  saveTask(String projectId,Task task) async {
    await taskRepository.updateTask(projectId, task);
    emit(TaskDetailState(task));
  }
}