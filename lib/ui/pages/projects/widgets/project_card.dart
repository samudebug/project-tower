import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Expanded(flex: 9, child: Image(image: NetworkImage("https://cdn.cloudflare.steamstatic.com/steam/apps/1687950/library_600x900.jpg")),),
        Expanded(child: Text("Persona 5 Royal", style: Theme.of(context).textTheme.titleMedium,))
      ],
    );
  }
}