import 'package:flutter/material.dart';
import '../constants/strings.dart';

class ApplyLeaveViewModel extends ChangeNotifier {
  // Auto-filled fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  // Date fields
  DateTime? fromDate;
  DateTime? toDate;

  void setFromDate(DateTime date) {
    fromDate = date;
    notifyListeners();
  }

  void setToDate(DateTime date) {
    toDate = date;
    notifyListeners();
  }

  // Leave type dropdown
  String? leaveType;
  final List<String> leaveTypes = [
    AppStrings.sickLeave,
    AppStrings.casualLeave,
    AppStrings.emergencyLeave,
    AppStrings.annualLeave,
  ];

  void setLeaveType(String? type) {
    leaveType = type;
    notifyListeners();
  }

  // Choose type dropdown
  String? chooseType;
  final List<String> chooseTypes = [
    AppStrings.fullDay,
    AppStrings.halfDay,
    AppStrings.shortLeave,
  ];

  void setChooseType(String? type) {
    chooseType = type;
    notifyListeners();
  }

  // Reason input
  final TextEditingController reasonController = TextEditingController();

  void setReason(String reason) {
    reasonController.text = reason;
    notifyListeners();
  }

  // Attachment (you can enhance this to hold file paths)
  String? attachment;

  void setAttachment(String? filePath) {
    attachment = filePath;
    notifyListeners();
  }

  // Submit function
  Future<void> submitLeaveForm(BuildContext context) async {
    if (fromDate == null || toDate == null || leaveType == null || reasonController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppStrings.pleaseFillRequiredFields)),
      );
      return;
    }

    // Simulate a successful submission (You can replace this with Firebase/REST API call)
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(AppStrings.leaveApplicationSubmitted)),
    );

    // Optionally, clear form
    clearForm();
  }

  void clearForm() {
    fromDate = null;
    toDate = null;
    leaveType = null;
    reasonController.clear();
    attachment = null;
    notifyListeners();
  }

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    reasonController.dispose();
    super.dispose();
  }
}
