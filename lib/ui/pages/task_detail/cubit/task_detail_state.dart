part of 'task_detail_cubit.dart';

class TaskDetailState {
  final Task task;
  final List<ProjectMember> translators;
  final List<ProjectMember> reviewers;
  final List<TaskMember> taskTranslators;
  final List<TaskMember> taskReviewers;
  final TaskMember creator;
  const TaskDetailState(this.task, this.translators, this.reviewers,
      this.taskTranslators, this.taskReviewers, this.creator);

  TaskDetailState copyWith(
      {Task? task,
      List<ProjectMember>? translators,
      List<ProjectMember>? reviewers,
      List<TaskMember>? taskTranslators,
      List<TaskMember>? taskReviewers,
      TaskMember? creator}) {
    return TaskDetailState(
        task ?? this.task,
        translators ?? this.translators,
        reviewers ?? this.reviewers,
        taskTranslators ?? this.taskTranslators,
        taskReviewers ?? this.taskReviewers,
        creator ?? this.creator);
  }
}
