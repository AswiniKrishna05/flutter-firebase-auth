import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:flutter_firebase_auth/view_model/attendance_calendar_view_model.dart';
import 'package:provider/provider.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class AttendanceCalendarScreen extends StatelessWidget {
  const AttendanceCalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AttendanceCalendarViewModel(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          title: const Text('Attendance Calendar', style: TextStyle(color: Colors.black)),
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
                  _buildCalendarCard(context, vm),
                  const SizedBox(height: 16),
                  _buildOverviewCard(vm),
                  const SizedBox(height: 5),
                  _buildPieChart(vm),
                  const SizedBox(height: 16),
                  _buildDayDetails(vm),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCalendarCard(BuildContext context, AttendanceCalendarViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFE0E0E0),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left, size: 28),
                onPressed: vm.previousMonth,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      DateFormat.yMMMM().format(vm.focusedDay),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    const SizedBox(width: 4),
                    const Icon(Icons.keyboard_arrow_down, size: 22),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, size: 28),
                onPressed: vm.nextMonth,
              ),
            ],
          ),
          const SizedBox(height: 8),
          TableCalendar(
            focusedDay: vm.focusedDay,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            calendarFormat: vm.calendarFormat,
            selectedDayPredicate: (day) => isSameDay(vm.selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) => vm.selectDay(selectedDay, focusedDay),
            onFormatChanged: vm.onFormatChanged,
            onPageChanged: vm.onPageChanged,
            daysOfWeekStyle: const DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
              weekendStyle: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
            ),
            headerVisible: false,
            calendarStyle: CalendarStyle(
              todayDecoration: const BoxDecoration(
                color: Color(0xFFCCE7FF),
                shape: BoxShape.circle,
              ),
              selectedDecoration: const BoxDecoration(
                color: Color(0xFFCCE7FF),
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
                        color: status == 'Late' ? Colors.blue : Colors.black,
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
                    color: Color(0xFF5DBBFF),
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
        ],
      ),
    );
  }

  Widget _buildOverviewCard(AttendanceCalendarViewModel vm) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Color(0xFFE0E0E0),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text('Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Text('Total Days : 31', style: TextStyle(color: Colors.black54, fontSize: 14)),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatBox("Presence", vm.presentCount, AppColors.green),
              _buildStatBox("Absence", vm.absentCount, AppColors.red),
              _buildStatBox("Leaves", vm.leaveCount, AppColors.orange),
              _buildStatBox("Late", vm.lateCount, AppColors.blue),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, int count, Color color) {
    return Container(
      width: 72,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE0E0E0), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
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

  Widget _buildPieChart(AttendanceCalendarViewModel vm) {
    final dataMap = {
      "Presence": 20.0, // Hardcoded to match reference
      "Absence": 3.0,
      "Leaves": 2.0,
      "Late": 6.0,
    };

    final colorList = [
      Colors.green,  // Presence
      Colors.red,    // Absence
      Colors.orange, // Leaves
      Colors.blue,   // Late
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: PieChart(
        dataMap: dataMap,
        colorList: colorList,
        chartType: ChartType.ring,
        chartRadius: 120,
        ringStrokeWidth: 40,
        centerText: "", // Hardcoded total
        centerTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        chartValuesOptions: ChartValuesOptions(
          showChartValues: true,
          showChartValuesInPercentage: false,
          showChartValuesOutside: true,
          decimalPlaces: 0,
          chartValueStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        legendOptions: LegendOptions(
          showLegends: false,
          legendPosition: LegendPosition.bottom,
          legendTextStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDayDetails(AttendanceCalendarViewModel vm) {
    // Mock data for demonstration
    final date = DateTime(2025, 6, 18);
    final status = 'Present';
    final checkIn = '09:30 AM';
    final checkOut = '06:00 PM';
    final workMode = 'Office';
    final verification = 'Selfie';
    final location = 'Lat: 13.05, Long: 80.24';
    final notes = 'Worked On UI Bug Fixing';

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
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // This will push items to both ends
            children: [
              Text(
                'Status',
                style: TextStyle(color: Colors.black54, fontSize: 16),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFFDAFFDA),
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
          const SizedBox(height: 12),
          Divider(thickness: 1, color: Color(0xFFE0E0E0), height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.green),
                      const SizedBox(width: 6),
                      Text('Check-in', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(checkIn, style: TextStyle(color: AppColors.green, fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
              Icon(Icons.arrow_forward_ios, size: 20, color: Colors.black26),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle_outline, color: AppColors.green),
                      const SizedBox(width: 6),
                      Text('Check-out', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(checkOut, style: TextStyle(color: AppColors.green, fontSize: 16, fontWeight: FontWeight.w500)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE0E0E0), width: 1),
                  ),
                  child: Column(
                    children: [
                      Text('Work Mode', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFE8EDFF),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(workMode, style: TextStyle(color: AppColors.blue, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Color(0xFFE0E0E0), width: 1),
                  ),
                  child: Column(
                    children: [
                      Text('Verification', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF0D6),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(verification, style: TextStyle(color: AppColors.orange, fontWeight: FontWeight.bold)),
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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE0E0E0), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on, color: Colors.red, size: 20),
                    const SizedBox(width: 8),
                    Text('Location', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
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
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE0E0E0), width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.notes, color: Colors.black54, size: 20),
                    const SizedBox(width: 8),
                    Text('Notes', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w500)),
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
        ],
      ),
    );
  }

  static Color _statusBackgroundColor(String status) {
    switch (status) {
      case 'Present':
        return const Color(0xFFDAFFDA);
      case 'Absent':
        return const Color(0xFFFFD6D6);
      case 'Leave':
        return const Color(0xFFFFEACC);
      case 'Late':
        return const Color(0xFFD6EEFF);
      default:
        return Colors.white;
    }
  }
}
