import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import 'dashboard_content_screen.dart';
import 'apply_leave_screen.dart';
import 'package:provider/provider.dart';
import '../../view_model/leave_screen_viewmodel.dart';
import '../widgets/custom_app_bar.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveScreenViewModel(),
      child: Consumer<LeaveScreenViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: const CustomAppBar(),
            body: Column(
              children: [
                // Tab Bar
                _LeaveTabBar(
                  selectedIndex: viewModel.selectedTab,
                  onTabSelected: (index) {
                    viewModel.setSelectedTab(index);
                  },
                ),
                // Tab Content
                Expanded(
                  child: viewModel.selectedTab == 0
                      ? const DashboardContentScreen()
                      : const ApplyLeaveScreen(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LeaveTabBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTabSelected;

  const _LeaveTabBar({
    Key? key,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color blue = const Color(0xFF2196F3);

    return Container(
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(0),
              child: Container(
                decoration: BoxDecoration(
                  color: selectedIndex == 0
                      ? blue.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.dashboard,
                        color: selectedIndex == 0 ? blue : Colors.black54,
                        size: 20),
                    const SizedBox(width: 6),
                    Text(
                      AppStrings.dashboard,
                      style: TextStyle(
                        color: selectedIndex == 0 ? blue : Colors.black54,
                        fontWeight: selectedIndex == 0
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(1),
              child: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: selectedIndex == 1
                      ? blue.withOpacity(0.08)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment,
                        color: selectedIndex == 1 ? blue : Colors.black54,
                        size: 20),
                    const SizedBox(width: 6),
                    Text(
                      AppStrings.requestLeave,
                      style: TextStyle(
                        color: selectedIndex == 1 ? blue : Colors.black54,
                        fontWeight: selectedIndex == 1
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
