import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projects_repository/projects_repository.dart';

class TaskMember {
  String? id;
  String? userId;
  RoleInProject role;
  String username;

  TaskMember({this.id,this.userId, required this.role, required this.username});

  factory TaskMember.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? opetions) {
    final data = snapshot.data();
    return TaskMember(id: snapshot.id,userId: data?['userId'], role: RoleInProject.values.byName(data!['role']), username: data['username']);
  }

  Map<String, dynamic> toFirestore() {
    return {'userId': userId, 'role': role.name, 'username': username};
  }
}