import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messages_repository/messages_repository.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/pages/project_detail/cubit/project_detail_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/messages_state.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/task_detail_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/widgets/task_message.dart';
import 'package:tower_project/ui/widgets/status_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/ui/widgets/user_menu.dart';

import 'widgets/messages_view.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});
  static const pageName = "task_detail";

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          "Tarefa",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [UserMenu()],
      ),
      body: BlocBuilder<TaskDetailCubit, TaskDetailState>(
          builder: (context, state) {
        if (state.project != null && state.task != null) {
          var canReview = state.task!.status == TaskStatus.AWAITING_REVIEW &&
              (state.project!.role == RoleInProject.CREATOR ||
                  state.project!.role == RoleInProject.REVIEWER);
          var canTranslate = state.task!.status == TaskStatus.OPEN &&
              state.taskTranslators.isEmpty &&
              (state.project!.role == RoleInProject.CREATOR ||
                  state.project!.role == RoleInProject.TRANSLATOR);
          var canStartReview = state.task!.status == TaskStatus.WORKING &&
              (state.project!.role == RoleInProject.CREATOR ||
                  (state.project!.role == RoleInProject.TRANSLATOR &&
                      state.taskTranslators.indexWhere((element) =>
                              element.username ==
                              (context.read<AuthBloc>().state as AuthLogged)
                                  .userModel
                                  .email) >
                          -1));
          var canApprove = state.task!.status == TaskStatus.IN_REVIEW &&
              (state.project!.role == RoleInProject.CREATOR ||
                  (state.project!.role == RoleInProject.REVIEWER &&
                      state.taskReviewers.indexWhere((element) =>
                              element.username ==
                              (context.read<AuthBloc>().state as AuthLogged)
                                  .userModel
                                  .email) >
                          -1));
          return Row(children: [
            Flexible(
              flex: 8,
              child: Container(
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: TaskStatusSelector(
                                      task: state.task!,
                                      canOpen: state.project!.role ==
                                          RoleInProject.CREATOR,
                                      onChange: (TaskStatus status) {
                                        context
                                            .read<TaskDetailCubit>()
                                            .saveTask(
                                                state.project!.id!,
                                                state.task!
                                                    .copyWith(status: status));
                                      },
                                    ),
                                  ),
                                  if (canReview) reviewButton(context, state),
                                  if (canTranslate)
                                    translateButton(context, state),
                                  if (canStartReview)
                                    startReviewButton(context, state),
                                  if (canApprove) approveButton(context, state)
                                ],
                              ),
                            ),
                            taskInfo(state, context)
                          ]),
                    ),
                    Flexible(
                      flex: 8,
                      child: MessagesView(),
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: TaskMembersSection(
                          members: state.taskTranslators,
                          title: "Tradutor(es)",
                          onRemove: (String memberId) async {
                            context.read<TaskDetailCubit>().removeMember(
                                state.project!.id!, state.task!.id!, memberId);
                          },
                          onAdd: () => onAddTranslator(state),
                        ),
                      ),
                      Expanded(
                        child: TaskMembersSection(
                          title: "Revisor(es)",
                          members: state.taskReviewers,
                          onRemove: (String memberId) async {
                            context.read<TaskDetailCubit>().removeMember(
                                state.project!.id!, state.task!.id!, memberId);
                          },
                          onAdd: () => onAddReviewer(state),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ]);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  onAddReviewer(TaskDetailState state) async {
    final members = await context
        .read<TaskDetailCubit>()
        .fetchMembers(RoleInProject.REVIEWER, state.project!.id!);
    final result = await showDialog<TaskMember>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Selecionar Membro"),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: members.length,
                          itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  final member = TaskMember(
                                      role: RoleInTask.REVIEWER,
                                      username: members[index].username);
                                  Navigator.pop(context, member);
                                },
                                title: Text(members[index].username),
                              )),
                    )
                  ],
                ),
              ),
            ));
    if (result != null) {
      context
          .read<TaskDetailCubit>()
          .addMember(state.project!.id!, state.task!.id!, result);
    }
  }

  onAddTranslator(TaskDetailState state) async {
    final members = await context
        .read<TaskDetailCubit>()
        .fetchMembers(RoleInProject.TRANSLATOR, state.project!.id!);
    final result = await showDialog<TaskMember>(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Selecionar Membro"),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: members.length,
                          itemBuilder: (context, index) => ListTile(
                                onTap: () {
                                  final member = TaskMember(
                                      role: RoleInTask.TRANSLATOR,
                                      username: members[index].username);
                                  Navigator.pop(context, member);
                                },
                                title: Text(members[index].username),
                              )),
                    )
                  ],
                ),
              ),
            ));
    if (result != null) {
      context
          .read<TaskDetailCubit>()
          .addMember(state.project!.id!, state.task!.id!, result);
    }
  }

  Padding taskInfo(TaskDetailState state, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(state.task?.name ?? "",
              style: Theme.of(context).textTheme.titleLarge),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
              "Aberto em ${DateFormat("dd/MM/yyyy").format(state.task!.createdAt)} por ${state.creator.username}",
              style: Theme.of(context).textTheme.titleMedium),
        )
      ]),
    );
  }

  Padding approveButton(BuildContext context, TaskDetailState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton.icon(
          onPressed: () async {
            context.read<TaskDetailCubit>().updateTask(state.project!.id!,
                state.task!.copyWith(status: TaskStatus.APPROVED));
          },
          icon: const Icon(Icons.check),
          label:
              Text("Aprovar", style: Theme.of(context).textTheme.labelLarge)),
    );
  }

  Padding startReviewButton(BuildContext context, TaskDetailState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton.icon(
          onPressed: () async {
            context.read<TaskDetailCubit>().updateTask(state.project!.id!,
                state.task!.copyWith(status: TaskStatus.AWAITING_REVIEW));
          },
          icon: const Icon(Icons.check),
          label: Text("Colocar para revisão",
              style: Theme.of(context).textTheme.labelLarge)),
    );
  }

  Padding translateButton(BuildContext context, TaskDetailState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton.icon(
          onPressed: () async {
            final member = TaskMember(
                role: RoleInTask.TRANSLATOR,
                username: (context.read<AuthBloc>().state as AuthLogged)
                    .userModel
                    .email);
            await context
                .read<TaskDetailCubit>()
                .addMember(state.project!.id!, state.task!.id!, member);
            context.read<TaskDetailCubit>().updateTask(state.project!.id!,
                state.task!.copyWith(status: TaskStatus.WORKING));
          },
          icon: const Icon(Icons.edit),
          label:
              Text("Traduzir", style: Theme.of(context).textTheme.labelLarge)),
    );
  }

  Padding reviewButton(BuildContext context, TaskDetailState state) {
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ElevatedButton.icon(
          onPressed: () {
            final member = TaskMember(
                role: RoleInTask.REVIEWER,
                username: (context.read<AuthBloc>().state as AuthLogged)
                    .userModel
                    .email);
            context
                .read<TaskDetailCubit>()
                .addMember(state.project!.id!, state.task!.id!, member);
            context.read<TaskDetailCubit>().updateTask(state.project!.id!,
                state.task!.copyWith(status: TaskStatus.IN_REVIEW));
          },
          icon: const Icon(Icons.remove_red_eye),
          label:
              Text("Revisar", style: Theme.of(context).textTheme.labelLarge)),
    );
  }
}

