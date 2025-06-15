import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/widgets/sort_filter_bar.dart';
import 'package:flutter_firebase_auth/widgets/task_my_tab.dart';
import 'package:flutter_firebase_auth/widgets/task_tab_bar.dart';
import 'package:flutter_firebase_auth/widgets/task_tracker_tab.dart';
import 'package:flutter_firebase_auth/widgets/work_summary.dart';
import 'ongoing_pending.dart'; // Ensure this exists

class TaskSection extends StatefulWidget {
  const TaskSection({super.key});

  @override
  State<TaskSection> createState() => _TaskSectionState();
}

class _TaskSectionState extends State<TaskSection> {
  int selectedTabIndex = 0;
  int selectedSortIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Task Tab Bar
          TaskTabBar(
            selectedIndex: selectedTabIndex,
            onTabSelected: (index) {
              setState(() {
                selectedTabIndex = index;
              });
            },
          ),
          const SizedBox(height: 12),

          // Sort By / Filter Bar
          SortFilterBar(
            selectedSortIndex: selectedSortIndex,
            onSortSelected: (index) {
              setState(() {
                selectedSortIndex = index;
              });
            },
          ),
          const SizedBox(height: 12),

          // Dynamic content
          Builder(
            builder: (_) {
              switch (selectedTabIndex) {
                case 0:
                  return const TaskMyTab();
                case 1:
                  return const TaskTrackerTab();
                case 2:
                  return const OngoingPendingTab();
                case 3:
                  return const WorkSummaryTab();
                default:
                  return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
