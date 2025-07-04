import 'package:flutter/material.dart';
import '../../utils/constants/app_colors.dart';
import 'screen_header.dart';
import 'summary_grid.dart';
import 'section_header.dart';
import 'legend_row.dart';


class ComponentUsageExamples {
  
  ///  Dashboard Screen with Summary Cards
  static Widget buildDashboardExample() {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Screen Header with custom actions
            ScreenHeader(
              title: 'Dashboard',
              actions: [
                IconButton(
                  icon: const Icon(Icons.notifications),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 16),
            
            // Summary Grid with different configurations
            SummaryGrid(
              cards: [
                const SummaryCardData(
                  title: 'Total Projects',
                  value: '12',
                  icon: Icons.folder,
                  subtitle: 'active',
                ),
                const SummaryCardData(
                  title: 'Team Members',
                  value: '8',
                  icon: Icons.people,
                  subtitle: 'online',
                ),
                const SummaryCardData(
                  title: 'Tasks Pending',
                  value: '23',
                  icon: Icons.pending,
                  subtitle: 'urgent',
                  iconColor: Colors.orange,
                ),
                const SummaryCardData(
                  title: 'Completed',
                  value: '156',
                  icon: Icons.check_circle,
                  subtitle: 'this month',
                  iconColor: Colors.green,
                ),
              ],
            ),
            
            // Section Headers with different styles
            const SectionHeader(
              title: 'Recent Activities',
              fontSize: 16,
              padding: EdgeInsets.only(top: 32, bottom: 16),
            ),

            const Text('Activity list would go here'),
            
            const SectionHeader(
              title: 'Performance Metrics',
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            
            // Legend for charts
            LegendRow(
              items: const [
                LegendItem(label: 'Target', color: Colors.blue),
                LegendItem(label: 'Actual', color: Colors.green),
                LegendItem(label: 'Forecast', color: Colors.orange),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Example 2: Profile Screen
  static Widget buildProfileExample() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Screen Header without back button (for main screens)
            ScreenHeader(
              title: 'My Profile',
              onBackPressed: null, // No back button
              actions: [
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {},
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Summary Grid with 3 columns
            SummaryGrid(
              crossAxisCount: 3,
              childAspectRatio: 0.8,
              cards: [
                const SummaryCardData(
                  title: 'Experience',
                  value: '5',
                  icon: Icons.work,
                  subtitle: 'years',
                ),
                const SummaryCardData(
                  title: 'Projects',
                  value: '45',
                  icon: Icons.assignment,
                  subtitle: 'completed',
                ),
                const SummaryCardData(
                  title: 'Rating',
                  value: '4.8',
                  icon: Icons.star,
                  subtitle: 'out of 5',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  
  /// Example 3: Analytics Screen
  static Widget buildAnalyticsExample() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ScreenHeader(title: 'Analytics'),
            
            const SizedBox(height: 16),
            
            // Summary Grid with custom styling
            SummaryGrid(
              cards: [
                SummaryCardData(
                  title: 'Revenue',
                  value: '\$45.2K',
                  icon: Icons.trending_up,
                  subtitle: 'this month',
                  iconColor: Colors.green,
                  backgroundColor: Colors.green[50],
                ),
                SummaryCardData(
                  title: 'Expenses',
                  value: '\$12.8K',
                  icon: Icons.trending_down,
                  subtitle: 'this month',
                  iconColor: Colors.red,
                  backgroundColor: Colors.red[50],
                ),
                SummaryCardData(
                  title: 'Profit',
                  value: '\$32.4K',
                  icon: Icons.account_balance_wallet,
                  subtitle: 'this month',
                  iconColor: Colors.blue,
                  backgroundColor: Colors.blue[50],
                ),
                SummaryCardData(
                  title: 'Growth',
                  value: '+12.5%',
                  icon: Icons.show_chart,
                  subtitle: 'vs last month',
                  iconColor: Colors.purple,
                  backgroundColor: Colors.purple[50],
                ),
              ],
            ),
            
            const SectionHeader(
              title: 'Monthly Trends',
              trailing: Icon(Icons.info_outline),
            ),
            
            LegendRow(
              items: const [
                LegendItem(label: 'Revenue', color: Colors.green),
                LegendItem(label: 'Expenses', color: Colors.red),
                LegendItem(label: 'Profit', color: Colors.blue),
              ],
              spacing: 24,
              indicatorSize: 16,
            ),
          ],
        ),
      ),
    );
  }
  
  /// Example 4: Settings Screen
  static Widget buildSettingsExample() {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const ScreenHeader(title: 'Settings'),
            
            const SizedBox(height: 24),
            
            // Summary Grid for quick stats
            SummaryGrid(
              crossAxisCount: 1,
              childAspectRatio: 2.0,
              cards: [
                SummaryCardData(
                  title: 'Account Status',
                  value: 'Premium',
                  icon: Icons.verified_user,
                  subtitle: 'Active until Dec 2024',
                  iconColor: AppColors.gold,
                ),
              ],
            ),
            
            const SectionHeader(
              title: 'Preferences',
              fontSize: 16,
              padding: EdgeInsets.only(top: 32, bottom: 16),
            ),
            
            // Your settings content here...
            const Text('Settings options would go here'),
          ],
        ),
      ),
    );
  }
}
