import 'package:flutter/material.dart';
import 'task_tracker_card.dart';

class TaskTrackerTab extends StatelessWidget {
  const TaskTrackerTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        TaskTrackerCard(
          title: "Responsive Design",
          dueDate: "18-06-2025",
          progress: 0.45,
          status: "In Progress",
          priority: "Medium",
        ),
        TaskTrackerCard(
          title: "UI/UX Design Implementation",
          dueDate: "18-06-2025",
          progress: 0.69,
          status: "Completed",
          priority: "High",
        ),
        TaskTrackerCard(
          title: "Back-end Development",
          dueDate: "18-06-2025",
          progress: 0.75,
          status: "In Progress",
          priority: "High",
        ),
        TaskTrackerCard(
          title: "Server-Side Logic",
          dueDate: "18-06-2025",
          progress: 0.25,
          status: "In Progress",
          priority: "Low",
        ),
      ],
    );
  }
}
