import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants/app_colors.dart';
import '../../view_model/punch_in_success_view_model.dart';
import '../dialogs/checkin_dialog.dart';
import '../dialogs/checkout_dialog.dart';

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  @override
  void initState() {
    super.initState();
    // Load punch state when widget initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = Provider.of<PunchInSuccessViewModel>(context, listen: false);
      viewModel.loadPunchState();
    });
  }

  void handlePunchIn(BuildContext context) {
    final viewModel = Provider.of<PunchInSuccessViewModel>(context, listen: false);
    viewModel.punchIn();
    showPunchInTypeDialog(context);

    // Navigate to success screen with punchInTime
    Navigator.pushNamed(
      context,
      '/punchInSuccess',
      arguments: viewModel.punchInTime,
    );
  }

  void handlePunchOut(BuildContext context) {
    final viewModel = Provider.of<PunchInSuccessViewModel>(context, listen: false);
    viewModel.punchOut();
    showCheckoutDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PunchInSuccessViewModel>(
      builder: (context, viewModel, child) {
        return Card(
          elevation: 2,
          margin: const EdgeInsets.all(16),
          color: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  viewModel.isPunchedIn
                      ? "You're currently punched-in"
                      : "You haven't punched-in yet",
                  style: TextStyle(
                    color: viewModel.isPunchedIn ? AppColors.blue : AppColors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                if (!viewModel.isPunchedIn) const SizedBox(height: 30),
                const SizedBox(height: 10),
                if (viewModel.isPunchedIn) ...[
                  Row(
                    children: [
                      const Icon(Icons.access_time, color: AppColors.orange),
                      const SizedBox(width: 8),
                      Text(
                        viewModel.punchInTime != null
                            ? '${viewModel.formatTime(viewModel.punchInTime!)}_${viewModel.formatDate(viewModel.punchInTime!)}'
                            : '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppColors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Icon(Icons.location_pin, color: AppColors.red),
                      SizedBox(width: 7),
                      Text(
                        'Location/IP (for remote attendance)',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: viewModel.isPunchedIn
                            ? null
                            : () => handlePunchIn(context),
                        icon: const Icon(Icons.login),
                        label: const Text("Punch In"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor:
                          !viewModel.isPunchedIn ? Colors.blue : Colors.grey[300],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: viewModel.isPunchedIn
                            ? () => handlePunchOut(context)
                            : null,
                        icon: const Icon(Icons.logout),
                        label: const Text("Punch Out"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor:
                          viewModel.isPunchedIn ? Colors.blue : Colors.grey[300],
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
