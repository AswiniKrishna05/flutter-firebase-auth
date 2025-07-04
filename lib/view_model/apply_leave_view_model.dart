import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../utils/constants/strings.dart';

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

  // File attachment
  PlatformFile? selectedFile;
  String? attachmentPath;
  String? attachmentName;

  Future<void> pickFile() async {
    try {
      print('File picker started...');
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
      );

      print('File picker result: $result');

      if (result != null) {
        selectedFile = result.files.first;
        attachmentPath = selectedFile!.path;
        attachmentName = selectedFile!.name;
        print('File selected: ${selectedFile!.name}');
        print('File path: ${selectedFile!.path}');
        print('File size: ${selectedFile!.size}');
        notifyListeners();
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
      debugPrint('Error picking file: $e');
    }
  }

  void removeFile() {
    selectedFile = null;
    attachmentPath = null;
    attachmentName = null;
    notifyListeners();
  }

  // Submit function
  Future<void> submitLeaveForm(BuildContext context) async {
    if (fromDate == null ||
        toDate == null ||
        leaveType == null ||
        reasonController.text.isEmpty) {
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
    selectedFile = null;
    attachmentPath = null;
    attachmentName = null;
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
