import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  TaskDetailCubit({required this.taskRepository, required this.projectsRepository, required Task task}) : super(TaskDetailState(task, [], []));
  final TaskRepository taskRepository;
  final ProjectsRepository projectsRepository;
  saveTask(String projectId,Task task) async {
    await taskRepository.updateTask(projectId, task);
    emit(state.copyWith(task: task));
  }

  Future<List<ProjectMember>> fetchMembers(RoleInProject role, String projectId) async {
    final members = await projectsRepository.fetchMembersbyType(projectId, role);
    if (role == RoleInProject.TRANSLATOR) {
      state.reviewers.addAll(members);
      emit(state.copyWith(translators: state.translators));
    } else {
      state.reviewers.addAll(members);
      emit(state.copyWith(reviewers: state.reviewers));
    }
    return members;
  }
}