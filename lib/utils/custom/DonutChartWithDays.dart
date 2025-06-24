import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class DonutChartWithDays extends StatefulWidget {
  const DonutChartWithDays({super.key});

  @override
  State<DonutChartWithDays> createState() => _DonutChartWithDaysState();
}

class _DonutChartWithDaysState extends State<DonutChartWithDays> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.2,
      child: PieChart(
        PieChartData(
          pieTouchData: PieTouchData(
            touchCallback: (event, pieTouchResponse) {
              setState(() {
                if (!event.isInterestedForInteractions ||
                    pieTouchResponse?.touchedSection == null) {
                  touchedIndex = -1;
                  return;
                }
                touchedIndex =
                    pieTouchResponse!.touchedSection!.touchedSectionIndex;
              });
            },
          ),
          startDegreeOffset: 270,
          borderData: FlBorderData(show: false),
          sectionsSpace: 2,
          centerSpaceRadius: 45,
          sections: _generateSections(),
        ),
      ),
    );
  }

  List<PieChartSectionData> _generateSections() {
    final data = [
      {'label': 'Present', 'value': 20.0, 'color': const Color(0xFF22B14C)},
      {'label': 'Absent', 'value': 3.0, 'color': const Color(0xFFE74C3C)},
      {'label': 'Leaves', 'value': 2.0, 'color': const Color(0xFFFF9900)},
      {'label': 'Late', 'value': 6.0, 'color': const Color(0xFF0099FF)},
    ];

    return List.generate(data.length, (i) {
      final isTouched = i == touchedIndex;
      final item = data[i];
      final fontSize = isTouched ? 14.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;
      final value = item['value'] as double;
      final title = '${value.toInt()}\nDays';

      return PieChartSectionData(
        color: item['color'] as Color,
        value: value,
        title: title,
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1.2,
        ),
        titlePositionPercentageOffset: 0.55, // Adjusted for more centered look
      );
    });
  }
}
