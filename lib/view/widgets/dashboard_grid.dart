import 'package:flutter/material.dart';

import 'dash_card.dart';

class DashboardGrid extends StatelessWidget {
  const DashboardGrid();

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Attendance', Icons.calendar_today_rounded, Color(0xFF32C05E)),
      ('Leaves', Icons.exit_to_app_rounded, Color(0xFFFF9D31)),
      ('Leave Status', Icons.pie_chart_outline_rounded,  Color(0xFFB063FF)),
      ('Holiday List', Icons.checklist_rounded, Color(0xFF3267FF)),
      ('Payslip', Icons.receipt_long_rounded, Color(0xFF10B981)),
      ('Reports', Icons.show_chart_rounded, Color(0xFFFF5E5E)),
    ];

    return GridView.builder(
      itemCount: items.length,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.95,
      ),
      itemBuilder: (_, i) {
        final (label, icon, colour) = items[i];
        return DashCard(label: label, icon: icon, colour: colour);
      },
    );
  }
}