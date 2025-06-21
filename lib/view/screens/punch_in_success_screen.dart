import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:provider/provider.dart';
import '../../view_model/punch_in_success_view_model.dart';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _goHome();
        return false;
      },
      child: ChangeNotifierProvider(
        create: (_) => PunchInSuccessViewModel(),
        child: Consumer<PunchInSuccessViewModel>(
          builder: (context, viewModel, child) {
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
                      AppColors.verylightgreen, // Light green
                     AppColors.brightMintGreen, // Darker green
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
                      " Punch in Successfully",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.green[800],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "at ${viewModel.currentTime}",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.green800,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
