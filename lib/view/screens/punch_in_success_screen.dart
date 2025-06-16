import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchInSuccessScreen extends StatelessWidget {
  const PunchInSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.55, 2.0],
            colors: [
              Color(0xFFE6F9E8), // Light green
              Color(0xFF60EF76), // Darker green
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 180),
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(24),
              child: Image.asset(
                'assets/green tick.png',
                width: 90,
                height: 90,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              " Punch in Successfully",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green[800],
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              "at $currentTime",
              style: TextStyle(
                fontSize: 14,
                color: Colors.green[800],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
