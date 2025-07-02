import 'package:flutter/material.dart';
import '../../constants/strings.dart';
import '../widgets/bottom_bar.dart';
import '../widgets/greetingCard.dart';
import '../widgets/headerCard.dart';
import '../widgets/overview_row.dart';
import '../widgets/task_section.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              HeaderCard(),
              SizedBox(height: 10),
              FutureBuilder<String>(
                future: () async {
                  final prefs = await SharedPreferences.getInstance();
                  return prefs.getString('fullName') ?? 'User';
                }(),
                builder: (context, snapshot) {
                  final name = snapshot.data ?? 'User';
                  return Text(
                    '${AppStrings.goodMorning}\n$name',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  );
                },
              ),
              SizedBox(height: 10),
              GreetingCard(),
              SizedBox(height: 10),
              Text(
                AppStrings.overview,
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
