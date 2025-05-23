import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../controllers/project_controller.dart';
import '../../models/project_model.dart';
import '../project/project_detail_view.dart';

class ChartDataView extends StatelessWidget {
  ChartDataView({super.key});

  final ProjectController controller = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Project Budgets')),
      body: Obx(() {
        if (controller.allProjects.isEmpty) {
          return const Center(child: Text('No project data available.'));
        }

        final projects = controller.allProjects;

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: getMaxBudget(projects),
              barTouchData: BarTouchData(
                enabled: true,
                touchCallback: (event, response) {
                  if (event is FlTapUpEvent && response != null && response.spot != null) {
                    final index = response.spot!.touchedBarGroupIndex;
                    if (index < projects.length) {
                      final project = projects[index];
                      Get.to(() => ProjectDetailView(project: project));
                    }
                  }
                },
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),

                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      final index = value.toInt();
                      if (index < projects.length) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            projects[index].name.length > 6
                                ? "${projects[index].name.substring(0, 6)}..."
                                : projects[index].name,
                            style: const TextStyle(fontSize: 10),
                          ),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              barGroups: List.generate(projects.length, (index) {
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: projects[index].budget,
                      color: Colors.blueAccent,
                      width: 20,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ],
                );
              }),
            ),
          ),
        );
      }),
    );
  }

  double getMaxBudget(List<ProjectModel> projects) {
    double max = 10000;
    for (var project in projects) {
      if (project.budget > max) max = project.budget;
    }
    return max + 3000;
  }
}
