import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_firebase_auth/view/widgets/custom_app_bar.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';

class HistoryBottomScreen extends StatefulWidget {
  const HistoryBottomScreen({super.key});

  @override
  State<HistoryBottomScreen> createState() => _HistoryBottomScreenState();
}

class _HistoryBottomScreenState extends State<HistoryBottomScreen> {
  bool isLoading = false;

  Future<void> _logout() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Show confirmation dialog
      bool? shouldLogout = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Logout'),
            content: const Text('Are you sure you want to logout?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
                             TextButton(
                 onPressed: () => Navigator.of(context).pop(true),
                 style: TextButton.styleFrom(
                   foregroundColor: Colors.blue,
                 ),
                 child: const Text('Logout'),
               ),
            ],
          );
        },
      );

      if (shouldLogout == true) {
        // Clear SharedPreferences data
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // Sign out from Firebase
        await FirebaseAuth.instance.signOut();

        // Navigate to login screen
        if (mounted) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/login',
            (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      // Show error dialog
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to logout: $e'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                                         // Logout Card
                     Card(
                       elevation: 2,
                       child: Container(
                         width: 200,
                         padding: const EdgeInsets.all(16),
                         child: Column(
                           mainAxisSize: MainAxisSize.min,
                           children: [
                                                           const Icon(
                                Icons.logout,
                                color: Colors.blue,
                                size: 32,
                              ),
                             const SizedBox(height: 8),
                             const Text(
                               'Logout',
                               style: TextStyle(
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold,
                               ),
                             ),
                             const SizedBox(height: 4),
                             const Text(
                               'Sign out',
                               style: TextStyle(
                                 fontSize: 12,
                                 color: Colors.grey,
                               ),
                               textAlign: TextAlign.center,
                             ),
                             const SizedBox(height: 12),
                             SizedBox(
                               width: double.infinity,
                               height: 40,
                               child: ElevatedButton(
                                 onPressed: _logout,
                                 style: ElevatedButton.styleFrom(
                                   backgroundColor: Colors.blue,
                                   shape: RoundedRectangleBorder(
                                     borderRadius: BorderRadius.circular(8),
                                   ),
                                 ),
                                 child: const Text(
                                   'Logout',
                                   style: TextStyle(
                                     fontSize: 14,
                                     fontWeight: FontWeight.bold,
                                     color: Colors.white,
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ),
                     ),
                  ],
                ),
              ),
            ),
    );
  }
}
