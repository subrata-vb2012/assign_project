import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/project_controller.dart';
import '../auth/login_view.dart';
import '../chart/chart_data_view.dart';
import '../project/project_list_view.dart';
import '../media/media_view.dart';
import '../map/map_data_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.find<ProjectController>();
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(authController.userName() ?? ''),

        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Get.defaultDialog(
                title: 'Confirm Logout',
                middleText: 'Are you sure you want to logout?',
                textConfirm: 'Yes',
                textCancel: 'Cancel',
                confirmTextColor: Colors.white,
                onConfirm: () {
                  authController.logout();
                  Get.offAll(() => LoginView());
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          children: [
            _buildCard(
              icon: Icons.work,
              title: "Projects",
              color: Colors.blue,
              onTap: () => Get.to(() => ProjectListView()),
            ),
            _buildCard(
              icon: Icons.photo_library,
              title: "Media",
              color: Colors.green,
              onTap: () => Get.to(() => MediaView()),
            ),
            _buildCard(
              icon: Icons.map,
              title: "Map",
              color: Colors.orange,
              onTap: () => Get.to(() => MapDataView()),
            ),
            _buildCard(
              icon: Icons.bar_chart,
              title: "Charts",
              color: Colors.purple,
              onTap: () => Get.to(() => ChartDataView()),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 5,
        color: color.withOpacity(0.8),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
