import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_repository/projects_repository.dart';

class ProjectMember {
  String? id;
  String? userId;
  RoleInProject role;
  String username;

  ProjectMember({this.userId, this.id, required this.role, required this.username});

  factory ProjectMember.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? opetions) {
    final data = snapshot.data();
    return ProjectMember(userId: data?['userId'], id: snapshot.id, role: RoleInProject.values.byName(data!['role']), username: data['username']);
  }

  Map<String, dynamic> toFirestore() {
    return {'userId': userId, 'role': role.name, 'username': username};
  }
}