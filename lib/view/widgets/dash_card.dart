import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';

class DashCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color colour;
  final VoidCallback? onTap; // <-- add this

  const DashCard({
    super.key,
    required this.label,
    required this.icon,
    required this.colour,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 120,
        height: 160,
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.white),
            borderRadius: BorderRadius.circular(14),
            color: AppColors.white,
            boxShadow: const [
              BoxShadow(
                color: AppColors.transparentBlack,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: colour.withOpacity(0.15),
                ),
                child: Icon(icon, color: colour, size: 24),
              ),
              const SizedBox(height: 8),
              Flexible(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(fontSize: 13),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
