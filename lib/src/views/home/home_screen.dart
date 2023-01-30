import 'package:ambulance_app/src/constants/app_colors.dart';
import 'package:ambulance_app/src/constants/text_string.dart';
import 'package:ambulance_app/src/views/Extra%20screens/article_screen.dart';
import 'package:ambulance_app/src/views/Extra%20screens/chat_screen.dart';
import 'package:ambulance_app/src/views/Extra%20screens/report_incident_screen.dart';
import 'package:ambulance_app/src/views/maps/find_hospital.dart';
import 'package:ambulance_app/src/views/maps/maps.dart';
import 'package:ambulance_app/src/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/image_strings.dart';
import '../../constants/sizes.dart';
import '../authentication/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    //variable

    final txttheme = Theme.of(context).textTheme;
    return Scaffold(
        //appbar
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.logout_outlined),
            color: Colors.black,
            onPressed: () async {
              final SharedPreferences? prefs = await _prefs;
              prefs?.clear();
              Get.offAll(const LogIn());
            },
          ),
          title: Text(
            "Med Move",
            style: Theme.of(context).textTheme.headline4,
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 20, top: 7),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: aCardBgColor),
              child: IconButton(
                onPressed: () => Get.to(() => const ProfileScreen()),
                icon: const Image(image: AssetImage(aAccount)),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  aDashboardttle,
                  style: txttheme.bodyText2,
                ),
                Text(
                  aDashboardDsc,
                  style: txttheme.headline2,
                ),
                const SizedBox(
                  height: 20,
                ),

                //search box
                Container(
                  decoration: const BoxDecoration(
                    border: Border(left: BorderSide(width: 4)),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Search",
                        style: txttheme.headline2?.apply(
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                      const Icon(
                        Icons.mic,
                        size: 25,
                      )
                    ],
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),

                //categories
                SizedBox(
                  height: 45,
                  child: GestureDetector(
                    onTap: () => Get.to(() => const ArticleScreen()),
                    child: SizedBox(
                      width: 170,
                      height: 45,
                      child: Row(
                        children: [
                          Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: aDarkColor),
                            child: Center(
                              child: Text("NT",
                                  style: txttheme.headline6
                                      ?.apply(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Health Week",
                                  style: txttheme.headline6,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Read more...",
                                  style: txttheme.bodyText2,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //banners
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //1st container
                    Expanded(
                      child: GestureDetector(
                        onTap: () => Get.to(() => const ChatScreen()),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: aCardBgColor),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Flexible(
                                      child:
                                          Image(image: AssetImage(aBookmark))),
                                  Flexible(
                                      child:
                                          Image(image: AssetImage(aBannerImg))),
                                ],
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text(
                                "Chat with a Doctor",
                                style: txttheme.headline4,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Get help now!",
                                style: txttheme.bodyText2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    //2nd container
                    Expanded(
                        child: Column(
                      children: [
                        GestureDetector(
                          onTap: () => Get.to(() => const ReportIncident()),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: aCardBgColor),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Flexible(
                                        child: Image(
                                            image: AssetImage(aBookmark))),
                                    Flexible(
                                        child:
                                            Image(image: AssetImage(aReport))),
                                  ],
                                ),
                                Text(
                                  "Report Incident",
                                  style: txttheme.headline4,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  "Talk to experts",
                                  style: txttheme.bodyText2,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),

                        //button
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton(
                              onPressed: () {},
                              // => Get.to(() => const NearbyHospitalsPage()),
                              style: OutlinedButton.styleFrom(
                                shape: const StadiumBorder(),
                                foregroundColor: aSecondaryColor,
                                side: const BorderSide(color: aSecondaryColor),
                                padding: const EdgeInsets.symmetric(
                                    vertical: aButtonHeight),
                              ),
                              child: const Text("Find Hospital")),
                        )
                      ],
                    )),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //buttons

                Text("Move With Ease",
                    style: txttheme.headline4?.apply(fontSizeFactor: 1.2)),
                SizedBox(
                  height: 200,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    children: [
                      SizedBox(
                        width: 320,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: aCardBgColor),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Order an Ambulance",
                                        style: txttheme.headline4,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Flexible(
                                        child: Image(
                                            image: AssetImage(aOrder),
                                            height: 110))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Obx(
                                            () => _isLoading.value
                                                ? const CircularProgressIndicator()
                                                : ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape:
                                                          const CircleBorder(),
                                                      elevation: 0,
                                                      foregroundColor:
                                                          aWhiteColor,
                                                      backgroundColor:
                                                          aSecondaryColor,
                                                      side: const BorderSide(
                                                          color:
                                                              aSecondaryColor),
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 20),
                                                    ),
                                                    onPressed: () {},
                                                    // onPressed: () {
                                                    //   _isLoading.value = true;
                                                    //   Future.delayed(
                                                    //       const Duration(
                                                    //           seconds: 2), () {
                                                    //     Get.to(
                                                    //         const MapScreen());
                                                    //     _isLoading.value =
                                                    //         false;
                                                    //   });
                                                    // },
                                                    child: const Icon(Icons
                                                        .arrow_forward_ios_outlined),
                                                  ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ambulance",
                                            style: txttheme.headline4,
                                            overflow: TextOverflow.ellipsis),
                                        Text("Bridging the gap",
                                            style: txttheme.bodyText2,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 320,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: aCardBgColor),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Order an Ambulance",
                                        style: txttheme.headline4,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Flexible(
                                        child: Image(
                                            image: AssetImage(aOrder),
                                            height: 110))
                                  ],
                                ),
                                Row(
                                  children: [
                                    //testbutton

                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        elevation: 0,
                                        foregroundColor: aWhiteColor,
                                        backgroundColor: aSecondaryColor,
                                        side: const BorderSide(
                                            color: aSecondaryColor),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: aButtonHeight),
                                      ),
                                      onPressed: () {},
                                      child: const Icon(
                                          Icons.arrow_forward_ios_outlined),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ambulance",
                                            style: txttheme.headline4,
                                            overflow: TextOverflow.ellipsis),
                                        Text("Bridging the gap",
                                            style: txttheme.bodyText2,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 320,
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, top: 5),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: aCardBgColor),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        "Order an Ambulance",
                                        style: txttheme.headline4,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    const Flexible(
                                        child: Image(
                                            image: AssetImage(aOrder),
                                            height: 110))
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                        elevation: 0,
                                        foregroundColor: aWhiteColor,
                                        backgroundColor: aSecondaryColor,
                                        side: const BorderSide(
                                            color: aSecondaryColor),
                                        padding: const EdgeInsets.symmetric(
                                            vertical: aButtonHeight),
                                      ),
                                      onPressed: () {},
                                      child: const Icon(
                                          Icons.arrow_forward_ios_outlined),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Ambulance",
                                            style: txttheme.headline4,
                                            overflow: TextOverflow.ellipsis),
                                        Text("Bridging the gap",
                                            style: txttheme.bodyText2,
                                            overflow: TextOverflow.ellipsis)
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
