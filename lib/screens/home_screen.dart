import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

   void _logout (BuildContext context)async{
     await FirebaseAuth.instance.signOut();
     Navigator.pushReplacementNamed(context, '/login');
   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: ()=> _logout(context),
              icon: const Icon(Icons.logout))
        ],
      ),
      body: const Center(
        child: Text(
          'Login Successful',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
