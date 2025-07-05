import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_screen.dart';


class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/image1.png'),
          Image.asset('assets/plate.png'),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
            },
            child: Text('Start Now'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
          )
        ],
      ),
    );
  }
}
