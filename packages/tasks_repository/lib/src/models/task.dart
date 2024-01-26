import 'package:cloud_firestore/cloud_firestore.dart';

enum TaskStatus {
  OPEN,
  WORKING,
  AWAITING_REVIEW,
  IN_REVIEW,
  APPROVED,
  CLOSED
}
enum RoleInTask { CREATOR, TRANSLATOR, REVIEWER }
class Task {
  String? id;
  String name;
  TaskStatus status;
  DateTime createdAt;
  
  Task({this.id, required this.name, required this.status, required this.createdAt});

  factory Task.fromFirestore(DocumentSnapshot<Map<String,dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Task(id: snapshot.id, name: data?['name'], status: TaskStatus.values.byName(data?['status'], ), createdAt: data?['createdAt'].toDate());
  }
  
  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'status': status.name,
      'createdAt': createdAt
    };
  }

  Task copyWith({String? id, String? name, TaskStatus? status, DateTime? createdAt}) {
    return Task(id: id ?? this.id, name: name ?? this.name, status: status ?? this.status, createdAt: createdAt ?? this.createdAt);
  }
}