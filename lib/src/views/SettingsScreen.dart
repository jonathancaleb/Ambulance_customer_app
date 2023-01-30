import 'package:ambulance_app/src/views/profile/profile_screen.dart';
import 'package:ambulance_app/src/views/widgets/AboutScreen.dart';
import 'package:ambulance_app/src/views/widgets/paymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: Svg('assets/bukk_logo_large.svg'),
              ),
            ),
            bottom: TabBar(
              indicatorColor: const Color(0xffF1CA2D),
              tabs: [
                Tab(
                    icon: Text("Profile",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
                Tab(
                    icon: Text("Payments",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
                Tab(
                    icon: Text("About",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              /**/
              ProfileScreen(),
              /* Payment Screen */
              PaymentScreen(),

              /* about Screen*/
              AboutScreen(),
            ],
          ),
        ));
  }
}
