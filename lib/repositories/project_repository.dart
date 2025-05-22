import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/project_model.dart';

class ProjectRepository {
  final _db = FirebaseFirestore.instance;

  Future<List<ProjectModel>> fetchProjects() async {
    final snapshot = await _db.collection('projects').get();
    return snapshot.docs.map((doc) => ProjectModel.fromMap(doc.id, doc.data())).toList();
  }

  Future<void> addProject(ProjectModel project) async {
    await _db.collection('projects').add(project.toMap());
  }

  Future<void> deleteProject(String id) async {
    await _db.collection('projects').doc(id).delete();
  }

  Future<void> updateProject(ProjectModel project) async {
    await _db.collection('projects').doc(project.id).update(project.toMap());
  }

  Stream<List<ProjectModel>> streamProjects() {
    return _db
        .collection('projects')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => ProjectModel.fromMap(doc.id, doc.data())).toList());
  }


}
