import 'package:flutter/material.dart';
import 'package:tower_project/ui/pages/project_form/widgets/members_form.dart';
import 'package:tower_project/ui/pages/project_form/widgets/name_image_form.dart';

class ProjectFormPage extends StatefulWidget {
  ProjectFormPage({super.key});

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
              duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            controller.nextPage(
                duration: Duration(milliseconds: 500),
                curve: Curves.decelerate);
          },
          label: Text(
            currentPage == 1 ? "Finalizar" : "Próximo",
            style: Theme.of(context).textTheme.titleSmall,
          ),
          icon: currentPage == 1
              ? Icon(Icons.check)
              : Icon(Icons.keyboard_arrow_right),
        ),
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              if (currentPage == 1) {
                controller.previousPage(
                    duration: Duration(milliseconds: 500),
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
            MenuAnchor(
              menuChildren: [
                MenuItemButton(
                    child: Row(
                  children: [
                    Icon(Icons.logout),
                    Text(
                      "Logout",
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    SizedBox(
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
        body: PageView(
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          controller: controller,
          children: [NameImageForm(), MembersForm()],
        ),
      ),
    );
  }
}
