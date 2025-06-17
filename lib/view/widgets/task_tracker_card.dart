import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import '../../view_model/task_tracker_view_model.dart';

class TaskTrackerCard extends StatelessWidget {
  final String title;
  final String dueDate;
  final double progress;
  final String status;
  final String priority;
  final String? assignedBy;

  const TaskTrackerCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.progress,
    required this.status,
    required this.priority,
    this.assignedBy,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TaskTrackerViewModel(),
      child: Consumer<TaskTrackerViewModel>(
        builder: (context, viewModel, _) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title and Due Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF43A047),
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    'Due Date: $dueDate',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // Status Row
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const Text('Status:', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 8),
                    _statusDot('Not Started', status),
                    const SizedBox(width: 2),
                    const Text('Not Started', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    _statusDot('In Progress', status),
                    const SizedBox(width: 2),
                    const Text('In Progress', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    _statusDot('Completed', status),
                    const SizedBox(width: 2),
                    const Text('Completed', style: TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    _statusDot('Overdue', status),
                    const SizedBox(width: 2),
                    const Text('Overdue', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Progress, Remaining, Assigned
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Progress:', style: TextStyle(fontSize: 13)),
                    const SizedBox(width: 8),
                    CircularPercentIndicator(
                      radius: 18.0,
                      lineWidth: 4.0,
                      percent: progress,
                      center: Text(
                        "${(progress * 100).round()}%",
                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                      progressColor: const Color(0xFF43A047),
                      backgroundColor: Colors.grey.shade300,
                    ),
                    const SizedBox(width: 12),
                    Icon(Icons.access_time, color: Colors.orange, size: 16),
                    const SizedBox(width: 2),
                    Text(
                      '"${viewModel.getRemainingDays(dueDate)}"',
                      style: const TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                    const SizedBox(width: 12),
                    const Icon(Icons.edit, size: 16, color: Colors.grey),
                    const SizedBox(width: 2),
                    Text(
                      'Assigned By\n(optional)',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              // Priority Row
              Row(
                children: [
                  const Text('Priority', style: TextStyle(fontSize: 13)),
                  const SizedBox(width: 8),
                  _priorityLabel('Low', priority),
                  const SizedBox(width: 8),
                  _priorityLabel('Medium', priority),
                  const SizedBox(width: 8),
                  _priorityLabel('High', priority),
                ],
              ),
              const SizedBox(height: 8),
              // Actions Row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _actionRadio('Start', priority == 'Low'),
                  _actionRadio('Update', priority == 'Medium'),
                  _actionRadio('Complete', priority == 'High'),
                ],
              ),
              const SizedBox(height: 12),
              // Dotted line divider
              _DottedLine(),
              const SizedBox(height: 12),
            ],
          );
        },
      ),
    );
  }

  Widget _statusDot(String label, String selected) {
    Color color;
    switch (label) {
      case 'Not Started':
        color = Colors.grey;
        break;
      case 'In Progress':
        color = Colors.orange;
        break;
      case 'Completed':
        color = Colors.green;
        break;
      case 'Overdue':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Icon(
      Icons.circle,
      size: 10,
      color: label == selected ? color : Colors.grey.shade300,
    );
  }

  Widget _priorityLabel(String label, String selected) {
    Color color;
    switch (label) {
      case 'Low':
        color = Colors.green;
        break;
      case 'Medium':
        color = Colors.orange;
        break;
      case 'High':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }
    return Text(
      label,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
        color: selected == label ? color : Colors.black,
      ),
    );
  }

  Widget _actionRadio(String label, bool selected) {
    return Row(
      children: [
        Icon(
          selected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
          size: 16,
          color: selected ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 2),
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: selected ? Colors.green : Colors.black,
          ),
        ),
      ],
    );
  }
}

class _DottedLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: 1,
              color: Colors.grey.shade400,
            );
          }),
        );
      },
    );
  }
}
