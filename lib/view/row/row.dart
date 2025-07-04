import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

// PaySlip Screen

class BoxInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const BoxInfoRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label,
              style: const TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(width: 4),
          const Text(":",
              style: TextStyle(fontSize: 11, color: AppColors.textLight)),
          const SizedBox(width: 4),
          Text(value,
              style:
              const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class PayslipInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const PayslipInfoRow(this.label, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(
                    color: AppColors.textLight, fontSize: 12)),
          ),
          const Text(" : "),
          Expanded(
            child: Text(value,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 12)),
          ),
        ],
      ),
    );
  }
}
Widget buildHistoryRow(
    String month, String pay, String status, String action,
    {bool isHeader = false, VoidCallback? onDownload}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(month,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(pay,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(status,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
          child: isHeader
              ? Text(action,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
              : GestureDetector(
            onTap: onDownload,
            child: Text(action,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                    decoration: TextDecoration.underline)),
          ),
        ),
      ],
    ),
  );
}
Widget _buildHistoryRow(
    String month, String pay, String status, String action,
    {bool isHeader = false, VoidCallback? onDownload}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Text(month,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(pay,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
            child: Text(status,
                style: TextStyle(
                    fontWeight:
                    isHeader ? FontWeight.bold : FontWeight.normal,
                    fontSize: 11))),
        Expanded(
          child: isHeader
              ? Text(action,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11))
              : GestureDetector(
            onTap: onDownload,
            child: Text(action,
                style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 11,
                    decoration: TextDecoration.underline)),
          ),
        ),
      ],
    ),
  );
}