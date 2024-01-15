import 'package:flutter/material.dart';
import 'package:projects_repository/projects_repository.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key, required this.project});
  final Project project;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 9,
          child: AspectRatio(
            aspectRatio: 1/2,
            child: project.imageUrl.isEmpty
                ? Container(color: Colors.grey[400],)
                : Image(image: NetworkImage(project.imageUrl), fit: BoxFit.cover,),
          ),
        ),
        Flexible(
            child: Text(
          project.name,
          style: Theme.of(context).textTheme.titleMedium,
        ))
      ],
    );
  }
}
