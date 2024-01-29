import 'package:flutter/material.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:tower_project/ui/pages/project_form/widgets/members_form.dart';
import 'package:tower_project/ui/pages/project_form/widgets/name_image_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProjectFormPage extends StatefulWidget {
  const EditProjectFormPage({super.key});
  static const pageName = "edit_project";
  @override
  State<EditProjectFormPage> createState() => _EditProjectFormPageState();
}

class _EditProjectFormPageState extends State<EditProjectFormPage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () async {
              await context.read<ProjectFormCubit>().saveProject(
                  (context.read<AuthBloc>().state as AuthLogged).userModel.id,
                  (context.read<AuthBloc>().state as AuthLogged)
                      .userModel
                      .email);
              Navigator.pop(context);
            },
            label: Text(
              "Salvar",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            icon: const Icon(Icons.check),
          ),
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "Nome e Imagem",
                ),
                Tab(
                  text: "Equipe",
                )
              ],
            ),
          ),
          body: TabBarView(children: [NameImageForm(), MembersForm()]),
        ));
  }
}
