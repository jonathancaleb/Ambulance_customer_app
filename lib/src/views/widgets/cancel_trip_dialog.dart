import 'dart:io';

import 'package:flutter/material.dart';

import 'app_button.dart';

class CancelTripDialog extends StatelessWidget {
  const CancelTripDialog({
    Key? key,
    required this.cancelTrip,
  }) : super(key: key);
  final Function(bool? isCancel) cancelTrip;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(
            40,
           20,
            40,
           20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          children: [
            Column(
              children: [
                Image.asset(
                  'assets/bukk_logo_1.png',
                  height: 22.0,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Do you really want to cancel this trip ?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    AppButton(
                      height: 40,
                      color: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.30,
                      child: Text(
                        'Yes',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1?.copyWith(
                              color: Colors.white,
                            ),
                      ),
                      onTap: () async {
                        Navigator.of(context).pop();
                        cancelTrip(true);
                      },
                    ),
                    const SizedBox(width: 20,),
                    AppButton(
                  height: 40,
                  color: const Color(0xff042B52),
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Text(
                    'No',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    cancelTrip(false);
                  },
                ),
                  ],
                ),
                
              ],
            )
          ],
        ),
      ),
    );
  }
}
