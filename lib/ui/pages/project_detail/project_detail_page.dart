import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/ui/pages/project_detail/cubit/project_detail_cubit.dart';
import 'package:tower_project/ui/pages/project_detail/widgets/task_item.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tower_project/ui/pages/task_detail/task_detail_page.dart';

import '../../widgets/logout_button.dart';

class ProjectDetailsPage extends StatelessWidget {
  ProjectDetailsPage({super.key, required this.project});
  Project project;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          project.name,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          MenuAnchor(
            menuChildren: [
              LogoutButton(onPressed: () {
                context.read<AuthBloc>().add(AuthLogout());
              },)
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
      body: BlocProvider(
        create: (context) => ProjectDetailCubit(taskRepository: context.read())
          ..init(project.id!),
        child: BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
            builder: (context, state) {
          if (state is ProjectDetailReady) {
            return Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Tarefas",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                TextButton.icon(
                                    onPressed: () async {
                                      final cubit =
                                          context.read<ProjectDetailCubit>();
                                      final result = await showDialog<String>(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                                title:
                                                    const Text("Criar Tarefa"),
                                                content: TextField(
                                                  controller:
                                                      cubit.taskNameController,
                                                  decoration:
                                                      const InputDecoration(
                                                          hintText:
                                                              "Nome da Tarefa"),
                                                ),
                                                actions: <Widget>[
                                                  MaterialButton(
                                                    color: Colors.green,
                                                    textColor: Colors.white,
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      String name = cubit
                                                          .taskNameController
                                                          .text;
                                                      Navigator.of(context)
                                                          .pop(name);
                                                    },
                                                  ),
                                                ]);
                                          });
                                      if (result != null) {
                                        final task = await context
                                            .read<ProjectDetailCubit>()
                                            .saveTask(
                                                project.id!,
                                                Task(
                                                    name: result,
                                                    status: TaskStatus.OPEN,
                                                    createdAt: DateTime.now()));
                                        context
                                            .read<ProjectDetailCubit>()
                                            .init(project.id!);
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    TaskDetailPage(
                                                      task: task,
                                                      project: project,
                                                    )));
                                      }
                                      log(result ?? "");
                                    },
                                    icon: const Icon(Icons.add),
                                    label: Text("Criar Tarefa",
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium)),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 9,
                            child: Container(
                                child: state.tasks.isEmpty
                                    ? const Center(
                                        child: Text("Sem tarefas"),
                                      )
                                    : ListView.builder(
                                        itemCount: state.tasks.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            TaskDetailPage(
                                                              task: state
                                                                  .tasks[index],
                                                              project:
                                                                  project,
                                                            )));
                                              },
                                              child: TaskItem(
                                                task: state.tasks[index],
                                              ),
                                            ))),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          child: Center(
                            child: Stack(children: [
                              Image(
                                image: NetworkImage(project.imageUrl),
                                fit: BoxFit.cover,
                              ),
                              Container(
                                color: const Color(0xE63E3E3E),
                              ),
                              Center(
                                child: CircularPercentIndicator(
                                  radius: 50,
                                  lineWidth: 8,
                                  percent: ((state.tasks.where((element) =>
                                              element.status ==
                                              TaskStatus.APPROVED)).length *
                                          100 /
                                          state.tasks.length) /
                                      100,
                                  progressColor: Colors.blue,
                                  center: Text(
                                    "${(((state.tasks.where((element) => element.status == TaskStatus.APPROVED)).length * 100 / state.tasks.length)).toStringAsFixed(1)}%",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(color: Colors.white),
                                  ),
                                ),
                              )
                            ]),
                          ),
                        )),
                  )
                ]);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}
