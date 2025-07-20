import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleAPI {
  static const String _baseUrl = 'http://192.168.91.21/voir_api';

  static Future<Map<String, dynamic>?> searchVehicle(String plate) async {
    try {
      final url = Uri.parse('$_baseUrl/get_vehicle.php?plate=$plate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == 'not_found') return null;
        return data;
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching vehicle: $e');
      return null;
    }
  }
}
