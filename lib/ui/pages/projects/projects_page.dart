import 'package:flutter/material.dart';
import 'package:tower_project/ui/pages/project_form/project_form_page.dart';
import 'package:tower_project/ui/pages/projects/widgets/project_card.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProjectFormPage()));
              },
              icon: Icon(
                Icons.add,
                color: Theme.of(context).iconTheme.color,
              )),
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
                  SizedBox(width: 50,)
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
                  child: Icon(Icons.person, color: Theme.of(context).iconTheme.color,));
            },
          )
        ],
      ),
      body: GridView.count(crossAxisCount: 7, children: [ProjectCard(),ProjectCard(),ProjectCard(),ProjectCard(),]),
    );
  }
}
