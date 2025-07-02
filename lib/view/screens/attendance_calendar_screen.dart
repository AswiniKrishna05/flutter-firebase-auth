import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'package:flutter_firebase_auth/view_model/attendance_calendar_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../constants/strings.dart';
import '../../utils/custom/DonutChartWithDays.dart';

class AttendanceCalendarScreen extends StatelessWidget {
  const AttendanceCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceCalendarViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text(AppStrings.attendanceCalendar
              , style: TextStyle(color: Colors.black)),
          leading: const BackButton(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<AttendanceCalendarViewModel>(
          builder: (context, vm, _) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  _buildCalendarHeader(vm),
                  _buildCalendarCard(context, vm),
                  const SizedBox(height: 10),
                  _buildOverviewAndPieChart(vm),
                  const SizedBox(height: 16),
                  _buildDayDetails(vm),
                ],
              ),
            );
          },
        ),
        bottomNavigationBar: BottomBar(currentIndex: 0,
          onTap: (int value) {  },),
      ),
    );
  }

  Widget _buildCalendarHeader(AttendanceCalendarViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGrey
          ,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, size: 28),
            onPressed: vm.previousMonth,
          ),
          Row(
            children: [
              Text(
                DateFormat.yMMMM().format(vm.focusedDay),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(width: 4),
              const Icon(Icons.keyboard_arrow_down, size: 22),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, size: 28),
            onPressed: vm.nextMonth,
          ),
        ],
      ),
    );
  }

  Widget _buildCalendarCard(BuildContext context, AttendanceCalendarViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGrey
          ,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 0),
          SizedBox(
            height: 280,
            child: TableCalendar(
              focusedDay: vm.focusedDay,
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              calendarFormat: vm.calendarFormat,
              selectedDayPredicate: (day) => isSameDay(vm.selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) => vm.selectDay(selectedDay, focusedDay),
              onFormatChanged: vm.onFormatChanged,
              onPageChanged: vm.onPageChanged,
              daysOfWeekStyle: DaysOfWeekStyle(
                dowTextFormatter: (date, locale) =>
                    DateFormat.E(locale).format(date).toUpperCase(), // SUN, MON, etc.
                weekdayStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
                weekendStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              ),

              headerVisible: false,
              calendarStyle: CalendarStyle(
                todayDecoration: const BoxDecoration(
                  color: AppColors.lightBlue
                  ,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: const BoxDecoration(
                  color: AppColors.lightBlue
                  ,
                  shape: BoxShape.circle,
                ),
                todayTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                defaultTextStyle: const TextStyle(fontWeight: FontWeight.w600),
              ),
              eventLoader: (day) => vm.getEventsForDay(day),
              calendarBuilders: CalendarBuilders(
                defaultBuilder: (context, day, focusedDay) {
                  final status = vm.getEventsForDay(day).isNotEmpty ? vm.getEventsForDay(day).first : null;
                  if (status != null) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: _statusBackgroundColor(status),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                          color: status == AppStrings.late
                              ? Colors.blue : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                  return null;
                },
                todayBuilder: (context, day, focusedDay) {
                  return Container(
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.mediumBlue
                      ,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${day.day}',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewAndPieChart(AttendanceCalendarViewModel vm) {
    // Hardcoded demo values
    const int present = 20;
    const int absent = 3;
    const int leaves = 2;
    const int late = 6;

    final dataMap = {
      AppStrings.present
          : present.toDouble(),
      AppStrings.absent
          : absent.toDouble(),
      AppStrings.leaves
          : leaves.toDouble(),
      AppStrings.late
          : late.toDouble(),
    }..removeWhere((key, value) => value == 0);

    final colorList = [
      AppColors.green,
      AppColors.red,
      AppColors.orange,
      AppColors.blue,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.lightGrey
          ,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 6, left: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  AppStrings.overview
                  ,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  'Total Days : 31',
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatBox(AppStrings.presence
                  , present, AppColors.green),
              _buildStatBox(AppStrings.absence
                  , absent, AppColors.red),
              _buildStatBox(AppStrings.leaves
                  , leaves, AppColors.orange),
              _buildStatBox(AppStrings.late
                  , late, AppColors.blue),
            ],
          ),

           DonutChartWithDays(),
        ],
      ),
    );
  }

  Widget _buildDayDetails(AttendanceCalendarViewModel vm) {
    // Mock data for demonstration
    final date = DateTime(2025, 6, 18);
    final status = AppStrings.present
    ;
    final checkIn = '09:30 AM';
    final checkOut = '06:00 PM';
    final workMode = AppStrings.office
    ;
    final verification = AppStrings.selfie
    ;
    final location = 'Lat: 13.05, Long: 80.24';
    final notes = AppStrings.workedOnUiBugFixing
    ;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'June 18, 2025',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.status
                ,
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.lightGreen
                  ,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          DottedBorder(
            dashPattern: [4, 4],
            color: AppColors.grey
            ,
            strokeWidth: 1,
            customPath: (size) => Path()
              ..moveTo(0, 0)
              ..lineTo(size.width, 0),
            child: SizedBox(width: double.infinity, height: 1),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.alarm, color: AppColors.green, size: 22),
                        const SizedBox(width: 6),
                        Text(AppStrings.checkIn
                            , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(checkIn, style: TextStyle(color: AppColors.green, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: DottedBorder(
                  dashPattern: [4, 4],
                  color: AppColors.grey
                  ,
                  strokeWidth: 1,
                  customPath: (size) {
                    final path = Path();
                    path.moveTo(0, size.height / 2);
                    path.lineTo(size.width, size.height / 2);
                    return path;
                  },
                  child: SizedBox(width: 32, height: 24, child: Icon(Icons.arrow_forward, size: 18, color: Color(0xFFBDBDBD))),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.alarm_off, color: AppColors.green, size: 22),
                        const SizedBox(width: 6),
                        Text(AppStrings.checkOut
                            , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(checkOut, style: TextStyle(color: AppColors.green, fontSize: 13, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              // First Box - Work Mode (left-aligned)
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      margin: const EdgeInsets.only(left: 1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(color: AppColors.lightGrey
                            , width: 1),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.workMode
                            ,
                            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                            decoration: BoxDecoration(
                              color: AppColors.veryLightBlue
                              ,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              workMode,
                              style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 3,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomLeft: Radius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12), // Gap between boxes

              // Spacer to push the second box to the right
              Spacer(),

              // Second Box - Verification (right-aligned)
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                        margin: const EdgeInsets.only(left: 1),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(color:AppColors.lightGrey
                              , width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.verification
                              ,
                              style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
                              decoration: BoxDecoration(
                                color: AppColors.lightYellow
                                ,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                verification,
                                style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 0,
                        top: 0,
                        bottom: 0,
                        child: Container(
                          width: 3,
                          decoration: BoxDecoration(
                            color: AppColors.blue,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),



          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color:AppColors.lightGrey
                  , width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text(AppStrings.location
                        , style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28), // Matches icon width + spacing
                  child: Text(
                    location,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Color(0xFFE0E0E0), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notes, color: Colors.black54, size: 20),
                    const SizedBox(width: 8),
                    Text(AppStrings.notes
                        , style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 28), // 20(icon) + 8(SizedBox)
                  child: Text(
                    notes,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, int count, Color color) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.lightGrey
            , width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 1,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 6),
          Text(
            count.toString().padLeft(2, '0'),
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: color),
          ),
        ],
      ),
    );
  }

  static Color _statusBackgroundColor(String status) {
    switch (status) {
      case AppStrings.present
          :
        return AppColors.lightGreen
        ;
      case AppStrings.absent
          :
        return  AppColors.lightRed
        ;
      case AppStrings.leave
          :
        return  AppColors.lightPeach
        ;
      case 'Late':
        return  AppColors.lightSkyBlue
        ;
      default:
        return Colors.white;
    }

  }

}
