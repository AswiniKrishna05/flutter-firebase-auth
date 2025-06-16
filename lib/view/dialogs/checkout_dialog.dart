import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/screens/face_verification_screen.dart';

void showCheckoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 50,
          ),
          const SizedBox(height: 16),
          const Text(
            'Do you really want to checkout!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.orange,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 2,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Handle update task
                },
                child: const Text("Update Task"),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=> const FaceVerificationScreen(isPunchIn: false,)));
                },
                child: const Text("Punch Out"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
