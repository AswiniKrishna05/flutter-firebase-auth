import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import '../../view_model/face_capture_view_model.dart';
import 'punch_in_success_screen.dart';
import 'punch_out_success_screen.dart';

class FaceCaptureScreen extends StatelessWidget {
  final bool isPunchIn;
  const FaceCaptureScreen({super.key, required this.isPunchIn});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => FaceCaptureViewModel(),
      child: Consumer<FaceCaptureViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.white, AppColors.skyblue],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.70, 1.0],
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    AppStrings.centerYourFace
                    ,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    AppStrings.pointFaceAtBox
                    ,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 72),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(Icons.camera_alt, color: AppColors.black),
                        ),
                        const SizedBox(width: 28),
                        GestureDetector(
                          onTap: () {
                            if (isPunchIn) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PunchInSuccessScreen(),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PunchOutSuccessScreen(),
                                ),
                              );
                            }
                          },
                          child: const CircleAvatar(
                            radius: 36,
                            backgroundColor: AppColors.blue,
                            backgroundImage: NetworkImage('https://cdn.vectorstock.com/i/500p/12/39/ok-icon-white-on-the-blue-background-vector-3451239.jpg'),
                          ),
                        ),
                        const SizedBox(width: 28),
                        const CircleAvatar(
                          backgroundColor: AppColors.white,
                          child: Icon(Icons.flash_on, color: AppColors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
