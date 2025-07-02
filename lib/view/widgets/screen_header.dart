import 'package:flutter/material.dart';

class ScreenHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;
  final double? titleSize;
  final Color? titleColor;

  const ScreenHeader({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
    this.titleSize,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 18,
          ),
          onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
        ),
        const SizedBox(width: 2),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: titleSize ?? 14,
              color: titleColor ?? Colors.black,
            ),
          ),
        ),
        if (actions != null) ...actions!,
      ],
    );
  }
} 