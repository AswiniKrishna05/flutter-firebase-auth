import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReusableLineChart extends StatelessWidget {
  final List<double> presentData;
  final List<double> absentData;
  final List<double> avgHoursData;

  const ReusableLineChart({
    super.key,
    required this.presentData,
    required this.absentData,
    required this.avgHoursData, required data,
  });

  @override
  Widget build(BuildContext context) {
    // Dynamically calculate minY and maxY from all data
    final allData = [...presentData, ...absentData, ...avgHoursData];
    double minY = allData.reduce((a, b) => a < b ? a : b) - 0.5;
    double maxY = allData.reduce((a, b) => a > b ? a : b) + 0.5;
    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          minX: -0.5,
          maxX: 11.5,
          minY: minY,
          maxY: maxY,
          lineTouchData: LineTouchData(enabled: false),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
                  if (value >= 0 && value < months.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        months[value.toInt()],
                        style: const TextStyle(fontSize: 12),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ),
          ),
          gridData: FlGridData(show: true, drawVerticalLine: false),
          borderData: FlBorderData(show: false),
          clipData: FlClipData.none(),
          lineBarsData: [
            _buildLineBarData(presentData, Colors.green),
            _buildLineBarData(absentData, Colors.red),
            _buildLineBarData(avgHoursData, Colors.blue),
          ],
        ),
      ),
    );
  }


  LineChartBarData _buildLineBarData(List<double> data, Color color) {
    return LineChartBarData(
      spots: data.asMap().entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList(),
      isCurved: false,
      color: color,
      barWidth: 2,
      isStrokeCapRound: true,
      belowBarData: BarAreaData(show: false),
      shadow: Shadow(
        color: Colors.grey.withOpacity(0.7), // Shadow color
        blurRadius: 3, // Shadow blur
        offset: Offset(6, 6), // Shadow position
      ),
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: color,
            strokeWidth: 0,
            strokeColor: color,
          );
        },
      ),
    );
  }

}

