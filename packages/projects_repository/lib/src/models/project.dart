class Project {
  String? id;
  String name;
  String imageUrl;


  Project({this.id, required this.name, required this.imageUrl});

  Project.fromJson(Map<String, dynamic> json): this.id = json['id'], this.name = json['name'], this.imageUrl = json['imageUrl'];  
}