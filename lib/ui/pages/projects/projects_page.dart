import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/blocs/projects_bloc/projects_bloc.dart';
import 'package:tower_project/ui/pages/project_detail/project_detail_page.dart';
import 'package:tower_project/ui/pages/project_form/project_form_page.dart';
import 'package:tower_project/ui/pages/projects/widgets/project_card.dart';
import 'package:tower_project/ui/widgets/logout_button.dart';
import 'package:tower_project/ui/widgets/user_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ProjectsBloc>().add(LoadProjects(userEmail: (context.read<AuthBloc>().state as AuthLogged).userModel.email));
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          "Projetos",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(onPressed: () {
            context.read<ProjectsBloc>().add(LoadProjects(userEmail: (context.read<AuthBloc>().state as AuthLogged).userModel.email));
          }, icon: Icon(Icons.refresh)),
          IconButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ProjectFormPage()));
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              )),
          MenuAnchor(
            menuChildren: [
              UserCard(),
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
      body: BlocBuilder<ProjectsBloc, ProjectsState>(builder: (context, state) {
        if (state is ProjectsReady) {
          if (state.projects.isEmpty) {
            return const Center(child: Text("Sem projetos cadastrados. Você pode criar um projeto clicando no +"),);
          }
          return GridView.count(
              crossAxisCount: 7,
              children: state.projects
                  .map((e) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: () => {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProjectDetailsPage(project: e,)))
                                },
                            child: ProjectCard(project: e)),
                      ))
                  .toList());
        }
        if (state is ProjectsFailed) {
          return Center(
            child: Column(children: [
              const Icon(
                Icons.info,
                size: 40,
                color: Colors.red,
              ),
              Text(
                "Um erro ocorreu",
                style: Theme.of(context).textTheme.displayLarge,
              )
            ]),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }
}
