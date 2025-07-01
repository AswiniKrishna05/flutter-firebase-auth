import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/screens/attendance_calendar_screen.dart';
import '../../constants/app_colors.dart';
import '../screens/holiday_list_screen.dart';
import '../screens/leave_screen.dart';
import '../screens/leave_status_screen.dart';
import '../screens/payslip_screen.dart';
import '../screens/report_screen.dart';
import 'dash_card.dart';
import '../screens/apply_leave_screen.dart';

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
            } else if(label== 'Attendance'){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> const AttendanceCalendarScreen()));
            }else if (label == 'Holiday List'){
              Navigator.push(context,
                  MaterialPageRoute(builder: (_)=> const HolidayListScreen()));
            } else if (label == 'Leave Status') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const LeaveStatusScreen()),
              );
            }else if (label == 'Payslip') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PayslipScreen()),
              );
            }else if (label == 'Reports') {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ReportScreen()),
              );
            }


          },
          child: DashCard(label: label, icon: icon, colour: colour),
        );
      },
    );
  }
}
