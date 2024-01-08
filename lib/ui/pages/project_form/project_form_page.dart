import 'package:flutter/material.dart';
import 'package:tower_project/ui/pages/project_form/widgets/members_form.dart';
import 'package:tower_project/ui/pages/project_form/widgets/name_image_form.dart';

class ProjectFormPage extends StatelessWidget {
  ProjectFormPage({super.key});
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.decelerate);
        },
        label: Text(
          "Próximo",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        icon: Icon(Icons.keyboard_arrow_right),
      ),
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
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
      body: PageView(controller: controller, children: [NameImageForm(), MembersForm()],),
    );
  }
}
