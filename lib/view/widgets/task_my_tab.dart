import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import 'dashboard_grid.dart';

class TaskMyTab extends StatelessWidget {
  const TaskMyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          TaskListItem(
            title: 'UI/UX Design Implementation',
            description:
            'Translating design specifications into functional and visually appealing user interfaces using technologies like HTML, CSS, and JavaScript.',
          ),
          SizedBox(height: 20),
          TaskListItem(
            title: 'Responsive Design',
            description:
            'Ensuring that the application adapts seamlessly to different screen sizes and devices.',
          ),
          SizedBox(height: 20),
          TaskListItem(
            title: 'Back-end Development',
            description:
            'Creating and managing databases for efficient data storage, retrieval, and processing.',
          ),
          SizedBox(height: 20),
          TaskListItem(
            title: 'Server- Side Logic',
            description:
            'Developing and Maintaining the Logic that runs on the server, handling user requests, processing data, and interacting with databases.',
          ),
          SizedBox(height: 12),
          DashboardGrid(),
        ],
      ),
    );
  }
}

class TaskListItem extends StatelessWidget {
  final String title;
  final String description;

  const TaskListItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.green,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: const TextStyle(fontSize: 14, color: AppColors.black),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              minimumSize: const Size(60, 28),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: const Text(
              "Start",
              style: TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        const DottedDivider(),
      ],
    );
  }
}
class DottedDivider extends StatelessWidget {
  final Color color;

  const DottedDivider({this.color = AppColors.grey, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dotCount = (screenWidth / 6).floor(); // approx every 6px

    return Center(
      child: Wrap(
        spacing: 3,
        children: List.generate(dotCount, (index) {
          return Container(
            width: 2,
            height: 1,
            color: color,
          );
        }),
      ),
    );
  }
}

