import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import '../../view_model/leave_status_view_model.dart';
import '../widgets/custom_app_bar.dart';
import 'package:fl_chart/fl_chart.dart';

class LeaveStatusScreen extends StatefulWidget {
  const LeaveStatusScreen({super.key});

  @override
  State<LeaveStatusScreen> createState() => _LeaveStatusScreenState();
}

class _LeaveStatusScreenState extends State<LeaveStatusScreen> {
  IconData getLeaveIcon(String title) {
    switch (title) {
      case AppStrings.leaveTaken
          :
        return Icons.insert_chart_outlined;
      case AppStrings.leaveBalance
          :
        return Icons.calendar_today_outlined;
      case AppStrings.pendingRequest
          :
        return Icons.hourglass_bottom;
      case AppStrings.approvedLeaves
          :
        return Icons.check_circle_outline;
      case AppStrings.rejectedLeaves
          :
        return Icons.cancel_outlined;
      case AppStrings.upcomingLeaves
          :
        return Icons.event_note;
      default:
        return Icons.info_outline; // fallback icon
    }
  }

  DateTime focusedDay = DateTime(2025, 6, 1);

  DateTime? selectedDay;

  // Color Markings
  final Map<DateTime, Color> markedDates = {
    DateTime(2025, 6, 3): Colors.green,
    DateTime(2025, 6, 12): Colors.green,
    DateTime(2025, 6, 16): Colors.red,
    DateTime(2025, 6, 17): Colors.red,
    DateTime(2025, 6, 20): Colors.yellow,
    DateTime(2025, 6, 25): Colors.blue,
  };

