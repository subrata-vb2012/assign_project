import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String name;
  final String description;
  final GeoPoint location;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
  });

  factory ProjectModel.fromMap(String docId, Map<String, dynamic> data) {
    return ProjectModel(
      id: docId,
      name: data['name'],
      description: data['description'],
      location: data['location'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name' : this.name,
      'description' : description,
      'location' : location
    };
  }

  @override
  String toString() {
    return toMap().toString();
  }
}
