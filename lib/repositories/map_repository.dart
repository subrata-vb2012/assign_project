import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/project_model.dart';

class MapRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProjectModel>> fetchProjects() async {
    final snapshot = await _db.collection('projects').get();
    return snapshot.docs.map((doc) => ProjectModel.fromMap(doc.id, doc.data())).toList();
  }
}
