import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class TaskTrackerCard extends StatelessWidget {
  final String title;
  final String dueDate;
  final double progress;
  final String status;
  final String priority;

  const TaskTrackerCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.priority,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title and Due Date
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'Due Date: $dueDate',
                  style: const TextStyle(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          /// Status Row
          Wrap(
            spacing: 6,
            runSpacing: 6,
            children: [
              const Text(
                'Status:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              _buildStatusChip('Not Started', status),
              _buildStatusChip('In Progress', status),
              _buildStatusChip('Completed', status),
              _buildStatusChip('Overdue', status),
            ],
          ),
          const SizedBox(height: 12),

          /// Progress + Indicator + Remaining + Assigned in one row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 8, top: 6),
                child: Text(
                  "Progress:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              CircularPercentIndicator(
                radius: 13.0,
                lineWidth: 4.0,
                percent: progress,
                center: Text(
                  "${(progress * 100).round()}%",
                  style: const TextStyle(fontSize: 10),
                ),
                progressColor: Colors.green,
                backgroundColor: Colors.grey.shade300,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.orange, size: 14),
                        SizedBox(width: 4),
                        Text(
                          "2 days remaining",
                          style: TextStyle(color: Colors.orange, fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.edit,
                            size: 14, color: Colors.black87),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            "Assigned By (optional)",
                            style: TextStyle(fontSize: 11),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),

          /// Priority
          Row(
            children: [
              const Text("Priority: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
              _buildPriorityLabel("Low", priority),
              _buildPriorityLabel("Medium", priority),
              _buildPriorityLabel("High", priority),
            ],
          ),
          const SizedBox(height: 14),

          /// Actions
          Row(
            children: [
              Expanded(child: _buildAction("Start", priority == 'Low')),
              Expanded(child: _buildAction("Update", priority == 'Medium')),
              Expanded(child: _buildAction("Complete", priority == 'High')),
            ],
          ),

          /// Dotted Divider
          const DottedDivider(),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String label, String selectedStatus) {
    Color activeColor;
    switch (label) {
      case 'In Progress':
        activeColor = Colors.yellow;
      break;
      case 'Completed':
        activeColor = Colors.green;
        break;
      case 'Overdue':
        activeColor = Colors.grey;
        break;
      default:
        activeColor = Colors.grey;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.circle,
          size: 8,
          color: label == selectedStatus ? activeColor : Colors.grey.shade300,
        ),
        const SizedBox(width: 2),
        Text(label, style: const TextStyle(fontSize: 11)),
      ],
    );
  }

  Widget _buildPriorityLabel(String label, String selected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 12,
          color: selected == label ? Colors.teal : Colors.black,
        ),
      ),
    );
  }

  Widget _buildAction(String label, bool isSelected) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.radio_button_checked,
            size: 14, color: isSelected ? Colors.green : Colors.black),
        const SizedBox(width: 4),
        Text(label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
      ],
    );
  }
}

class DottedDivider extends StatelessWidget {
  final Color color;

  const DottedDivider({this.color = Colors.grey, super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final dotCount = (screenWidth / 6).floor();

    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
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
