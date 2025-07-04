import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import '../../view_model/face_verification_view_model.dart';
import 'face_capture_screen.dart';

class FaceVerificationScreen extends StatefulWidget {
  final bool isPunchIn;
  const FaceVerificationScreen({super.key, required this.isPunchIn});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen> with TickerProviderStateMixin {
  late FaceVerificationViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = FaceVerificationViewModel();
    viewModel.init(this);
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 180;
    return ChangeNotifierProvider<FaceVerificationViewModel>.value(
      value: viewModel,
      child: Consumer<FaceVerificationViewModel>(
        builder: (context, vm, child) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      const Text(
                        AppStrings.faceVerification
                        ,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        AppStrings.pleaseCaptureYourFace
                        ,
                        style: TextStyle(fontSize: 16, color: AppColors.grey),
                      ),
                      const SizedBox(height: 80),
                      Center(
                        child: SizedBox(
                          width: imageSize,
                          height: imageSize,
                          child: Stack(
                            children: [
                              Container(
                                width: imageSize,
                                height: imageSize,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(color: AppColors.black12, blurRadius: 6),
                                  ],
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(
                                  'assets/verification_image.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              AnimatedBuilder(
                                animation: vm.animation,
                                builder: (context, _) {
                                  return Positioned(
                                    top: vm.animation.value * imageSize,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      height: 2,
                                      color: AppColors.blueAccent.withOpacity(0.8),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FaceCaptureScreen(isPunchIn: widget.isPunchIn),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.blue,
                            foregroundColor: AppColors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            AppStrings.takePhoto
                            ,
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
