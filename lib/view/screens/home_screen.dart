import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/strings.dart';
import '../../view_model/punch_in_success_view_model.dart';
import '../widgets/greetingCard.dart';
import '../widgets/headerCard.dart';
import '../widgets/overview_row.dart';
import '../widgets/task_section.dart';
import '../widgets/dashboard_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Load punch state when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PunchInSuccessViewModel>(context, listen: false);
      viewModel.loadPunchState();
    });
  }

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
              // Task Section - Only show if user is punched in (BEFORE dashboard)
              Consumer<PunchInSuccessViewModel>(
                builder: (context, punchViewModel, child) {
                  if (punchViewModel.isPunchedIn) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TaskSection(),
                        SizedBox(height: 28),
                      ],
                    );
                  } else {
                    return SizedBox.shrink(); // Don't show anything when not punched in
                  }
                },
              ),
              // Dashboard - Always visible after task section (or after overview if not punched in)
              Text(
                "Dashboard",
                style: TextStyle(
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 12),
              DashboardGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
