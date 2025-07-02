import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/screens/profile_bottom_screen.dart';
import 'history_bottom_screen.dart';
import 'home_screen.dart';
import 'leave_bottom_screen.dart';
import 'leave_screen.dart';
import '../widgets/bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    HistoryBottomScreen(),
    LeaveBottomScreen(),
    ProfileBottomScreen(), // 👉 This is your profile screen (the one you showed)
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
