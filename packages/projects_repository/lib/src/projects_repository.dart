import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_repository/src/models/project.dart';

class ProjectsRepository {

  final CollectionReference<Project> projectsCollection = FirebaseFirestore.instance.collection('projects').withConverter(fromFirestore: Project.fromFirestore, toFirestore: (Project project, _) => project.toFirestore());

  Future<List<Project>> getProjects() async {
    try {
      final result = await projectsCollection.get();
      return result.docs.map((e) => e.data()).toList();
    } catch (e) {
      log("Error while fetching projects", error: e);
      throw e;
    }
  }

  Future<Project> saveProject(Project project) async {
    final result = await projectsCollection.add(project);
    return project.copyWith(id: result.id);
  }
}