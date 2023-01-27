import 'dart:io';

import 'package:bukk_customer_app/views/widgets/timer_widget.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';

class StartTripDialog extends StatelessWidget {
  const StartTripDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/bukk_logo_1.png',
              height: 22.0,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Ready to move?',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xff042B52),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            const TimerWidget(durationInSeconds: 10),
            const SizedBox(
              height: 20,
            ),
            Text(
              'This is coming your way',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color(0xff042B52), fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
