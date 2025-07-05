import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> guards = [
    'Carlos Mendoza',
    'Antonio Salsanez',
    'Mario de la Cruz',
    'Ramon Villanueva',
  ];

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
                    '56 registered',
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
              Icon(Icons.directions_car, size: 40, color: Colors.red[400]),
              Icon(Icons.motorcycle, size: 40, color: Colors.red[400]),
              Icon(Icons.fire_truck, size: 40, color: Colors.red[400]),
            ],
          ),

          SizedBox(height: 20),

          // Clickable ExpansionTile inside Card
          Card(
            color: Colors.red[400],
            child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                title: Text(
                  'Available Guards',
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
