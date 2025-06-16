import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PunchOutSuccessScreen extends StatelessWidget {
  const PunchOutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get current time formatted
    final String punchOutTime = DateFormat('hh:mm a').format(DateTime.now());

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFFED7A5),
              Color(0xFFF98200),
            ],stops: [0.2, 0.6,1.0],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircleAvatar(
                radius: 40,
                backgroundColor: Color(0xFFF98200),
                backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPgDnk5iYyTNOYpBPBjTyLILNeYcINSqs2EQ&s'),
              ),
              const SizedBox(height: 16),
              const Text(
                'Punch out successfully at',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFF98200),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                punchOutTime,
                style: const TextStyle(
                  fontSize: 18,
                  color: Color(0xFFF98200),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
