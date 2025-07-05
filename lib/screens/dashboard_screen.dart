import 'package:flutter/material.dart';
import '../widgets/bottom_nav.dart';


class DashboardScreen extends StatelessWidget {
  final List<String> guards = ['Carlos Mendoza', 'Antonio Salsanez', 'Mario de la Cruz', 'Ramon Villanueva'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AppBottomNavBar(index: 0),
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.red[600])),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Icon(Icons.people, color: Colors.white),
                    SizedBox(width: 10),
                    Text('56 registered', style: TextStyle(color: Colors.white, fontSize: 18))
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(Icons.directions_car, size: 40, color: Colors.red[400]),
                Icon(Icons.motorcycle, size: 40, color: Colors.red[400]),
                Icon(Icons.fire_truck, size: 40, color: Colors.red[400]),
              ],
            ),
            SizedBox(height: 20),
            Card(
              color: Colors.red[400],
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: guards.map((g) => Text(g, style: TextStyle(color: Colors.white))).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
