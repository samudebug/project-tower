import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
part 'task_detail_state.dart';

class TaskDetailCubit extends Cubit<TaskDetailState> {
  TaskDetailCubit(
      {required this.taskRepository,
      required this.projectsRepository,
      required Task task})
      : super(TaskDetailState(task, [], [], [], [],
            TaskMember(role: RoleInTask.CREATOR, username: "")));
  final TaskRepository taskRepository;
  final ProjectsRepository projectsRepository;
  saveTask(String projectId, Task task) async {
    await taskRepository.updateTask(projectId, task);
    emit(state.copyWith(task: task));
  }

  Future<void> fetchTaskMembers(String projectId, String taskId) async {
    final members = await taskRepository.fetchTaskMembers(projectId, taskId);
    final translators = members
        .where((element) => element.role == RoleInTask.TRANSLATOR)
        .toList();
    final reviewers = members
        .where((element) => element.role == RoleInTask.REVIEWER)
        .toList();
    final creator = members.firstWhere((e) => e.role == RoleInTask.CREATOR);
    emit(
        state.copyWith(taskTranslators: translators, taskReviewers: reviewers, creator: creator));
  }

  Future<List<ProjectMember>> fetchMembers(
      RoleInProject role, String projectId) async {
    final members =
        await projectsRepository.fetchMembersbyType(projectId, role);
    if (role == RoleInProject.TRANSLATOR) {
      state.reviewers.addAll(members);
      emit(state.copyWith(translators: state.translators));
    } else {
      state.reviewers.addAll(members);
      emit(state.copyWith(reviewers: state.reviewers));
    }
    return members;
  }

  Future<void> addMember(
      String projectId, String taskId, TaskMember member) async {
    await taskRepository.addMemberToTask(projectId, taskId, member);
    await fetchMembers(RoleInProject.TRANSLATOR, projectId);
    await fetchMembers(RoleInProject.REVIEWER, projectId);
    await fetchTaskMembers(projectId, taskId);
  }

  Future<void> removeMember(
      String projectId, String taskId, String memberId) async {
    await taskRepository.removeTaskMember(projectId, taskId, memberId);
    await fetchTaskMembers(projectId, taskId);
  }

  Future<void> updateTask(String projectId, Task task) async {
    final newTask = await taskRepository.updateTask(projectId, task);
    emit(state.copyWith(task: newTask));
  }
}
