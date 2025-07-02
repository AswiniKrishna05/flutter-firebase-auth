import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:flutter_firebase_auth/constants/strings.dart';
import 'package:flutter_firebase_auth/view_model/holiday_list_view_model.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widgets/bottom_bar.dart';
import '../widgets/custom_app_bar.dart';

class HolidayListScreen extends StatelessWidget {
  const HolidayListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HolidayListViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 26.0, 16.0, 0.0),
            child: Consumer<HolidayListViewModel>(
              builder: (context, model, _) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: _buildHolidayStatCard(
                              title: AppStrings.totalHolidays,
                              icon: Icons.calendar_today,
                              mainText: '18 days',
                              subText: AppStrings.inAYear,
                              showProgress: true,
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: SizedBox(
                            height: 160,
                            child: _buildHolidayStatCard(
                                title: AppStrings.upcomingHolidays,
                                icon: Icons.calendar_today,
                                mainText: '4',
                                subText:
                                    AppStrings.period17June21DaysRemaining),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        _LegendSquare(
                          color: Colors.green,
                          label: AppStrings.public,
                        ),
                        SizedBox(width: 12),
                        _LegendSquare(
                            color: Colors.yellow, label: AppStrings.optional),
                        SizedBox(width: 12),
                        _LegendSquare(
                            color: Colors.blue, label: AppStrings.company),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: const [
                              Text(AppStrings.sun,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.red)),
                              Text(AppStrings.mon,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(AppStrings.tue,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(AppStrings.wed,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(AppStrings.thu,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(AppStrings.fri,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text(AppStrings.sat,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: Text(
                                'June 2025',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 4),
                          TableCalendar(
                            firstDay: DateTime.utc(2025, 6, 1),
                            lastDay: DateTime.utc(2025, 6, 30),
                            focusedDay: model.focusedDay,
                            selectedDayPredicate: (_) => false,
                            onDaySelected: (selectedDay, focusedDay) =>
                                model.setFocusedDay(focusedDay),
                            headerVisible: false,
                            daysOfWeekVisible: false,
                            availableCalendarFormats: const {
                              CalendarFormat.month: AppStrings.month
                            },
                            rowHeight: 40,
                            sixWeekMonthsEnforced: false,
                            calendarBuilders: CalendarBuilders(
                              defaultBuilder: (context, day, _) {
                                final isGreenSquare =
                                    day.day == 3 || day.day == 12;
                                final isBlueSquare = day.day == 16 ||
                                    day.day == 17 ||
                                    day.day == 25;
                                final isYellowBox = day.day == 20;
                                final isSunday = day.weekday == DateTime.sunday;

                                if (isGreenSquare) {
                                  return _coloredBox(day.day, Colors.green);
                                } else if (isBlueSquare) {
                                  return _coloredBox(day.day, Colors.blue);
                                } else if (isYellowBox) {
                                  return _coloredBox(day.day, Colors.yellow);
                                } else {
                                  return Center(
                                    child: Text(
                                      '${day.day}',
                                      style: TextStyle(
                                          color: isSunday
                                              ? Colors.red
                                              : Colors.black),
                                    ),
                                  );
                                }
                              },
                              todayBuilder: (context, day, _) {
                                // Prevent highlight for today's date
                                final isSunday = day.weekday == DateTime.sunday;
                                return Center(
                                  child: Text(
                                    '${day.day}',
                                    style: TextStyle(
                                        color: isSunday
                                            ? Colors.red
                                            : Colors.black),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Table(
                      columnWidths: const {
                        0: FlexColumnWidth(3),
                        1: FlexColumnWidth(4),
                        2: FlexColumnWidth(4),
                        3: FlexColumnWidth(4),
                      },
                      border: TableBorder.all(color: Colors.grey.shade300),
                      children: const [
                        TableRow(children: [
                          _TableHeader(AppStrings.date),
                          _TableCell('17 June'),
                          _TableCell('15 August'),
                          _TableCell('23 October'),
                        ]),
                        TableRow(children: [
                          _TableHeader(AppStrings.day),
                          _TableCell(AppStrings.tuesday),
                          _TableCell(AppStrings.thursday),
                          _TableCell(AppStrings.wednesday),
                        ]),
                        TableRow(children: [
                          _TableHeader(AppStrings.holidayName),
                          _TableCell(AppStrings.bakrid),
                          _TableCell(AppStrings.independenceDay),
                          _TableCell(AppStrings.diwali),
                        ]),
                        TableRow(children: [
                          _TableHeader(AppStrings.type),
                          _TableCell(AppStrings.publicHoliday),
                          _TableCell(AppStrings.nationalHoliday),
                          _TableCell(AppStrings.optional),
                        ]),
                        TableRow(children: [
                          _TableHeader(AppStrings.note),
                          _TableCell(AppStrings.companyWideHoliday),
                          _TableCell(AppStrings.paidLeave),
                          _TableCell(AppStrings.canBeApplied),
                        ]),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: 0, // Example: set the selected tab index
          onTap: (index) {}, // Example: empty function if not using tab switching
        ),
      ),
    );
  }

  Widget _buildHolidayStatCard({
    required String title,
    required IconData icon,
    required String mainText,
    required String subText,
    bool showProgress = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          mainText,
                          style: const TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        SizedBox(
                          height: 32,
                          width: double.infinity, // <-- Add this
                          child: subText.length > 30
                              ? Marquee(
                                  text: subText,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  scrollAxis: Axis.horizontal,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  blankSpace: 20.0,
                                  velocity: 30.0,
                                  pauseAfterRound: Duration(seconds: 1),
                                  startPadding: 10.0,
                                  accelerationDuration: Duration(seconds: 1),
                                  accelerationCurve: Curves.linear,
                                  decelerationDuration:
                                      Duration(milliseconds: 500),
                                  decelerationCurve: Curves.easeOut,
                                )
                              : Text(
                                  subText,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                ),
                        ),

                        // Text(
                        //   subText,
                        //   style: const TextStyle(fontSize: 12, color: Colors.grey),
                        // ),
                        if (showProgress) ...[
                          const SizedBox(height: 8),
                          LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.grey[300],
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.lightBlue),
                            minHeight: 4,
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(icon, size: 25, color: Colors.blue),
                ],
              ),
              const SizedBox(height: 6),
            ],
          ),
        ),
      ),
    );
  }

  Widget _coloredBox(int day, Color color) {
    return Center(
      child: Container(
        width: 35,
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('$day', style: const TextStyle(color: Colors.white)),
      ),
    );
  }
}

class _LegendSquare extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendSquare({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.rectangle,
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: TextStyle(fontSize: 14)),
      ],
    );
  }
}

class _TableHeader extends StatelessWidget {
  final String text;

  const _TableHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, fontSize: 12, color: Colors.grey),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;

  const _TableCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 12),
      ),
    );
  }
}
