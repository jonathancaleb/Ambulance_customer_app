import 'package:ambulance_app/src/constants/image_strings.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/sizes.dart';

class ReportIncident extends StatelessWidget {
  const ReportIncident({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: screenHeight,
      width: screenWidth,
      padding: const EdgeInsets.all(30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Image(
            image: AssetImage(aHealthcare),
            height: 250,
          ),
          Column(
            children: [
              Text(
                "Find Help",
                style: Theme.of(context).textTheme.headline3,
              ),
              Text(
                "Report an Incident or request for assistance online.",
                style: Theme.of(context).textTheme.bodyText1,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: aSecondaryColor,
                      side: const BorderSide(color: aSecondaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    child: const Text("Report Incident")),
              ),
              Expanded(
                child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      shape: const StadiumBorder(),
                      foregroundColor: aSecondaryColor,
                      side: const BorderSide(color: aSecondaryColor),
                      padding: const EdgeInsets.symmetric(vertical: 25),
                    ),
                    child: const Text("Request Help")),
              ),
            ],
          ),
          // const SizedBox(
          //   height: 10,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text.rich(
                TextSpan(
                  text: "Go",
                  style: TextStyle(fontSize: 12),
                  children: [
                    TextSpan(
                        text: "back",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12))
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent.withOpacity(0.1),
                      elevation: 0,
                      foregroundColor: Colors.red,
                      shape: const StadiumBorder(),
                      side: BorderSide.none),
                  child: const Text("cancel"))
            ],
          )
        ],
      ),
    ));
  }
}
