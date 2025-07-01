import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/utils/shared/widgets/reusable_card.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../../utils/shared/widgets/reusable_line_chart.dart';
import '../../utils/shared/widgets/reusable_table.dart';
import '../../view_model/report_view_model.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ReportViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomAppBar(),
        body: Consumer<ReportViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black,size: 18,),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      SizedBox(width: 2),
                      Text(
                        'Reports',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                    childAspectRatio: 1.1,
                    children: [
                      buildSummaryCard(
                        title: 'Total Working Days\n(This Month)',
                        value: '22 days',
                        icon: Icons.calendar_today,
                      ),
                      buildSummaryCard(
                        title: 'Total Hours Worked',
                        value: '145 hrs',
                        icon: Icons.hourglass_bottom,
                      ),
                      buildSummaryCard(
                        title: 'Tasks Completed',
                        value: '35',
                        icon: Icons.check_circle_outline,
                        subtitle: 'this month',
                      ),
                      buildSummaryCard(
                        title: 'Average Daily Hours',
                        value: '6.6',
                        icon: Icons.access_alarm,
                        subtitle: 'hrs/day',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Daily Clock-In/Out Log',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  ReusableTable(logs: vm.attendanceLogs),
                  const SizedBox(height: 24),
                  const Text(
                    'Attendance',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Row(
                        children: [
                          Container(width: 14, height: 14, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.rectangle)),
                          const SizedBox(width: 4),
                          const Text('Present', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Container(width: 14, height: 14, decoration: BoxDecoration(color: Colors.red, shape: BoxShape.rectangle)),
                          const SizedBox(width: 4),
                          const Text('Absence', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                      const SizedBox(width: 16),
                      Row(
                        children: [
                          Container(width: 14, height: 14, decoration: BoxDecoration(color: Colors.lightBlue, shape: BoxShape.rectangle)),
                          const SizedBox(width: 4),
                          const Text('Avg hrs', style: TextStyle(fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ReusableLineChart(
                    data: vm.attendanceChartData,
                    presentData: vm.presentData,
                    absentData: vm.absentData,
                    avgHoursData: vm.avgHoursData,
                  ),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }

  Widget buildSummaryCard({
    required String title,
    required String value,
    required IconData icon,
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  value,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: Colors.black,
                  ),
                ),
                if (subtitle != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Icon(icon, color: Colors.lightBlue, size: 28),
        ],
      ),
    );
  }
}
