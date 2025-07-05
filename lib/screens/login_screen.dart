import 'package:flutter/material.dart';
import '../api/otp_auth_api.dart'; // Use OTP API
import 'register_screen.dart';
import 'otp_verify_screen.dart'; // OTP input screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  String message = '';
  Color messageColor = Colors.red;

  void _login() async {
    final result = await OTPAuthAPI.login(_email.text.trim(), _password.text);

    if (result['success']) {
      // OTP sent — go to OTP input screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OTPVerifyScreen(email: _email.text.trim()),
        ),
      );
    } else {
      setState(() {
        message = result['message'] ?? 'Login failed';
        messageColor = Colors.red;
      });
    }
  }

  void _goToRegister() {
    Navigator.push(context, MaterialPageRoute(builder: (_) => RegisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _email,
              decoration: InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _password,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _login, child: Text('Login')),
            Text(
              'An OTP will be sent to your email after a valid login.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
            TextButton(
              onPressed: _goToRegister,
              child: Text('No account? Register here'),
            ),
            SizedBox(height: 10),
            Text(message, style: TextStyle(color: messageColor)),
          ],
        ),
      ),
    );
  }
}
