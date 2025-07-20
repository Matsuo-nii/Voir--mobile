import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../widgets/bottom_nav.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int registered = 0;
  int cars = 0;
  int motorcycles = 0;
  int vans = 0;
  List<String> guards = [];

  @override
  void initState() {
    super.initState();
    fetchDashboardData();
  }

  Future<void> fetchDashboardData() async {
    try {
      final response = await http.get(Uri.parse('http://192.168.91.21/voir_api/get_dashboard_stats.php'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          cars = data['vehicles']['car'];
          motorcycles = data['vehicles']['motorcycle'];
          vans = data['vehicles']['van'];
          registered = cars + motorcycles + vans;
        });
      }

      // Optional: Fetch guard names
      final guardResponse = await http.get(Uri.parse('192.168.91.21/voir_api/get_guards.php'));
      if (guardResponse.statusCode == 200) {
        final guardData = json.decode(guardResponse.body);
        setState(() {
          guards = List<String>.from(guardData['guards']);
        });
      }
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(index: 0),
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.red[600])),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // Registered Count Card
          Card(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(Icons.people, color: Colors.white),
                  SizedBox(width: 10),
                  Text(
                    '$registered registered',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 20),

          // Vehicle Icons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(children: [
                Icon(Icons.directions_car, size: 40, color: Colors.red[400]),
                Text('$cars', style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Column(children: [
                Icon(Icons.motorcycle, size: 40, color: Colors.red[400]),
                Text('$motorcycles', style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
              Column(children: [
                Icon(Icons.fire_truck, size: 40, color: Colors.red[400]),
                Text('$vans', style: TextStyle(fontWeight: FontWeight.bold)),
              ]),
            ],
          ),

          SizedBox(height: 20),

          // Available Guards ExpansionTile
          Card(
            color: Colors.red[400],
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  'Available Guards (${guards.length})',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                iconColor: Colors.white,
                collapsedIconColor: Colors.white,
                children: guards
                    .map(
                      (guard) => ListTile(
                        title: Text(
                          guard,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
