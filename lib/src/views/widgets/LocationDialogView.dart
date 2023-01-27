import 'package:flutter/material.dart';

class LocationDialogView extends StatelessWidget {
  const LocationDialogView({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20 * 2, 20, 20 * 2, 20),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Wrap(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/location.png',
                  // height: 22.0,
                ),
                // const SizedBox(height: 120),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Location Services',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: const Color(0xff042B52).withOpacity(.8)),
                ),

                Text(
                  'Please enable your GPS to continue using BUKK',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w400,
                      ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: size.height * 0.07,
                  width: 130,
                  child: MaterialButton(
                    enableFeedback: true,
                    color: const Color(0xff042B52),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                        side: const BorderSide(color: Color(0xff042B52))),
                    onPressed: onTap,
                    child: const Text(
                      "Enable GPS",
                      style: TextStyle(fontSize: 16, color: Color(0xffF1CA2D)),
                    ),
                  ),
                ),
                // AppButton(
                //   height: 50,
                //   width: MediaQuery.of(context).size.width * 0.30,
                //   child: Text(
                //     'Proceed',
                //     textAlign: TextAlign.center,
                //     style: Theme.of(context).textTheme.subtitle1?.copyWith(
                //           color: Colors.white,
                //         ),
                //   ),
                //   onTap: () async {
                //     // Navigator.of(context).pop();
                //     File? file = await Helpers.takeImage();
                //     cameraFile(file);
                //   },
                // ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
