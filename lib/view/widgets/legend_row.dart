import 'package:flutter/material.dart';

class LegendRow extends StatelessWidget {
  final List<LegendItem> items;
  final double spacing;
  final double indicatorSize;
  final TextStyle? textStyle;

  const LegendRow({
    super.key,
    required this.items,
    this.spacing = 16,
    this.indicatorSize = 14,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: items.map((item) {
        final isLast = items.last == item;
        return Row(
          children: [
            Container(
              width: indicatorSize,
              height: indicatorSize,
              decoration: BoxDecoration(
                color: item.color,
                shape: BoxShape.rectangle,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              item.label,
              style: textStyle ?? const TextStyle(fontWeight: FontWeight.w600),
            ),
            if (!isLast) SizedBox(width: spacing),
          ],
        );
      }).toList(),
    );
  }
}

class LegendItem {
  final String label;
  final Color color;

  const LegendItem({
    required this.label,
    required this.color,
  });
} 