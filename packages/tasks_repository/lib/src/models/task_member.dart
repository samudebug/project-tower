import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasks_repository/src/models/task.dart';

class TaskMember {
  String? id;
  String? userId;
  RoleInTask role;
  String username;

  TaskMember({this.id,this.userId, required this.role, required this.username});

  factory TaskMember.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? opetions) {
    final data = snapshot.data();
    return TaskMember(id: snapshot.id,userId: data?['userId'], role: RoleInTask.values.byName(data!['role']), username: data['username']);
  }

  Map<String, dynamic> toFirestore() {
    return {'userId': userId, 'role': role.name, 'username': username};
  }
}