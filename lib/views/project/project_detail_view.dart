import 'package:assign_project_s/models/project_model.dart';
import 'package:flutter/material.dart';

class ProjectDetailView extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailView({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(project.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Description:", style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 8),
            Text(project.description),
            const SizedBox(height: 20),
            Text("Location: (${project.location.latitude}, ${project.location.longitude})"),
          ],
        ),
      ),
    );
  }
}
