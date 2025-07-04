import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/app_colors.dart';
import '../../constants/strings.dart';
import '../screens/notification_screen.dart';

class HeaderCard extends StatelessWidget {
  const HeaderCard({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue.shade900, Colors.green],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: const BorderRadius.horizontal(
                    right: Radius.circular(28),
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
                child: Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            "https://media.gettyimages.com/id/1317804578/photo/one-businesswoman-headshot-smiling-at-the-camera.jpg?s=612x612&w=gi&k=20&c=tFkDOWmEyqXQmUHNxkuR5TsmRVLi5VZXYm3mVsjee0E=",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<String>(
                          future: () async {
                            final prefs = await SharedPreferences.getInstance();
                            return prefs.getString('fullName') ?? 'User';
                          }(),
                          builder: (context, snapshot) {
                            final name = snapshot.data ?? 'User';
                            return Text(
                              name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                        const Text(
                          AppStrings.fullStackDeveloper,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                top: 6,
                right: -7,
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/ziya_logo.png'),
                  radius: 26,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        // Notification Bell with Red Dot
    GestureDetector(
     onTap: () {
      Navigator.push(
        context,
       MaterialPageRoute(
          builder: (context) => const NotificationScreen(),
        ),
      );
    },
    child:
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                  )
                ],
              ),
              padding: const EdgeInsets.all(6),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,

                size: 28,
              ),
            ),
            Positioned(
              right: 4,
              top: 4,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 1),
                ),
              ),
            )
          ],
        ),)
      ],
    );
  }
}
