import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';
import '../api/vehicle_api.dart';


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
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(index: 1),
      appBar: AppBar(
        title: Text('Search', style: TextStyle(color: Colors.red[600])),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter plate number',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: search,
                ),
              ),
            ),
            SizedBox(height: 20),
            result == null
                ? Text('No Results Found')
                : Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: result!.entries.map((e) => Text(
                          '${e.key}: ${e.value}',
                          style: TextStyle(
                            color: e.key.toLowerCase() == 'status' && e.value.toString().toLowerCase() == 'registered'
                                ? Colors.green
                                : Colors.black,
                          ),
                        )).toList(),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
