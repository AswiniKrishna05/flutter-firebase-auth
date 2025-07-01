import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../../model/report_model.dart';

class ReusableTable extends StatelessWidget {
  final List<AttendanceLog> logs;

  const ReusableTable({super.key, required this.logs});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      case 'Half Day':
        return Colors.orange;
      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildTableHeader(),
          // 👉 Start dotted lines immediately after the header
          ...logs.asMap().entries.map((entry) {
            final index = entry.key;
            final log = entry.value;

            return Column(
              children: [
                if (index >= 0) // add dotted line before all rows except the first
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: DottedLine(
                      dashLength: 4,
                      dashGapLength: 4,
                      lineThickness: 1,
                      dashColor: Colors.grey,
                    ),
                  ),
                _buildTableRow(log),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [
          _HeaderCell('Date'),
          _HeaderCell('Check-in'),
          _HeaderCell('Check-out'),
          _HeaderCell('Total Hrs'),
          _HeaderCell('Status'),
        ],
      ),
    );
  }

  Widget _buildTableRow(AttendanceLog log) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _TableCell(log.date),
          _TableCell(log.checkIn),
          _TableCell(log.checkOut),
          _TableCell(log.totalHours),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              log.status,
              style: TextStyle(color: _getStatusColor(log.status)),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  final String text;

  const _HeaderCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;

  const _TableCell(this.text);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 13,
        ),
      ),
    );
  }

}
