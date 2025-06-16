import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/screens/face_verification_screen.dart';
import 'package:flutter_firebase_auth/view/screens/qr_verification_screen.dart';

void showPunchInTypeDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const Text(
                'Select Punch-In Type',

                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w200,
                ),
              ),
              const SizedBox(height: 12),

              // Subtitle
              const Text(
                "Are you working from home or on site today?",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 24),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QrVerificationScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      "On Site",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FaceVerificationScreen(isPunchIn: true,),
                        ),
                      );
                    },
                    child: const Text(
                      "Work From Home",
                      style: TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
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
