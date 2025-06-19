import 'package:flutter/material.dart';
import '../../app_colors.dart';
import '../screens/leave_screen.dart';
import 'dash_card.dart';
import '../screens/apply_leave_screen.dart'; // <- Import your target screen

class DashboardGrid extends StatelessWidget {
  const DashboardGrid({super.key});

  @override
  Widget build(BuildContext context) {
    const items = [
      ('Attendance', Icons.calendar_today_rounded, AppColors.green),
      ('Leaves', Icons.exit_to_app_rounded, AppColors.orange),
      ('Leave Status', Icons.pie_chart_outline_rounded, AppColors.purple),
      ('Holiday List', Icons.checklist_rounded, AppColors.blueAccent),
      ('Payslip', Icons.receipt_long_rounded, AppColors.teal),
      ('Reports', Icons.show_chart_rounded, AppColors.red),
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

        return GestureDetector(
          onTap: () {
            if (label == 'Leaves') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaveScreen()),
              );
            }
          },
          child: DashCard(label: label, icon: icon, colour: colour),
        );
      },
    );
  }
}
