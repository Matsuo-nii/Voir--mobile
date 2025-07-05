import 'package:flutter/material.dart';
import '../api/otp_auth_api.dart';
import 'dashboard_screen.dart';

class OTPVerifyScreen extends StatefulWidget {
  final String email;
  OTPVerifyScreen({required this.email});

  @override
  _OTPVerifyScreenState createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final _otp = TextEditingController();
  String message = '';
  Color messageColor = Colors.red;

  void _verify() async {
    final res = await OTPAuthAPI.verifyOTP(widget.email, _otp.text.trim());
    if (res['success']) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => DashboardScreen()),
      );
    } else {
      setState(() {
        message = res['message'];
        messageColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter OTP')),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Text('An OTP has been sent to your email.', textAlign: TextAlign.center),
            TextField(
              controller: _otp,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter OTP'),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: _verify, child: Text('Verify OTP')),
            SizedBox(height: 10),
            Text(message, style: TextStyle(color: messageColor)),
          ],
        ),
      ),
    );
  }
}