class TaskStatusSelector extends StatelessWidget {
  const TaskStatusSelector(
      {super.key,
      required this.task,
      required this.onChange,
      required this.canOpen});

  final Task task;
  final Function(TaskStatus status) onChange;
  final bool canOpen;

  @override
  Widget build(BuildContext context) {
    return MenuAnchor(
        menuChildren: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.OPEN);
                },
                child: const TaskStatusChip(status: TaskStatus.OPEN)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.WORKING);
                },
                child: const TaskStatusChip(status: TaskStatus.WORKING)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.AWAITING_REVIEW);
                },
                child:
                    const TaskStatusChip(status: TaskStatus.AWAITING_REVIEW)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.IN_REVIEW);
                },
                child: const TaskStatusChip(status: TaskStatus.IN_REVIEW)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.APPROVED);
                },
                child: const TaskStatusChip(status: TaskStatus.APPROVED)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.CLOSED);
                },
                child: const TaskStatusChip(status: TaskStatus.CLOSED)),
          )
        ],
        builder: (context, controller, child) {
          return InkWell(
            onTap: () {
              if (!controller.isOpen && canOpen) {
                controller.open();
              }
            },
            child: TaskStatusChip(status: task.status),
          );
        });
  }
}

class TaskMembersSection extends StatelessWidget {
  const TaskMembersSection(
      {super.key,
      required this.title,
      required this.onAdd,
      required this.members,
      required this.onRemove});

  final String title;
  final void Function()? onAdd;
  final List<TaskMember> members;
  final void Function(String username) onRemove;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          IconButton(onPressed: onAdd, icon: const Icon(Icons.add))
        ],
      ),
      if (members.isEmpty)
        Text(
          "Sem ${title.toLowerCase()} selecionados",
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.grey[500]),
        )
      else
        Expanded(
          child: ListView.builder(
              itemCount: members.length,
              itemBuilder: (context, index) => ListTile(
                    title: Text(members[index].username),
                    trailing: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () {
                        onRemove(members[index].id!);
                      },
                    ),
                  )),
        )
    ]);
  }
}
