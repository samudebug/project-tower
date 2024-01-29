import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tasks_repository/tasks_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/setup.dart';
import 'package:tower_project/ui/pages/project_detail/cubit/project_detail_cubit.dart';
import 'package:tower_project/ui/pages/project_detail/widgets/task_item.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tower_project/ui/pages/project_form/edit_project_form_page.dart';
import 'package:tower_project/ui/pages/task_detail/task_detail_page.dart';
import 'package:tower_project/ui/widgets/user_menu.dart';

class ProjectDetailsPage extends StatelessWidget {
  ProjectDetailsPage({super.key, required this.project});
  Project project;
  static const pageName = "project_detail";

  onAddTask(BuildContext context) async {
    final cubit = context.read<ProjectDetailCubit>();
    final result = await showDialog<String>(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: const Text("Criar Tarefa"),
              content: TextField(
                controller: cubit.taskNameController,
                decoration: const InputDecoration(hintText: "Nome da Tarefa"),
              ),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: const Text('OK'),
                  onPressed: () {
                    String name = cubit.taskNameController.text;
                    Navigator.of(context).pop(name);
                  },
                ),
              ]);
        });
    if (result != null) {
      final task = await getIt<ProjectDetailCubit>().saveTask(
          project.id!,
          Task(
              name: result, status: TaskStatus.OPEN, createdAt: DateTime.now()),
          (getIt<AuthBloc>().state as AuthLogged).userModel.email);
      await Navigator.of(context).pushNamed(TaskDetailPage.pageName,
          arguments: {'project': project, 'task': task});
      context.read<ProjectDetailCubit>().init(project.id!);
    }
  }

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
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(EditProjectFormPage.pageName,
                    arguments: project);
              },
              icon: Icon(Icons.edit)),
          UserMenu()
        ],
      ),
      body: BlocBuilder<ProjectDetailCubit, ProjectDetailState>(
          builder: (context, state) {
        if (state is ProjectDetailReady) {
          return Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
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
                              onPressed: () => onAddTask(context),
                              icon: const Icon(Icons.add),
                              label: Text("Criar Tarefa",
                                  style:
                                      Theme.of(context).textTheme.labelMedium)),
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
                                  itemBuilder: (context, index) => InkWell(
                                        onTap: () async {
                                          await Navigator.of(context).pushNamed(
                                              TaskDetailPage.pageName,
                                              arguments: {
                                                'project': project,
                                                'task': state.tasks[index]
                                              });
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
                      child: Stack(alignment: Alignment.center, children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image(
                            image: NetworkImage(project.imageUrl),
                            fit: BoxFit.cover,
                            
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: Color(0xE63E3E3E)),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          bottom: 0,
                          right: 0,
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
    );
  }
}
