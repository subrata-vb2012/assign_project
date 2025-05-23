// lib/models/project_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectModel {
  final String id;
  final String name;
  final String description;
  final GeoPoint location;
  final double budget;

  ProjectModel({
    required this.id,
    required this.name,
    required this.description,
    required this.location,
    required this.budget,
  });

  factory ProjectModel.fromMap(String id, Map<String, dynamic> data) {
    return ProjectModel(
      id: id,
      name: data['name'] ?? '',
      description: data['description'] ?? '',
      location: data['location'] ?? const GeoPoint(0, 0),
      budget: (data['budget'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'location': location,
      'budget': budget,
    };
  }
}
