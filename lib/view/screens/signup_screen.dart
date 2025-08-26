import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/constants/strings.dart';
import '../../view_model/signup_view_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  void dispose() {
    // Dispose controllers when screen is disposed
    final viewModel = Provider.of<SignupViewModel>(context, listen: false);
    viewModel.disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignupViewModel(),
      child: Consumer<SignupViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            body: Stack(
              children: [
                // Top and bottom curves
                Positioned(
                  top: -100,
                  left: -100,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2196F3),
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(300),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -80,
                  right: -80,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: const BoxDecoration(
                      color: AppColors.green600,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 60),
                          Text(
                            AppStrings.ziyaAttend,
                            style: const TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            AppStrings.appSubtitle,
                            style: const TextStyle(
                              fontSize: 22,
                              color: AppColors.green600,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 32),
                          TextFormField(
                            controller: viewModel.fullNameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.nameHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty)
                                return AppStrings.errorEmptyField;
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.emailController,
                            decoration: InputDecoration(
                              hintText: AppStrings.emailHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty)
                                return AppStrings.errorEmptyField;
                              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                  .hasMatch(v)) {
                                return AppStrings.enterValidEmail;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.phoneController,
                            decoration: InputDecoration(
                              hintText: AppStrings.mobileNumberHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            validator: (v) {
                              if (v == null || v.trim().isEmpty)
                                return AppStrings.errorEmptyField;
                              if (!RegExp(r'^\d{10}$').hasMatch(v)) {
                                return AppStrings.enterValidPhoneNumber;
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: AppStrings.passwordHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? AppStrings.errorEmptyField
                                : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.confirmPasswordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: AppStrings.confirmPasswordHint,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 14),
                            ),
                            validator: (v) => v == null || v.isEmpty
                                ? AppStrings.errorEmptyField
                                : null,
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: viewModel.isLoading
                                  ? null
                                  : () async {
                                      print('Signup button pressed'); // Debug log
                                      
                                      // Validate form first
                                      if (!viewModel.formKey.currentState!.validate()) {
                                        print('Form validation failed'); // Debug log
                                        return;
                                      }
                                      
                                      print('Form validation passed, calling signup...'); // Debug log
                                      final error = await viewModel.signup();
                                      print('Signup result: $error'); // Debug log
                                      
                                      if (error == null) {
                                        print('Signup successful, showing success dialog'); // Debug log
                                        
                                        // Clear form after successful signup
                                        viewModel.fullNameController.clear();
                                        viewModel.emailController.clear();
                                        viewModel.phoneController.clear();
                                        viewModel.passwordController.clear();
                                        viewModel.confirmPasswordController.clear();
                                        
                                        // Show success dialog
                                        if (mounted) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => AlertDialog(
                                              title: Text(AppStrings.signupSuccess),
                                              content: Text('Account created successfully! Please login.'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    print('OK button pressed, navigating to login'); // Debug log
                                                    Navigator.pop(context); // Close dialog
                                                    Navigator.pushReplacementNamed(context, '/login');
                                                  },
                                                  child: Text(AppStrings.okButton),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                        
                                        // Alternative: Direct navigation after a short delay
                                        // Future.delayed(Duration(seconds: 2), () {
                                        //   if (mounted) {
                                        //     Navigator.pushReplacementNamed(context, '/login');
                                        //   }
                                        // });
                                      } else {
                                        print('Signup failed with error: $error'); // Debug log
                                        if (mounted) {
                                          showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                              title: Text(AppStrings.signupFailed),
                                              content: Text(error),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.pop(context),
                                                  child: Text(AppStrings.okButton),
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: viewModel.isLoading
                                  ? const CircularProgressIndicator(
                                      color: AppColors.white)
                                  : Text(AppStrings.signupTitle,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(AppStrings.alreadyHaveAnAccount),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, '/login');
                                },
                                child: Text(AppStrings.loginTitle,
                                    style: const TextStyle(
                                        color: AppColors.green600)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
