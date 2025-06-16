import 'package:flutter/material.dart';
import '../dialogs/checkin_dialog.dart';
import '../dialogs/checkout_dialog.dart';

class GreetingCard extends StatefulWidget {
  const GreetingCard({super.key});

  @override
  State<GreetingCard> createState() => _GreetingCardState();
}

class _GreetingCardState extends State<GreetingCard> {
  bool isPunchedIn = false;

  void handlePunchIn(BuildContext context) {
    setState(() {
      isPunchedIn = true;
    });
    showPunchInTypeDialog(context);
  }

  void handlePunchOut(BuildContext context) {
    setState(() {
      isPunchedIn = false;
    });
    showCheckoutDialog(context);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(16),
      color: Colors.white,
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
                color: isPunchedIn ? Colors.blue : Colors.red, // ✅ Red if not punched in
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ), if (!isPunchedIn) const SizedBox(height: 30),
            const SizedBox(height: 10),

            // ✅ Show these rows only if punched in
            if (isPunchedIn) ...[
              const Row(
                children: [
                  Icon(Icons.access_time, color: Colors.orange),
                  SizedBox(width: 8),
                  Text(
                    '09:20 am_11-06-2025',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.red),
                  SizedBox(width: 7),
                  Text(
                    'Location/IP (for remote attendance)',
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black87,
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
                    onPressed: () => handlePunchIn(context),
                    icon: const Icon(Icons.login),
                    label: const Text("Punch In"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14), // ✅ Button height padding
                      backgroundColor:
                      !isPunchedIn ? Colors.grey[300] : Colors.blue,
                      foregroundColor:
                      !isPunchedIn ? Colors.white : Colors.black54,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => handlePunchOut(context),
                    icon: const Icon(Icons.logout),
                    label: const Text("Punch Out"),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14), // ✅ Button height padding
                      backgroundColor:
                      isPunchedIn ? Colors.grey[300] : Colors.blue,
                      foregroundColor:
                      isPunchedIn ? Colors.white : Colors.black54,
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
