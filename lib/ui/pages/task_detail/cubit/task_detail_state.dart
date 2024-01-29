part of 'task_detail_cubit.dart';

class TaskDetailState {
  final Task? task;
  final Project? project;
  final List<ProjectMember> translators;
  final List<ProjectMember> reviewers;
  final List<TaskMember> taskTranslators;
  final List<TaskMember> taskReviewers;
  final TaskMember creator;
  const TaskDetailState({this.task, this.project, required this.translators, required this.reviewers,
      required this.taskTranslators, required this.taskReviewers, required this.creator});

  TaskDetailState copyWith(
      {Task? task,
      Project? project,
      List<ProjectMember>? translators,
      List<ProjectMember>? reviewers,
      List<TaskMember>? taskTranslators,
      List<TaskMember>? taskReviewers,
      TaskMember? creator}) {
    return TaskDetailState(
        task: task ?? this.task,
        project: project ?? this.project,
        translators: translators ?? this.translators,
        reviewers: reviewers ?? this.reviewers,
        taskTranslators: taskTranslators ?? this.taskTranslators,
        taskReviewers: taskReviewers ?? this.taskReviewers,
        creator: creator ?? this.creator);
  }
}

