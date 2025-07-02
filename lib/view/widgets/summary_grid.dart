import 'package:flutter/material.dart';
import 'summary_card.dart';

class SummaryGrid extends StatelessWidget {
  final List<SummaryCardData> cards;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;

  const SummaryGrid({
    super.key,
    required this.cards,
    this.crossAxisCount = 2,
    this.crossAxisSpacing = 4,
    this.mainAxisSpacing = 4,
    this.childAspectRatio = 1.1,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: crossAxisCount,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: crossAxisSpacing,
      mainAxisSpacing: mainAxisSpacing,
      childAspectRatio: childAspectRatio,
      children: cards.map((cardData) => SummaryCard(
        title: cardData.title,
        value: cardData.value,
        icon: cardData.icon,
        subtitle: cardData.subtitle,
        iconColor: cardData.iconColor,
        backgroundColor: cardData.backgroundColor,
        borderColor: cardData.borderColor,
        iconSize: cardData.iconSize,
        titleSize: cardData.titleSize,
        valueSize: cardData.valueSize,
        subtitleSize: cardData.subtitleSize,
      )).toList(),
    );
  }
}

class SummaryCardData {
  final String title;
  final String value;
  final IconData icon;
  final String? subtitle;
  final Color? iconColor;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? iconSize;
  final double? titleSize;
  final double? valueSize;
  final double? subtitleSize;

  const SummaryCardData({
    required this.title,
    required this.value,
    required this.icon,
    this.subtitle,
    this.iconColor,
    this.backgroundColor,
    this.borderColor,
    this.iconSize,
    this.titleSize,
    this.valueSize,
    this.subtitleSize,
  });
} 