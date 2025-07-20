import 'dart:convert';
import 'package:http/http.dart' as http;

class OTPAuthAPI {
  static const String baseUrl = 'http://192.168.254.168/voir_api';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/otp_login.php');
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }

  static Future<Map<String, dynamic>> verifyOTP(String email, String otp) async {
    final url = Uri.parse('$baseUrl/verify_otp.php');
    final response = await http.post(
      url,
      body: jsonEncode({'email': email, 'otp': otp}),
      headers: {'Content-Type': 'application/json'},
    );
    return jsonDecode(response.body);
  }
}
