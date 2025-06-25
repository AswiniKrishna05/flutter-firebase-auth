import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      currentIndex: 0,
      selectedItemColor: AppColors.blue,
      unselectedItemColor: AppColors.grey,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.history_edu), label: 'History'),
        BottomNavigationBarItem(icon: Icon(Icons.arrow_circle_right_sharp), label: 'Leave'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}