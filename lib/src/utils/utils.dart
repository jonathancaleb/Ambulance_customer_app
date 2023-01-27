import 'package:bukk_customer_app/views/widgets/LocationDialogView.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class Utils {
  static Future<void> handleLocationPermission(
    BuildContext context, {
    required VoidCallback onComplete,
    required VoidCallback onReject,
  }) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      // show Popup
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextT) => LocationDialogView(
          onTap: () async {
            Navigator.of(contextT).pop();
            permission = await Geolocator.requestPermission();
            await Geolocator.openLocationSettings();
            onComplete();
          },
        ),
      );
      // return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // show request Notification popup
      await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (contextT) => LocationDialogView(
          onTap: () async {
            Navigator.of(contextT).pop();
            permission = await Geolocator.requestPermission();
            if (permission == LocationPermission.denied) {
              showSnackBar(
                context,
                'You need to enable your to continue.',
                Colors.red,
              );
              onReject();
              // return Future.error('Location permissions are denied');
            } else {
              showSnackBar(
                context,
                'Location enabled',
                Colors.green,
              );
              onComplete();
            }
          },
        ),
      );
    } else if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      showSnackBar(
        context,
        'You need to enable your to continue.',
        Colors.red,
      );
      onReject();
      // return Future.error(
      //     'Location permissions are permanently denied, we cannot request permissions.');
    } else {
      onComplete();
    }
  }

  static void showSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(msg),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
