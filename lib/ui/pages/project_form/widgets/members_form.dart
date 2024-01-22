import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';

class MembersForm extends StatefulWidget {
  const MembersForm({super.key});

  @override
  State<MembersForm> createState() => _MembersFormState();
}

class _MembersFormState extends State<MembersForm> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectFormCubit, ProjectFormState>(
        builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Tradutores",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final cubit =
                                        context.read<ProjectFormCubit>();
                                    final result = await showDialog<String>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: const Text("Criar Tarefa"),
                                              content: TextField(
                                                controller:
                                                    cubit.addMemberController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Email do membro"),
                                              ),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    String name = cubit
                                                        .addMemberController
                                                        .text;
                                                    Navigator.of(context)
                                                        .pop(name);
                                                  },
                                                ),
                                              ]);
                                        });
                                    cubit.addMemberController.clear();
                                    if (result != null) {
                                      final newMember = ProjectMember(
                                          role: RoleInProject.TRANSLATOR,
                                          username: result);
                                      cubit.saveMember(newMember);
                                    }
                                  },
                                  icon: const Icon(Icons.person_add))
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        if (state.translators.isEmpty)
                          Center(
                              child: Text(
                                  "Sem tradutores. Você pode adicionar um clicando no +",
                                  style:
                                      Theme.of(context).textTheme.titleMedium))
                        else
                          ...state.translators.map((e) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                ),
                                title: Text(
                                  e.username,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    context
                                        .read<ProjectFormCubit>()
                                        .removeMember(RoleInProject.TRANSLATOR,
                                            state.translators.indexOf(e));
                                  },
                                ),
                              ))
                      ],
                    )),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(5)),
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Revisores",
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              IconButton(
                                  onPressed: () async {
                                    final cubit =
                                        context.read<ProjectFormCubit>();
                                    final result = await showDialog<String>(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              title: const Text(
                                                  "Adicionar Membro"),
                                              content: TextField(
                                                controller:
                                                    cubit.addMemberController,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration:
                                                    const InputDecoration(
                                                        hintText:
                                                            "Email do membro"),
                                              ),
                                              actions: <Widget>[
                                                MaterialButton(
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  child: const Text('OK'),
                                                  onPressed: () {
                                                    String name = cubit
                                                        .addMemberController
                                                        .text;
                                                    Navigator.of(context)
                                                        .pop(name);
                                                  },
                                                ),
                                              ]);
                                        });
                                    cubit.addMemberController.clear();
                                    if (result != null) {
                                      final newMember = ProjectMember(
                                          role: RoleInProject.REVIEWER,
                                          username: result);
                                      cubit.saveMember(newMember);
                                    }
                                  },
                                  icon: const Icon(Icons.person_add))
                            ],
                          ),
                        ),
                        const Divider(
                          height: 2,
                        ),
                        if (state.reviwers.isEmpty)
                          Center(
                              child: Text(
                                  "Sem revisores. Você pode adicionar um clicando no +",
                                  style:
                                      Theme.of(context).textTheme.titleMedium))
                        else
                          ...state.reviwers.map((e) => ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.grey[200],
                                ),
                                title: Text(
                                  e.username,
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                trailing: IconButton(
                                  icon: const Icon(Icons.clear),
                                  onPressed: () {
                                    context
                                        .read<ProjectFormCubit>()
                                        .removeMember(RoleInProject.REVIEWER,
                                            state.translators.indexOf(e));
                                  },
                                ),
                              ))
                      ],
                    )),
              ),
            ),
          ],
        ),
      );
    });
  }
}
