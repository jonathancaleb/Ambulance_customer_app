import 'package:bukk_customer_app/views/Booking/home_screen.dart';
import 'package:bukk_customer_app/views/NotificationsScreen.dart';
import 'package:bukk_customer_app/views/widgets/MessagesScreen.dart';
import 'package:flutter/material.dart';
import 'package:bukk_customer_app/views/HistoryScreen.dart';
import 'package:bukk_customer_app/views/SettingsScreen.dart';

class Nav extends StatefulWidget {
  const Nav({Key? key}) : super(key: key);

  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav> {
  int _selectedIndex = 2;

  final List<Widget> _widgetOptions = <Widget>[
    const HistoryScreen(),
    const NotificationsScreen(),
    const Home(),
    const MessageScreen(),
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
