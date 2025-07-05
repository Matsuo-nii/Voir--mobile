import 'dart:convert';
import 'package:http/http.dart' as http;

class VehicleAPI {
  static Future<Map<String, dynamic>?> searchVehicle(String plate) async {
    try {
      final url = Uri.parse('http://10.0.2.2/voir_api/get_vehicle.php?plate=$plate');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['status'] == 'not_found' ? null : data;
      } else {
        print('Server error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
