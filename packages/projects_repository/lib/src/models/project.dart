import 'package:cloud_firestore/cloud_firestore.dart';

enum RoleInProject { CREATOR, TRANSLATOR, REVIEWER }

class Project {
  String? id;
  String name;
  String imageUrl;
  RoleInProject role;

  Project(
      {this.id,
      required this.name,
      required this.imageUrl,
      required this.role});

  Project.fromJson(Map<String, dynamic> json)
      : this.id = json['id'],
        this.name = json['name'],
        this.imageUrl = json['imageUrl'],
        this.role = RoleInProject.values.byName(json['role']);

  factory Project.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return Project(
        id: snapshot.id,
        name: data?['name'],
        imageUrl: data?['imageUrl'],
        role: RoleInProject.CREATOR);
  }

  Map<String, dynamic> toFirestore() {
    return {'name': name, 'imageUrl': imageUrl};
  }

  Project copyWith(
      {String? id, String? name, String? imageUrl, RoleInProject? role}) {
    return Project(
        id: id ?? this.id,
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        role: role ?? this.role);
  }
}
