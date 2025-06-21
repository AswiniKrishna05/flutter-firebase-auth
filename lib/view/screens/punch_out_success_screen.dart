import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../constants/app_colors.dart';
import '../../view_model/punch_out_success_view_model.dart';

class PunchOutSuccessScreen extends StatefulWidget {
  const PunchOutSuccessScreen({super.key});

  @override
  State<PunchOutSuccessScreen> createState() => _PunchOutSuccessScreenState();
}

class _PunchOutSuccessScreenState extends State<PunchOutSuccessScreen> {
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
        create: (_) => PunchOutSuccessViewModel(),
        child: Consumer<PunchOutSuccessViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.white,
                      AppColors.softPeachyOrange,
                      AppColors.vibrantOrange,
                    ],
                    stops: [0.2, 0.6, 1.0],
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundColor: AppColors.vibrantOrange,
                        backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPgDnk5iYyTNOYpBPBjTyLILNeYcINSqs2EQ&s'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Punch out successfully at',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.vibrantOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        viewModel.punchOutTime,
                        style: const TextStyle(
                          fontSize: 18,
                          color: AppColors.vibrantOrange,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
