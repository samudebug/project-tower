import 'package:flutter/material.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/task_detail_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/widgets/task_message.dart';
import 'package:tower_project/ui/widgets/status_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({super.key, required this.task, required this.project});
  final Task task;
  final Project project;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late final TaskDetailCubit cubit = TaskDetailCubit(
      taskRepository: context.read(),
      projectsRepository: context.read(),
      task: widget.task);

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
        actions: [
          MenuAnchor(
            menuChildren: [
              MenuItemButton(
                  child: Row(
                children: [
                  const Icon(Icons.logout),
                  Text(
                    "Logout",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const SizedBox(
                    width: 50,
                  )
                ],
              ))
            ],
            builder: (context, controller, child) {
              return TextButton(
                  onPressed: () {
                    if (controller.isOpen) {
                      controller.close();
                    } else {
                      controller.open();
                    }
                  },
                  child: Icon(
                    Icons.person,
                    color: Theme.of(context).iconTheme.color,
                  ));
            },
          )
        ],
      ),
      body: BlocBuilder<TaskDetailCubit, TaskDetailState>(
          bloc: cubit,
          builder: (context, state) {
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
                                      padding:
                                          const EdgeInsets.only(bottom: 4.0),
                                      child: TaskStatusSelector(
                                        task: state.task,
                                        canOpen: widget.project.role ==
                                            RoleInProject.CREATOR,
                                        onChange: (TaskStatus status) {
                                          cubit.saveTask(
                                              widget.project.id!,
                                              state.task
                                                  .copyWith(status: status));
                                        },
                                      ),
                                    ),
                                    if (state.task.status ==
                                            TaskStatus.AWAITING_REVIEW &&
                                        (widget.project.role ==
                                                RoleInProject.CREATOR ||
                                            widget.project.role ==
                                                RoleInProject.REVIEWER))
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: ElevatedButton.icon(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.remove_red_eye),
                                            label: Text("Revisar",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelLarge)),
                                      ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(state.task.name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleLarge),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        child: Text(
                                            "Aberto a uma semana por GunsBlazin",
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium),
                                      )
                                    ]),
                              )
                            ]),
                      ),
                      Flexible(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const TextField(
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                      hintText: "Digite uma mensagem..."),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      itemCount: 3,
                                      itemBuilder: (context, index) =>
                                          const Padding(
                                            padding: EdgeInsets.all(8),
                                            child: TaskMessage(),
                                          )),
                                )
                              ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Flexible(
                flex: 2,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TaskMembersSection(
                            title: "Tradutor(es)",
                            onAdd: () async {
                              final members = await cubit.fetchMembers(
                                  RoleInProject.TRANSLATOR, widget.project.id!);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Selecionar Membro"),
                                        content: Container(
                                          width: double.maxFinite,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: members.length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        ListTile(
                                                          title: Text(members[index].username),
                                                        )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                        Expanded(
                          child: TaskMembersSection(
                            title: "Revisor(es)",
                            onAdd: () async {
                              final members = await cubit.fetchMembers(
                                  RoleInProject.REVIEWER, widget.project.id!);
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                        title: Text("Selecionar Membro"),
                                        content: Container(
                                          width: double.maxFinite,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Expanded(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: members.length,
                                                    itemBuilder: (context,
                                                            index) =>
                                                        ListTile(
                                                          title: Text(members[index].username),
                                                        )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ]);
          }),
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
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.OPEN);
                },
                child: TaskStatusChip(status: TaskStatus.OPEN)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.AWAITING_REVIEW);
                },
                child: TaskStatusChip(status: TaskStatus.AWAITING_REVIEW)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.IN_REVIEW);
                },
                child: TaskStatusChip(status: TaskStatus.IN_REVIEW)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.APPROVED);
                },
                child: TaskStatusChip(status: TaskStatus.APPROVED)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
                onPressed: () {
                  onChange(TaskStatus.CLOSED);
                },
                child: TaskStatusChip(status: TaskStatus.CLOSED)),
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
      {super.key, required this.title, required this.onAdd});

  final String title;
  final void Function()? onAdd;

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
      Text(
        "Sem ${title.toLowerCase()} selecionados",
        style: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.grey[500]),
      )
    ]);
  }
}