  @override
  Widget build(BuildContext context) {
    final leaveVM = LeaveStatusViewModel();
    final leaveList = leaveVM.getLeaveSummary();

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                  childAspectRatio: 1.3,
                ),
                itemCount: leaveList.length,
                itemBuilder: (context, index) {
                  final leave= leaveList[index];
                  return Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 1,
                    child: Padding(
                        padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                             leave.title,
                             style: const TextStyle(
                               fontSize: 14,
                               fontWeight: FontWeight.w500,
                               color: AppColors.black,
                             ),
                            ),
                            Icon(
                              getLeaveIcon(leave.title),
                              color: Colors.blue,
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        // Main Value
                        Text(
                          leave.value,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Description (Hardcoded or Dynamic)
                        Text(
                          AppStrings.twentyNineDaysRemaining
                          , // You can make this dynamic if needed
                          style: const TextStyle(
                            fontSize: 8,
                            color: Colors.grey,
                          ),
                        ),
                        //optional progress Bar (only for specific cards)
                        if (leave.title== AppStrings.leaveTaken
                        )...[
                          const SizedBox(height: 8,),
                          LinearProgressIndicator(
                            value: 0.7,
                            color: Colors.lightBlue,
                            backgroundColor: AppColors.grey400,
                          )
                        ]
                      ],
                    ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),

              // Calendar Section inside One Box
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Weekday Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Text(AppStrings.sun
                            , style: TextStyle(color: Colors.red)),
                        Text(AppStrings.mon
                        ),
                        Text(AppStrings.tue
                        ),
                        Text(AppStrings.wed
                        ),
                        Text(AppStrings.thu
                        ),
                        Text(AppStrings.fri
                        ),
                        Text(AppStrings.sat
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Calendar Header (Month-Year)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '${_monthName(focusedDay.month)} ${focusedDay.year}',
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Calendar
                    TableCalendar(
                      firstDay: DateTime(2020, 1, 1),
                      lastDay: DateTime(2030, 12, 31),
                      focusedDay: focusedDay,
                      daysOfWeekVisible: false, // Your manual weekdays will remain
                      headerVisible: false, // Your manual header will remain
                      calendarFormat: CalendarFormat.month,
                      startingDayOfWeek: StartingDayOfWeek.sunday,
                      selectedDayPredicate: (day) => false, // Disable selection
                      calendarStyle: CalendarStyle(
                        todayDecoration: const BoxDecoration(),
                        todayTextStyle: const TextStyle(color: Colors.black),
                        outsideDaysVisible: false,
                      ),calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        bool isSunday = day.weekday == DateTime.sunday;
                        Color? bgColor ;
                        // = markedDates[DateTime(day.year, day.month, day.day)];
                        markedDates.forEach((markedDate, color) {
                          if (isSameDay(markedDate, day)) {
                            bgColor = color;
                          }
                        });
                        return Container(
                          margin: const EdgeInsets.all(1),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: bgColor ?? Colors.transparent,
                            border: Border.all(color: Colors.black12), // ✅ Your desired border color
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: isSunday ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },

                      todayBuilder: (context, day, focusedDay) {
                        bool isSunday = day.weekday == DateTime.sunday;
                        Color? bgColor = markedDates[DateTime(day.year, day.month, day.day)];

                        return Container(
                          margin: const EdgeInsets.all(6),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: bgColor ?? Colors.transparent,
                            border: Border.all(color: AppColors.black12, width: 1), // ✅ Border color for today (you can customize)
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            '${day.day}',
                            style: TextStyle(
                              color: isSunday ? Colors.red : Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      },
                    ),

                      onPageChanged: (focusedDay) {
                        setState(() {
                          this.focusedDay = focusedDay;
                        });
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

// Leave History Table

              Table(
                border: TableBorder.all(
                  color: AppColors.grey400
                ),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: AppColors.white),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(AppStrings.date
                            , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(AppStrings.leaveType
                            , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(AppStrings.status
                            , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(AppStrings.reason_
                            , style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue,)),
                      ),
                    ],
                  ),
                  _buildLeaveRow('10 June', AppStrings.sickLeave
                      , AppStrings.approved, AppStrings.fever),
                  _buildLeaveRow('20 June', AppStrings.casualLeave, AppStrings.pending, AppStrings.familyFunction),
                  _buildLeaveRow('01 July', AppStrings.wfh, AppStrings.rejected, AppStrings.noBackup),
                ],
              ),
              const SizedBox(height: 20),

              // Leave Overview Box (Only Chart + Title + Legend)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppStrings.leaveOverview,
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,letterSpacing: 1),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      AppStrings.leaveDistributionCurrentYear,
                      style: TextStyle(fontSize: 12, color: AppColors.black),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 120,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 19,
                          barTouchData: BarTouchData(enabled: false),
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (double value, TitleMeta meta) {
                                  const style = TextStyle(
                                    color: AppColors.textDark,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  );
                                  switch (value.toInt()) {
                                    case 0:
                                      return Text(AppStrings.q1, style: style);
                                    case 1:
                                      return Text(AppStrings.q2, style: style);
                                    case 2:
                                      return Text(AppStrings.q3, style: style);
                                    case 3:
                                      return Text(AppStrings.q4, style: style);
                                    default:
                                      return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ),
                          ),
                          gridData: FlGridData(show: false),
                          borderData: FlBorderData(show: false),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(
                                toY: 8,
                                color: AppColors.blue,
                                width: 60,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(
                                toY: 5,
                                color: AppColors.blue,
                                width: 60,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(
                                toY: 4,
                                color: AppColors.blue,
                                width: 60,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(
                                toY: 3,
                                color: AppColors.blue,
                                width: 60,
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ]),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                              AppStrings.leaveDaysTaken,
                              style: TextStyle(fontSize: 12),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Divider Line
                    Divider(color: Colors.grey.shade400),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          AppStrings.totalDays20,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                        Text(
                          AppStrings.remaining29,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),



            ],
          ),

        ),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: 0, // Example: set the selected tab index
        onTap: (index) {}, // Example: empty function if not using tab switching
      ),
    );
  }
  String _monthName(int month) {
    List<String> months = [
      '', // Index 0, unused
      AppStrings.january,
      AppStrings.february,
      AppStrings.march,
      AppStrings.april,
      AppStrings.may,
      AppStrings.june,
      AppStrings.july,
      AppStrings.august,
      AppStrings.september,
      AppStrings.october,
      AppStrings.november,
      AppStrings.december,
    ];
    return months[month];
  }

  TableRow _buildLeaveRow(String date, String type, String status, String reason) {
    Color statusColor;
    if (status == AppStrings.approved) {
      statusColor = Colors.green;
    } else if (status == AppStrings.pending) {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(date),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(type),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            status,
            style: TextStyle(color: statusColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(reason),
        ),
      ],
    );
  }

}
