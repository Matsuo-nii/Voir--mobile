import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() => runApp(VoirApp());

class VoirApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Voir',
      home: SplashScreen(),
    );
  }
}
