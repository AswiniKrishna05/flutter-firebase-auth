import 'package:flutter/material.dart';

class SortFilterBar extends StatelessWidget {
  final int selectedSortIndex;
  final Function(int) onSortSelected;

  const SortFilterBar({
    super.key,
    required this.selectedSortIndex,
    required this.onSortSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Sort by:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 16),
            _buildRadioOption("Deadline", 0),
            const SizedBox(width: 16),
            _buildRadioOption("Project", 1),
            const SizedBox(width: 16),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.tune,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String label, int index) {
    return GestureDetector(
      onTap: () => onSortSelected(index),
      child: Row(
        children: [
          Radio<int>(
            value: index,
            groupValue: selectedSortIndex,
            onChanged: (val) => onSortSelected(index),
          ),
          Text(label),
        ],
      ),
    );
  }
}
