import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/constants/app_colors.dart';
import 'package:flutter_firebase_auth/view/widgets/bottom_bar.dart';
import 'dashboard_content_screen.dart';
import 'apply_leave_screen.dart';
import 'package:provider/provider.dart';
import '../../view_model/leave_screen_viewmodel.dart';
import '../../constants/strings.dart';

class LeaveScreen extends StatelessWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LeaveScreenViewModel(),
      child: Consumer<LeaveScreenViewModel>(
        builder: (context, viewModel, child) {
          final Color blue = AppColors.blue;
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                children: [
                  // Header
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Image.asset('assets/ziya_logo.png', width: 40),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Container(
                            height: 38,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(4),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: AppStrings.searchHint,
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Stack(
                          children: [
                            const Icon(Icons.notifications,
                                color: Colors.blue, size: 28),
                            Positioned(
                              right: 0,
                              top: 2,
                              child: Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 12),
                        const CircleAvatar(
                          radius: 16,
                          backgroundImage: NetworkImage(
                              'https://media.gettyimages.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=gi&k=20&c=tFkDOWmEyqXQmUHNxkuR5TsmRVLi5VZXYm3mVsjee0E='),
                        ),
                      ],
                    ),
                  ),
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
