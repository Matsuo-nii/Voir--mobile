import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../api/vehicle_api.dart';
import 'dashboard_screen.dart'; // Import your Dashboard screen

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  Map<String, dynamic>? result;

  void search() async {
    String plate = _controller.text.trim();
    if (plate.isNotEmpty) {
      final data = await VehicleAPI.searchVehicle(plate);
      print('Fetched data: $data');
      setState(() {
        result = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final redColor = Colors.red[600];

    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(index: 1),
      appBar: AppBar(
        title: Text('Search', style: TextStyle(color: redColor)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: redColor),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => DashboardScreen()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Search Input
            TextField(
              controller: _controller,
              onSubmitted: (_) => search(),
              decoration: InputDecoration(
                hintText: 'Enter plate number (e.g. ABC123)',
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: Icon(Icons.directions_car, color: redColor),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search, color: redColor),
                  onPressed: search,
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 24),

            // Result Card or Message
            if (result == null)
              Text(
                'Enter a plate number to search',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              )
            else if (result!['status'] == 'not_found')
              Text(
                'No vehicle found with that plate number.',
                style: TextStyle(
                  color: Colors.red[600],
                  fontWeight: FontWeight.bold,
                ),
              )
            else
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: result!.entries.map((entry) {
                      final isStatus = entry.key.toLowerCase() == 'status';
                      final isRegistered = entry.value.toString().toLowerCase() == 'registered';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${entry.key}: ',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${entry.value}',
                                style: TextStyle(
                                  color: isStatus
                                      ? (isRegistered ? Colors.green : Colors.red)
                                      : Colors.black,
                                  fontWeight: isStatus ? FontWeight.bold : FontWeight.normal,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
