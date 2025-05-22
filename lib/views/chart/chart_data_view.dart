import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ChartDataView extends StatelessWidget {
  const ChartDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Statistics"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'Monthly Milestone Progress',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: LineChart(
                    LineChartData(
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              final monthNames = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
                              return Text(monthNames[value.toInt()]);
                            },
                          ),
                        ),
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(showTitles: true),
                        ),
                      ),
                      borderData: FlBorderData(show: true),
                      lineBarsData: [
                        LineChartBarData(
                          isCurved: true,
                          color: Colors.blue,
                          belowBarData: BarAreaData(show: true, color: Colors.blue.withOpacity(0.3)),
                          spots: [
                            FlSpot(0, 2),
                            FlSpot(1, 3),
                            FlSpot(2, 4),
                            FlSpot(3, 6),
                            FlSpot(4, 5),
                            FlSpot(5, 7),
                          ],
                        )
                      ],
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
}
