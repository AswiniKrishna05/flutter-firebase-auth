import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';

class DashboardContentScreen extends StatelessWidget {
  const DashboardContentScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final double cardWidth =
        (MediaQuery.of(context).size.width - 16 * 2 - 16) / 2;

    return Container(
      color: AppColors.white,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        children: [
          // Tab section is handled by parent, only content below

          // Stat cards
          Padding(
            padding:
                const EdgeInsets.only(left: 16, right: 16, top: 20, bottom: 0),
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                SizedBox(
                  width: cardWidth,
                  height: 130,
                  child: _StatCard(
                    title:AppStrings.totalLeaveTaken
                    ,
                    value: AppStrings.sixteenDays
                    ,
                    subtitle: AppStrings.twentyNineDaysRemainingThisYear
                    ,
                    icon: Icons.sticky_note_2_outlined,
                    iconColor: AppColors.blue,
                    color: AppColors.cardBg,
                    progress: 16 / 45,
                    textDark: AppColors.textDark,
                    textLight: AppColors.textLight,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: 130,
                  child: _StatCard(
                    title: AppStrings.approvalRate
                    ,
                    value: '92%',
                    subtitle: AppStrings.twentyNineDaysRemainingThisYear
                    ,
                    icon: Icons.pie_chart_outline,
                    iconColor: AppColors.blue,
                    color: AppColors.cardBg,
                    progress: 0.92,
                    textDark: AppColors.textDark,
                    textLight: AppColors.textLight,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: 130,
                  child: _StatCard(
                    title: AppStrings.pendingRequest
                    ,
                    value: '1',
                    subtitle: AppStrings.twentyNineDaysRemainingThisYear
                    ,
                    icon: Icons.hourglass_empty,
                    iconColor: AppColors.blue,
                    color: AppColors.cardBg,
                    progress: 1 / 45,
                    textDark: AppColors.textDark,
                    textLight: AppColors.textLight,
                  ),
                ),
                SizedBox(
                  width: cardWidth,
                  height: 130,
                  child: _StatCard(
                    title: AppStrings.teamMemberOnLeave
                    ,
                    value: '2',
                    subtitle: AppStrings.twentyNineDaysRemainingThisYear
                    ,
                    icon: Icons.groups_outlined,
                    iconColor: AppColors.blue,
                    color: AppColors.cardBg,
                    progress: 2 / 45,
                    textDark: AppColors.textDark,
                    textLight: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),

          // Leave Overview
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.leaveOverview
                      ,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color:AppColors.textDark,
                          letterSpacing: 0.1)),
                  const SizedBox(height: 4),
                  Text(AppStrings.leaveDistributionCurrentYear
                      ,
                      style: TextStyle(color: AppColors.textLight, fontSize: 12)),
                  const SizedBox(height: 24),
                  // Real Bar Chart
                  SizedBox(
                    height: 120,
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        maxY: 10,
                        barTouchData: BarTouchData(enabled: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const style = TextStyle(
                                  color: AppColors.textDark,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                );
                                switch (value.toInt()) {
                                  case 0:
                                    return Text('Q1', style: style);
                                  case 1:
                                    return Text('Q2', style: style);
                                  case 2:
                                    return Text('Q3', style: style);
                                  case 3:
                                    return Text('Q4', style: style);
                                  default:
                                    return const SizedBox.shrink();
                                }
                              },
                            ),
                          ),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(show: false),
                        barGroups: [
                          BarChartGroupData(x: 0, barRods: [
                            BarChartRodData(
                              toY: 8,
                              color:AppColors.blue,
                              width: 60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ]),
                          BarChartGroupData(x: 1, barRods: [
                            BarChartRodData(
                              toY: 5,
                              color: AppColors.blue,
                              width: 60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ]),
                          BarChartGroupData(x: 2, barRods: [
                            BarChartRodData(
                              toY: 4,
                              color:AppColors.blue,
                              width: 60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ]),
                          BarChartGroupData(x: 3, barRods: [
                            BarChartRodData(
                              toY: 3,
                              color: AppColors.blue,
                              width: 60,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: AppColors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(AppStrings.leaveDaysTaken
                          ,
                          style: TextStyle(color:AppColors.textLight, fontSize: 14)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Divider(color: AppColors.cardBorder, height: 1),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.totalDays
                          ,
                          style: TextStyle(color: AppColors.textLight, fontSize: 14)),
                      Text(AppStrings.remaining
                          ,
                          style: TextStyle(color: AppColors.textLight, fontSize: 14)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('20',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textDark)),
                      Text('29',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: AppColors.textDark)),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Upcoming Leave
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.cardBg,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.cardBorder),
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(AppStrings.upcomingLeave
                      ,
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: AppColors.textDark)),
                  const SizedBox(height: 4),
                  Text(AppStrings.yourScheduledTimeOff
                      ,
                      style: TextStyle(color:AppColors.textLight, fontSize: 14)),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.annualLeave
                              ,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: AppColors.textDark)),
                          const SizedBox(height: 2),
                          Text('April 22,2025 to Apr 24, 2025 (3 days)',
                              style: TextStyle(color: AppColors.textDark, fontSize: 12)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black26),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(AppStrings.pending
                            ,
                            style: TextStyle(
                                color: AppColors.textLight,
                                fontWeight: FontWeight.w600,
                                fontSize: 14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.yellow.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.orange, size: 22),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(AppStrings.pendingApproval
                                  ,
                                  style: TextStyle(
                                      color: AppColors.textDark,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14)),
                              const SizedBox(height: 2),
                              Text(
                                  AppStrings.leaveRequestAwaitingApproval
                                  ,
                                  style: TextStyle(
                                      color: AppColors.textLight, fontSize: 13)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final Color color;
  final double progress;
  final Color textDark;
  final Color textLight;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.color,
    required this.progress,
    required this.textDark,
    required this.textLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: textDark)),
              Icon(icon, color: iconColor, size: 22),
            ],
          ),
          const SizedBox(height: 10),
          Text(value,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: textDark,
                  letterSpacing: 0.5)),
          const SizedBox(height: 2),
          Text(subtitle, style: TextStyle(fontSize: 10, color: textLight)),
          const SizedBox(height: 8),
          title == AppStrings.totalLeaveTaken

              ? LinearProgressIndicator(
                  value: progress,
                  backgroundColor: iconColor.withOpacity(0.15),
                  valueColor: AlwaysStoppedAnimation<Color>(iconColor),
                  minHeight: 4,
                )
              : const SizedBox(height: 4),
        ],
      ),
    );
  }
}
