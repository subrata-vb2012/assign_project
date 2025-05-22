import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import '../../controllers/map_data_controller.dart';
import '../project/project_detail_view.dart';

class MapDataView extends StatelessWidget {
  const MapDataView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MapDataController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Map'),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.projects.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        return FlutterMap(
          options: MapOptions(
            center: LatLng(20.0, 77.0), // Center on India or adjust as needed
            zoom: 4.5,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.project',
            ),
            MarkerLayer(
              markers: controller.projects.map((project) {
                final lat = project.location.latitude;
                final lng = project.location.longitude;

                return Marker(
                  width: 80,
                  height: 80,
                  point: LatLng(lat, lng),
                  child:   GestureDetector(
                    onTap: () {
                      Get.to(() => ProjectDetailView(project: project));
                    },
                    child: const Icon(Icons.location_pin, size: 40, color: Colors.red),
                  ),
                );
              }).toList(),
            ),
          ],
        );
      }),
    );
  }
}
