import 'package:flutter/material.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/ui/pages/task_detail/cubit/task_detail_cubit.dart';
import 'package:tower_project/ui/pages/task_detail/widgets/task_message.dart';
import 'package:tower_project/ui/widgets/status_chip.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TaskDetailPage extends StatefulWidget {
  TaskDetailPage({super.key, required this.task, required this.projectId});
  final Task task;
  final String projectId;

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  late final TaskDetailCubit cubit = TaskDetailCubit(taskRepository: context.read(), task: widget.task);

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
                                    padding: const EdgeInsets.only(bottom: 4.0),
                                    child: TaskStatusSelector(task: state.task, onChange: (TaskStatus status) {
                                      cubit.saveTask(widget.projectId, state.task.copyWith(status: status));
                                    },),
                                  ),
                                  if (state.task.status == TaskStatus.AWAITING_REVIEW) Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: const Icon(Icons.remove_red_eye),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
                                      child: Text(state.task.name,
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 8),
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
                                    itemBuilder: (context, index) => const Padding(
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
                  child: const Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TaskMembersSection(
                            title: "Tradutor(es)",
                          ),
                        ),
                        Expanded(
                          child: TaskMembersSection(
                            title: "Revisor(es)",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                )
          ]);
        }
      ),
    );
  }
}

class TaskStatusSelector extends StatelessWidget {
  const TaskStatusSelector({
    super.key,
    required this.task,
    required this.onChange
  });

  final Task task;
  final Function(TaskStatus status) onChange;

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
                child: TaskStatusChip(
                    status: TaskStatus.OPEN)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
              onPressed: () {
                onChange(TaskStatus.AWAITING_REVIEW);
              },
                child: TaskStatusChip(
                    status:
                        TaskStatus.AWAITING_REVIEW)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
              onPressed: () {
                onChange(TaskStatus.IN_REVIEW);
              },
                child: TaskStatusChip(
                    status: TaskStatus.IN_REVIEW)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
              onPressed: () {
                onChange(TaskStatus.APPROVED);
              },
                child: TaskStatusChip(
                    status: TaskStatus.APPROVED)),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: MenuItemButton(
              onPressed: () {
                onChange(TaskStatus.CLOSED);
              },
                child: TaskStatusChip(
                    status: TaskStatus.CLOSED)),
          )
        ],
        builder: (context, controller, child) {
          return InkWell(
            onTap: () {
              if (!controller.isOpen) {
                controller.open();
              }
            },
            child: TaskStatusChip(
                status: task.status),
          );
        });
  }
}

class TaskMembersSection extends StatelessWidget {
  const TaskMembersSection({super.key, required this.title});

  final String title;

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
          IconButton(onPressed: () {}, icon: const Icon(Icons.add))
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
