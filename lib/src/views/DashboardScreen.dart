import 'package:ambulance_app/src/views/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/nav_controller.dart';
import 'Booking/ambulance_screen.dart';
import 'HistoryScreen.dart';
import 'NotificationsScreen.dart';
import 'SettingsScreen.dart';
// import 'widgets/MessagesScreen.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final navCcontroller = Get.put(NavController());
  int _selectedIndex = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<NavController>(
        builder: (navController) => IndexedStack(
          index: navCcontroller.bottomNavigationPosition,
          children: const [
            HistoryScreen(),
            NotificationsScreen(),
            HomeScreen(),
            AmbulanceScreen(),
            SettingsScreen(),
          ],
        ),
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
            icon: Icon(Icons.car_crash_outlined),
            label: 'Ambulance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          )
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
        selectedItemColor: const Color(0xFFFF3D62),
        unselectedItemColor: const Color(0xffB8B8B8),
      ),
    );
  }

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
      navCcontroller.updateBottomNavigationPositino(index);
    });
  }
}
