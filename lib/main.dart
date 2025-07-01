import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_auth/view_model/report_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_firebase_auth/view/screens/forgot_password_screen.dart';
import 'package:flutter_firebase_auth/view/screens/home_screen.dart';
import 'package:flutter_firebase_auth/view/screens/login_screen.dart';
import 'package:flutter_firebase_auth/view/screens/signup_screen.dart';
import 'package:flutter_firebase_auth/view_model/punch_in_success_view_model.dart'; // ✅ Import ViewModel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const AppProvider()); // ✅ Wrap MyApp with MultiProvider
}

class AppProvider extends StatelessWidget {
  const AppProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PunchInSuccessViewModel()),
        ChangeNotifierProvider(create: (_) => ReportViewModel()),

      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Auth',
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/forgot': (context) => const ForgotPasswordScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}

// AuthGate remains the same
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasData) {
          return const HomeScreen(); // User is logged in
        } else {
          return const LoginScreen(); // User not logged in
        }
      },
    );
  }
}
