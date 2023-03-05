import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 1,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Padding(
              padding: EdgeInsets.all(10.0),
              child: Image(
                image: Svg('assets/logo.png'),
              ),
            ),
            bottom: TabBar(
              indicatorColor: const Color(0xffF1CA2D),
              tabs: [
                Tab(
                  icon: Text(
                    "Notifications",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.black.withOpacity(1.0),
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: 7,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const [
                              Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  size: 40,
                                  color: Color(0xffF1CA2D),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "11:59 PM",
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 14,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0, bottom: 10.0, right: 10.0),
                                child: Text(
                                  "The driver has arrived.",
                                  style: TextStyle(
                                      color: Color(0xff042B52),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ));
  }
}
