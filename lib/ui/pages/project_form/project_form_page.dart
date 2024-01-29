import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tower_project/blocs/auth_bloc/auth_bloc.dart';
import 'package:tower_project/ui/pages/project_form/cubit/project_form_cubit.dart';
import 'package:tower_project/ui/pages/project_form/widgets/members_form.dart';
import 'package:tower_project/ui/pages/project_form/widgets/name_image_form.dart';
import 'package:tower_project/ui/widgets/user_menu.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});
  static const pageName = "project_form";
  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final PageController controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: currentPage == 0,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        if (currentPage == 1) {
          controller.previousPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.decelerate);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (currentPage == 0) {
              controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.decelerate);
            }
            if (currentPage == 1) {
              await context.read<ProjectFormCubit>().saveProject(
                  (context.read<AuthBloc>().state as AuthLogged).userModel.id,
                  (context.read<AuthBloc>().state as AuthLogged)
                      .userModel
                      .email);
              Navigator.of(context).pop();
            }
          },
          label: Text(
            currentPage == 1 ? "Finalizar" : "Próximo",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          icon: currentPage == 1
              ? const Icon(Icons.check)
              : const Icon(Icons.keyboard_arrow_right),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (currentPage == 1) {
                controller.previousPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.decelerate);
              } else {
                Navigator.of(context).pop();
              }
            },
          ),
          title: Text(
            "Novo Projeto",
            style: Theme.of(context).textTheme.titleLarge,
          ),
          actions: [
            UserMenu()
          ],
        ),
        body: PageView(
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          controller: controller,
          children: const [NameImageForm(), MembersForm()],
        ),
      ),
    );
  }
}
