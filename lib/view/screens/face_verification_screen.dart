import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/view/screens/face_capture_screen.dart';

class FaceVerificationScreen extends StatefulWidget {
  final bool isPunchIn;
  const FaceVerificationScreen({super.key, required this.isPunchIn});

  @override
  State<FaceVerificationScreen> createState() => _FaceVerificationScreenState();
}

class _FaceVerificationScreenState extends State<FaceVerificationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double imageSize = 180;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                const Text(
                  'Face Verification',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'Please capture your face',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(height: 80),

                // Face image with scanning line
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
                              BoxShadow(color: Colors.black12, blurRadius: 6),
                            ],
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            'assets/verification_image.png',
                            fit: BoxFit.cover,
                          ),
                        ),

                        //  Animated scanning line

                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, _) {
                            return Positioned(
                              top: _animation.value * imageSize,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2,
                                color: Colors.blueAccent.withOpacity(0.8),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                //  Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FaceCaptureScreen(isPunchIn: widget.isPunchIn),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Take Photo',
                      style:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
  }
}
