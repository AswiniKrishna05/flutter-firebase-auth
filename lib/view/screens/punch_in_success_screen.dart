import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import '../../constants/strings.dart';

class PunchInSuccessScreen extends StatefulWidget {
  const PunchInSuccessScreen({super.key});

  @override
  State<PunchInSuccessScreen> createState() => _PunchInSuccessScreenState();
}

class _PunchInSuccessScreenState extends State<PunchInSuccessScreen> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), _goHome);
  }

  void _goHome() {
    if (!_navigated && mounted) {
      _navigated = true;
      Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'pm' : 'am';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute $suffix';
  }

  @override
  Widget build(BuildContext context) {
    final DateTime? punchInTime =
    ModalRoute.of(context)!.settings.arguments as DateTime?;

    return WillPopScope(
      onWillPop: () async {
        _goHome();
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.55, 2.0],
              colors: [
                AppColors.verylightgreen,
                AppColors.brightMintGreen,
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 180),
              Container(
                decoration: const BoxDecoration(
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
                AppStrings.punchInSuccess,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.green[800],
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                punchInTime != null ? "at ${formatTime(punchInTime)}" : "",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.green800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
