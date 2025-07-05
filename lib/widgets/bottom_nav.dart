import 'package:flutter/material.dart';
import '../screens/dashboard_screen.dart';
import '../screens/search_screen.dart';

class AppBottomNavBar extends StatelessWidget {
  final int index;
  AppBottomNavBar({required this.index});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: index,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
      backgroundColor: Colors.red[600], // ✅ This makes the bar red
      onTap: (i) {
        if (i == 0) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => DashboardScreen()));
        } else {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SearchScreen()));
        }
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.search), label: '')
      ],
    );
  }
}
