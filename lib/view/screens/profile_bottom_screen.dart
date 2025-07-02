import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/widgets/profile_header.dart';

class ProfileBottomScreen extends StatelessWidget {
  const ProfileBottomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Header
              const ProfileHeader(),

              const SizedBox(height: 60),

              // Details Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 9.0),
                child: Container(

                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Column(

                    children: [
                      _buildDetailRow('Name', 'Hemant Rangarajan'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: DottedLine(
                          dashLength: 4,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: Colors.black12,
                        ),
                      ),
                      _buildDetailRow('Employee ID', 'EMP00123',),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: DottedLine(
                          dashLength: 4,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: Colors.black12,
                        ),
                      ),
                      _buildDetailRow('Designation', 'Full-Stack Developer'),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: DottedLine(
                          dashLength: 4,
                          dashGapLength: 4,
                          lineThickness: 1,
                          dashColor: Colors.black12,
                        ),
                      ),
                      _buildDetailRow('Department', 'Software Development Team'),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Illustration Image
              Image.asset(
                'assets/group.jpeg',
                height: 250,
              ),

              const SizedBox(height: 20),

              // Start Work Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 6,horizontal: 70),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Add your action here
                    },
                    child: const Text(
                      'Start work',
                      style: TextStyle(fontSize: 16, color: Colors.white,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Text(':'),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
