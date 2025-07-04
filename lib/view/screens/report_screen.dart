import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/custom_app_bar.dart';
import 'package:flutter_firebase_auth/view/widgets/screen_header.dart';
import 'package:flutter_firebase_auth/view/widgets/summary_grid.dart';
import 'package:flutter_firebase_auth/view/widgets/section_header.dart';
import 'package:flutter_firebase_auth/view/widgets/legend_row.dart';
import 'package:provider/provider.dart';
import '../../constants/strings.dart';
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
                  const ScreenHeader(title: AppStrings.reports),
                  const SizedBox(height: 8),
                  SummaryGrid(
                    cards: [
                      const SummaryCardData(
                        title: AppStrings.totalWorkingDays,
                        value: AppStrings.workingDaysCount,
                        icon: Icons.calendar_today,
                      ),
                      const SummaryCardData(
                        title: AppStrings.totalHoursWorked
                        ,
                        value: AppStrings.totalHoursWorkedCount
                        ,
                        icon: Icons.hourglass_bottom,
                      ),
                      const SummaryCardData(
                        title: AppStrings.tasksCompleted
                        ,
                        value: AppStrings.tasksCompletedCount
                        ,
                        icon: Icons.check_circle_outline,
                        subtitle: AppStrings.thisMonth
                        ,
                      ),
                      const SummaryCardData(
                        title:AppStrings.averageDailyHours
                        ,
                        value: AppStrings.averageDailyHoursCount
                        ,
                        icon: Icons.access_alarm,
                        subtitle: AppStrings.hoursPerDay
                        ,
                      ),
                    ],
                  ),
                  const SectionHeader(
                    title: AppStrings.dailyClockInOutLog
                    ,
                    fontSize: 12,
                    padding: EdgeInsets.only(top: 24, bottom: 12),
                  ),
                  ReusableTable(logs: vm.attendanceLogs),
                  const SectionHeader(title: AppStrings.attendance
                  ),
                  LegendRow(
                    items: const [
                      LegendItem(label: AppStrings.present
                          , color: Colors.green),
                      LegendItem(label: AppStrings.absence
                          , color: Colors.red),
                      LegendItem(label: AppStrings.avgHours
                          , color: Colors.lightBlue),
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
          currentIndex: 0,
          onTap: (index) {},
        ),
      ),
    );
  }
}
