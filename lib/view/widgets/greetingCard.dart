import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../dialogs/checkin_dialog.dart';
import '../dialogs/checkout_dialog.dart';

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  bool isPunchedIn = false;
  DateTime? punchInTime;

  @override
  void initState() {
    super.initState();
    loadPunchState();
  }

  Future<void> loadPunchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isPunchedIn = prefs.getBool('isPunchedIn') ?? false;
      final storedTime = prefs.getString('punchInTime');
      if (storedTime != null) {
        punchInTime = DateTime.tryParse(storedTime);
      }
    });
  }

  Future<void> savePunchState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isPunchedIn', isPunchedIn);
    if (punchInTime != null) {
      await prefs.setString('punchInTime', punchInTime!.toIso8601String());
    }
  }

  void handlePunchIn(BuildContext context) {
    setState(() {
      isPunchedIn = true;
      punchInTime = DateTime.now();
    });
    savePunchState();
    showPunchInTypeDialog(context);

    // Navigate to success screen with punchInTime
    Navigator.pushNamed(
      context,
      '/punchInSuccess',
      arguments: punchInTime,
    );
  }

  void handlePunchOut(BuildContext context) {
    setState(() {
      isPunchedIn = false;
      punchInTime = null;
    });
    savePunchState();
    showCheckoutDialog(context);
  }

  String formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final suffix = hour >= 12 ? 'pm' : 'am';
    final hour12 = hour % 12 == 0 ? 12 : hour % 12;
    return '$hour12:$minute $suffix';
  }

  String formatDate(DateTime dateTime) {
    final day = dateTime.day.toString().padLeft(2, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final year = dateTime.year;
    return '$day-$month-$year';
  }

  @override
  Widget build(BuildContext context) {
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
              isPunchedIn
                  ? "You're currently punched-in"
                  : "You haven't punched-in yet",
              style: TextStyle(
                color: isPunchedIn ? AppColors.blue : AppColors.red,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            if (!isPunchedIn) const SizedBox(height: 30),
            const SizedBox(height: 10),
            if (isPunchedIn) ...[
              Row(
                children: [
                  const Icon(Icons.access_time, color: AppColors.orange),
                  const SizedBox(width: 8),
                  Text(
                    punchInTime != null
                        ? '${formatTime(punchInTime!)}_${formatDate(punchInTime!)}'
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
                    onPressed: isPunchedIn
                        ? null
                        : () => handlePunchIn(context),
                    icon: const Icon(Icons.login),
                    label: const Text("Punch In"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor:
                      !isPunchedIn ? Colors.blue : Colors.grey[300],
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
                    onPressed: isPunchedIn
                        ? () => handlePunchOut(context)
                        : null,
                    icon: const Icon(Icons.logout),
                    label: const Text("Punch Out"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor:
                      isPunchedIn ? Colors.blue : Colors.grey[300],
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
  }
}
