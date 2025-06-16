import 'package:flutter/material.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/greetingCard.dart';
import '../widgets/headerCard.dart';
import '../widgets/overview_row.dart';
import '../widgets/task_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              HeaderCard(),
              SizedBox(height: 10),
              Text(
                '"Good Morning,\nHemant Rangarajan"',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 10),
              GreetingCard(),
              SizedBox(height: 10),
              Text(
                'Overview',
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              OverviewRow(),
              SizedBox(height: 28),
              TaskSection(),
            ],
          ),
        ),
      ),
    );
  }
}
