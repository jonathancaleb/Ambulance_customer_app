import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Find providers and Ambulances around you!"),
            bottom: TabBar(
              indicatorColor: const Color(0xffF1CA2D),
              tabs: [
                Tab(
                    icon: Text("Ambulance",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
                Tab(
                    icon: Text("Providers",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text("Trip "),
              ),
              Center(
                child: Text("Bookings"),
              )
            ],
          ),
        ));
  }
}
