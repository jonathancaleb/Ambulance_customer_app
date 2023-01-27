import 'package:ambulance_app/src/constants/app_colors.dart';
import 'package:ambulance_app/src/constants/image_strings.dart';
import 'package:ambulance_app/src/views/authentication/login_screen.dart';
import 'package:ambulance_app/src/views/profile/update_profile_sscreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/sizes.dart';
import '../../constants/text_string.dart';
import '../../widgets/profile_menu_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(LineAwesomeIcons.angle_left),
            color: aSecondaryColor),
        title: Text(aProfile, style: Theme.of(context).textTheme.headline4),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(LineAwesomeIcons.moon),
              color: aSecondaryColor)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              //image box
              children: [
                Stack(
                  children: [
                    SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: const Image(image: AssetImage(aAccount)))),
                    Positioned(
                      bottom: 5,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: aPrimaryColor),
                            child: const Icon(LineAwesomeIcons.alternate_pencil,
                                size: 20.0, color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  aProfileHead,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(aProfilesub, style: Theme.of(context).textTheme.bodyText2),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: () =>
                          Get.to(() => const UpdateProfileScreen()),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shape: const StadiumBorder(),
                        foregroundColor: aWhiteColor,
                        backgroundColor: aSecondaryColor,
                        side: const BorderSide(color: aSecondaryColor),
                        padding:
                            const EdgeInsets.symmetric(vertical: aButtonHeight),
                      ),
                      child: const Text(aEdit)),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 10,
                ),

                //menu
                ProfileMenuWidget(
                  title: aMenu2,
                  icon: LineAwesomeIcons.cog,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: aMenu4,
                  icon: LineAwesomeIcons.wallet,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: aMenu5,
                  icon: LineAwesomeIcons.user_check,
                  onPress: () {},
                ),
                const Divider(
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 10,
                ),
                ProfileMenuWidget(
                  title: aMenu3,
                  icon: LineAwesomeIcons.info,
                  onPress: () {},
                ),
                ProfileMenuWidget(
                  title: aMenu1,
                  icon: LineAwesomeIcons.alternate_sign_out,
                  endIcon: false,
                  onPress: () async {
                    final SharedPreferences? prefs = await _prefs;
                    prefs?.clear();
                    Get.offAll(const LogIn());
                  },
                ),
              ],
            )),
      ),
    );
  }
}
