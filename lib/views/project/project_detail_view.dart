// lib/views/project/project_detail_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/project_model.dart';
import '../../controllers/project_controller.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectModel project;

  ProjectDetailView({super.key, required this.project});

  final ProjectController controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    final lat = project.location.latitude;
    final lng = project.location.longitude;

    return Scaffold(
      appBar: AppBar(
        title: Text(project.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 20,

          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),side: BorderSide(color: Colors.green)),
          child: Padding(

            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(project.name,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                const Text("Description",
                    style: TextStyle(fontSize: 16, color: Colors.grey)),
                Text(project.description,
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.red),
                    Text("Lat: ${lat.toStringAsFixed(4)}  |  Lng: ${lng.toStringAsFixed(4)}"),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.green),
                    Text("Budget: \$${project.budget.toStringAsFixed(2)}",
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                    label: const Text("Back to Projects"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    Get.defaultDialog(
      title: "Confirm Deletion",
      middleText: "Are you sure you want to delete this project?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await controller.deleteProject(project.id);
        Get.back(); // Close dialog
        Get.back(); // Go back after deletion
        Get.snackbar("Success", "Project deleted successfully",
            snackPosition: SnackPosition.BOTTOM);
      },
    );
  }
}
