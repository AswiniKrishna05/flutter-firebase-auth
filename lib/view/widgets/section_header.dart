import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final EdgeInsets? padding;
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.color,
    this.padding,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.only(top: 24, bottom: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
                color: color ?? Colors.black,
              ),
            ),
          ),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
} 