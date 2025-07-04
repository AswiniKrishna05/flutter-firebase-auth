import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import '../../utils/constants/app_colors.dart';
import 'dashboard_grid.dart';

class OngoingPendingTab extends StatelessWidget {
  const OngoingPendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TaskCard(
            title: "UI/UX Design Implementation",
            status: "Ongoing Task",
            statusColor: AppColors.blue,
            priority: "High",
            priorityColor: AppColors.red,
            progress: 0.6,
            actionText: "Make as Done",
          ),
          SizedBox(height: 16),
          TaskCard(
            title: "Responsive Design",
            status: "Pending Task",
            statusColor: AppColors.orange,
            priority: "Medium",
            priorityColor: AppColors.orange,
            progress: 0.45,
            actionText: "Start Task",
          ),
          SizedBox(height: 16),
          TaskCard(
            title: "Back-end Development",
            status: "Ongoing Task",
            statusColor: AppColors.blue,
            priority: "High",
            priorityColor: AppColors.red,
            progress: 0.75,
            actionText: "Make as Done",
          ),
          SizedBox(height: 16),
          TaskCard(
            title: "Server-Side Logic",
            status: "Pending Task",
            statusColor: AppColors.yellow,
            priority: "Low",
            priorityColor: AppColors.green600,
            progress: 0.25,
            actionText: "Start Task",
          ),
          SizedBox(height: 16),
          DashboardGrid(),
        ],
      ),
    );
  }
}

class TaskCard extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final String priority;
  final Color priorityColor;
  final double progress;
  final String actionText;

  const TaskCard({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.priority,
    required this.priorityColor,
    required this.progress,
    required this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title & Progress
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: AppColors.green,
                  ),
                ),
              ),
              Text(
                "${(progress * 100).round()}% Done",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Status
          Text.rich(
            TextSpan(
              text: "Status: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: status,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 4),
          const Text("Assigned date: 12-05-2025"),
          const Text("Due date: 12-06-2025"),

          const SizedBox(height: 4),
          Text.rich(
            TextSpan(
              text: "Priority: ",
              style: const TextStyle(fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: priority,
                  style: TextStyle(
                    color: priorityColor,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              const Spacer(),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  actionText,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// ✅ Dotted Divider Only
          const DottedLine(
            dashColor: Colors.grey,
            lineThickness: 1,
            dashLength: 5,
            dashGapLength: 4,
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
