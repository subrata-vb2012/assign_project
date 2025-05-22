import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/project_controller.dart';
import 'project_detail_view.dart';
import 'add_project_view.dart';

class ProjectListView extends StatelessWidget {
  const ProjectListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProjectController>();
    controller.filteredProjects.value = controller.allProjects;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: () => Get.to(() => AddProjectView()))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: controller.searchProjects,
              decoration: InputDecoration(
                hintText: 'Search projects...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final projects = controller.filteredProjects;
              if (projects.isEmpty) {
                return const Center(child: Text('No projects found.'));
              } else {
                return ListView.builder(
                  itemCount: projects.length,
                  itemBuilder: (context, index) {
                    final project = projects[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        title: Text(project.name),
                        subtitle: Text(project.description),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () => Get.to(() => ProjectDetailView(project: project)),
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
