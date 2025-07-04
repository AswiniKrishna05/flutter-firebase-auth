import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

class OverviewRow extends StatelessWidget {
  const OverviewRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _OverviewCard(label: 'Presence', value: '20', colour: Color(0xFF0A9C44)),
        _OverviewCard(label: 'Absence', value: '03', colour: Color(0xFFCC2029)),
        _OverviewCard(label: 'Leaves', value: '02', colour: Color(0xFFE67E00)),
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final String label;
  final String value;
  final Color colour;

  const _OverviewCard(
      {super.key,
        required this.label,
        required this.value,
        required this.colour});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 96,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color:  AppColors.white),
          boxShadow: const [
            BoxShadow(
                color: Color(0x11000000), blurRadius: 4, offset: Offset(0, 2))
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(fontSize: 15, color: colour, height: 2)),
            Text(value,
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold, color: colour)),
          ],
        ),
      ),
    );
  }
}