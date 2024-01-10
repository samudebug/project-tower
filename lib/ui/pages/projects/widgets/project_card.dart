import 'package:flutter/material.dart';
import 'package:projects_repository/projects_repository.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(flex: 9, child: Image(image: NetworkImage(project.imageUrl)),),
        Expanded(child: Text(project.name, style: Theme.of(context).textTheme.titleMedium,))
      ],
    );
  }
}