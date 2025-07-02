import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/utils/shared/widgets/reusable_card.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/custom_app_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/screen_header.dart';
import 'package:flutter_firebase_auth/view/widgets/summary_grid.dart';
import 'package:flutter_firebase_auth/view/widgets/section_header.dart';
import 'package:flutter_firebase_auth/view/widgets/legend_row.dart';
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
                  const ScreenHeader(title: 'Reports'),
                  const SizedBox(height: 8),
                  SummaryGrid(
                    cards: [
                      const SummaryCardData(
                        title: 'Total Working Days\n(This Month)',
                        value: '22 days',
                        icon: Icons.calendar_today,
                      ),
                      const SummaryCardData(
                        title: 'Total Hours Worked',
                        value: '145 hrs',
                        icon: Icons.hourglass_bottom,
                      ),
                      const SummaryCardData(
                        title: 'Tasks Completed',
                        value: '35',
                        icon: Icons.check_circle_outline,
                        subtitle: 'this month',
                      ),
                      const SummaryCardData(
                        title: 'Average Daily Hours',
                        value: '6.6',
                        icon: Icons.access_alarm,
                        subtitle: 'hrs/day',
                      ),
                    ],
                  ),
                  const SectionHeader(
                    title: 'Daily Clock-In/Out Log',
                    fontSize: 12,
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                  ),
                  ReusableTable(logs: vm.attendanceLogs),
                  const SectionHeader(title: 'Attendance'),
                  LegendRow(
                    items: const [
                      LegendItem(label: 'Present', color: Colors.green),
                      LegendItem(label: 'Absence', color: Colors.red),
                      LegendItem(label: 'Avg hrs', color: Colors.lightBlue),
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
        bottomNavigationBar: BottomBar(
          currentIndex: 0, // Example: set the selected tab index
          onTap: (index) {}, // Example: empty function if not using tab switching
        ),
      ),
    );
  }
}
