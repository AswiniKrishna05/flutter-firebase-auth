import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/profile_view_model.dart';
import '../widgets/profile_header.dart';
import '../../view/row/row.dart';

class ProfileBottomScreen extends StatefulWidget {
  const ProfileBottomScreen({super.key});

  @override
  State<ProfileBottomScreen> createState() => _ProfileBottomScreenState();
}

class _ProfileBottomScreenState extends State<ProfileBottomScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().loadUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProfileViewModel(),
      child: Consumer<ProfileViewModel>(
        builder: (context, viewModel, child) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const ProfileHeader(),
                        const SizedBox(height: 60),
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
                                PayslipInfoRow('Name', viewModel.employeeName),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: DottedLine(
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    lineThickness: 1,
                                    dashColor: Colors.black12,
                                  ),
                                ),
                                PayslipInfoRow('Employee ID', viewModel.employeeId),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: DottedLine(
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    lineThickness: 1,
                                    dashColor: Colors.black12,
                                  ),
                                ),
                                PayslipInfoRow('Designation', viewModel.designation),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4.0),
                                  child: DottedLine(
                                    dashLength: 2,
                                    dashGapLength: 2,
                                    lineThickness: 1,
                                    dashColor: Colors.black12,
                                  ),
                                ),
                                PayslipInfoRow('Department', viewModel.department),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Image.asset(
                          'assets/group.png',
                          height: 250,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 70),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: viewModel.isLoading ? null : () async {
                                await viewModel.startWork();
                              },
                              child: viewModel.isLoading
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    )
                                  : const Text(
                                      'Start work',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                  if (viewModel.errorMessage != null)
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        color: Colors.red.shade100,
                        child: Row(
                          children: [
                            Icon(Icons.error, color: Colors.red.shade700),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                viewModel.errorMessage!,
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.close, color: Colors.red.shade700),
                              onPressed: viewModel.clearError,
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
