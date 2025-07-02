import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // Background image
        Container(
          height: 180,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/banner.png'),
            ),
          ),
        ),

        // Profile Image
        Positioned(
          bottom: -40,
          left: 16,
          child: CircleAvatar(
            radius: 50,
              backgroundImage: NetworkImage('https://plus.unsplash.com/premium_photo-1672239496412-ab605befa53f?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8bWFsZXxlbnwwfHwwfHx8MA%3D%3D')          ),
        ),

        // Name and Designation
        Positioned(
          bottom: 20,
          left: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Hemant Rangarajan',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Full-stack Developer',
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w200,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
