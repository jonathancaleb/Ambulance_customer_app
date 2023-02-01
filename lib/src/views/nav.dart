import 'package:ambulance_app/src/views/Booking/ambulance_screen.dart';
import 'package:ambulance_app/src/views/HistoryScreen.dart';
import 'package:ambulance_app/src/views/NotificationsScreen.dart';
import 'package:ambulance_app/src/views/SettingsScreen.dart';
import 'package:ambulance_app/src/views/home/home_screen.dart';
import 'package:flutter/material.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  State<Nav> createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[
    const HistoryScreen(),
    const NotificationsScreen(),
    const HomeScreen(),
    const AmbulanceScreen(),
    const SettingsScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: const Color(0xff042B52),
        unselectedItemColor: const Color(0xffB8B8B8),
      ),
    );
  }
}
