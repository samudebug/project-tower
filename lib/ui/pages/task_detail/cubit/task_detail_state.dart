part of 'task_detail_cubit.dart';
class TaskDetailState {
  final Task task;
  final List<ProjectMember> translators;
  final List<ProjectMember> reviewers;
  const TaskDetailState(this.task, this.translators, this.reviewers);

  TaskDetailState copyWith({Task? task, List<ProjectMember>? translators, List<ProjectMember>? reviewers}) {
    return TaskDetailState(task ?? this.task, translators ?? this.translators, reviewers ?? this.reviewers);
  }
}