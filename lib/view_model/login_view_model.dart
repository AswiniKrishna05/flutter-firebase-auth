import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final emailOrPhoneController = TextEditingController();
  final passwordController = TextEditingController();
  String fullName = '';
  bool isLoading = false;

  Future<String?> login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return null;
    isLoading = true;
    notifyListeners();
    try {
      String email = emailOrPhoneController.text.trim();
      // If input is phone, fetch email from Firestore
      if (RegExp(r'^\\d{10} ').hasMatch(email)) {
        final query = await FirebaseFirestore.instance
            .collection('users')
            .where('phone', isEqualTo: email)
            .limit(1)
            .get();
        if (query.docs.isEmpty)
          throw Exception('No user found with this phone number');
        email = query.docs.first['email'];
      }
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: passwordController.text.trim(),
      );
      // Fetch user details from Firestore and save to SharedPreferences
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('fullName', data['fullName'] ?? '');
            await prefs.setString('email', data['email'] ?? '');
            await prefs.setString('phone', data['phone'] ?? '');
          }
        }
      }
      return null; // Success
    } on FirebaseAuthException catch (e) {
      return e.message ?? 'Entered details are incorrect';
    } catch (e) {
      return e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailOrPhoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
