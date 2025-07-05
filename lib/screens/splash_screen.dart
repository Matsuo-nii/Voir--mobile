import 'package:flutter/material.dart';
import 'dart:async';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[600],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace this:
            // Icon(Icons.videocam_rounded, size: 100, color: Colors.white),

            // With your logo:
            Image.asset('assets/logo.png', width: 150), // adjust size if needed

            SizedBox(height: 20),
            Text('Voir', style: TextStyle(color: Colors.white, fontSize: 28)),
          ],
        ),
      ),
    );
  }
}
