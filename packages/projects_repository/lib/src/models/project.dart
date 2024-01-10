import 'package:cloud_firestore/cloud_firestore.dart';

class Project {
  String? id;
  String name;
  String imageUrl;


  Project({this.id, required this.name, required this.imageUrl});

  Project.fromJson(Map<String, dynamic> json): this.id = json['id'], this.name = json['name'], this.imageUrl = json['imageUrl'];

  factory Project.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot, SnapshotOptions? options) {
    final data = snapshot.data();
    return Project(id: snapshot.id, name: data?['name'], imageUrl: data?['imageUrl']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'imageUrl': imageUrl
    };
  }

  Project copyWith({String? id, String? name, String? imageUrl}) {
    return Project(id: id ?? this.id, name: name ?? this.name, imageUrl: imageUrl ?? this.imageUrl);
  }
}