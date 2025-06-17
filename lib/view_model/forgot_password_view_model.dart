import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool isSending = false;

  Future<String?> sendResetLink(BuildContext context) async {
    if (!formKey.currentState!.validate()) return null;
    isSending = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text.trim(),
      );
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Error sending reset link';
    } finally {
      isSending = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }
} 