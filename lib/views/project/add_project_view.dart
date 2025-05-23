import 'package:assign_project_s/models/project_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../repositories/project_repository.dart';

class AddProjectView extends StatelessWidget {
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final latController = TextEditingController();
  final lngController = TextEditingController();
  final budgetController = TextEditingController();

  final repo = ProjectRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Project")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(controller: nameController, decoration: InputDecoration(labelText: "Project Name")),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: "Description"),
            ),
            TextField(
              controller: latController,
              decoration: InputDecoration(labelText: "Latitude"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: lngController,
              decoration: InputDecoration(labelText: "Longitude"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: budgetController,
              decoration: InputDecoration(labelText: "Budget"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final name = nameController.text.trim();
                final desc = descriptionController.text.trim();
                final lat = double.tryParse(latController.text) ?? 0.0;
                final lng = double.tryParse(lngController.text) ?? 0.0;
                double budget = double.tryParse(budgetController.text) ?? 0.0;

                if (name.isEmpty || desc.isEmpty) {
                  Get.snackbar("Error", "Please fill all fields");
                  return;
                }

                await repo.addProject(
                  ProjectModel(
                    id: '',
                    name: name,
                    description: desc,
                    location: GeoPoint(lat, lng),
                    budget: budget,
                  ),
                );
                Get.back(); // go back to project list
              },
              child: Text("Add Project"),
            ),
          ],
        ),
      ),
    );
  }
}
