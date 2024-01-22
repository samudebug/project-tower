import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_repository/projects_repository.dart';
import 'package:projects_repository/src/models/project.dart';

class ProjectsRepository {

  final CollectionReference<Project> projectsCollection = FirebaseFirestore.instance.collection('projects').withConverter(fromFirestore: Project.fromFirestore, toFirestore: (Project project, _) => project.toFirestore());


  Future<List<Project>> getProjects(String userEmail) async {
    try {
      final Query<Map<String, dynamic>> membersCollection = FirebaseFirestore.instance.collectionGroup("members");
      final QuerySnapshot<Map<String, dynamic>> result = await membersCollection.where("username", isEqualTo: userEmail).get();
      final projects = await Future.wait(result.docs.map((e) async {
        final docData = await e.reference.parent.parent?.get();
        final project = Project.fromJson({"id": docData!.id, "role": e.data()['role'], ...docData.data()!});
        return project;
      }).toList());
      return projects;
    } catch (e) {
      log("Error while fetching projects", error: e);
      throw e;
    }
  }

  Future<Project> saveProject(Project project, String userId, String userEmail, List<ProjectMember> translators, List<ProjectMember> reviwers) async {
    final result = await projectsCollection.add(project);
    final membersCollection = result.collection("members");
    await membersCollection.add({'userId': userId, 'role': 'CREATOR', 'username': userEmail});
    Future.wait([
      ...translators.map((e) async => await membersCollection.add(e.toFirestore())),
      ...reviwers.map((e) async => await membersCollection.add(e.toFirestore())),
    ]);

    return project.copyWith(id: result.id);
  }

  Future<List<ProjectMember>> fetchMembersbyType(String projectId, RoleInProject role) async {
    final result = await projectsCollection.doc(projectId).collection("members").where("role", isEqualTo: role.name).get();
    final members = await Future.wait(result.docs.map((e) async {
      final data = e.data();
      return ProjectMember(role: role, username: data['username']);
    }).toList());
    return members;

  }
}