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
        message = res['message'] ?? 'Invalid OTP';
        messageColor = Colors.red;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final redColor = Colors.red[600];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('OTP Verification', style: TextStyle(color: redColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: redColor),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Card(
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.mark_email_read_rounded, size: 64, color: redColor),
                  SizedBox(height: 16),
                  Text(
                    'Enter the OTP sent to your email',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 24),
                  TextField(
                    controller: _otp,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: '6-digit OTP',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.pin),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _verify,
                      icon: Icon(Icons.verified_user),
                      label: Text('Verify OTP'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                        padding: EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  if (message.isNotEmpty) ...[
                    SizedBox(height: 12),
                    Text(message, style: TextStyle(color: messageColor)),
                  ]
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
