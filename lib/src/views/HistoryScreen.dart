import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
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
                    icon: Text("Trip History",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
                Tab(
                    icon: Text("Bookings",
                        style: TextStyle(
                            color: Colors.black.withOpacity(1.0),
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Center(
                child: Text("Trip History"),
              ),
              Center(
                child: Text("Bookings"),
              )
            ],
          ),
        ));
  }
}
