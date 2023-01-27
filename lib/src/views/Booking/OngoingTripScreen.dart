import 'package:flutter/material.dart';

class OngoingTripScreen extends StatefulWidget {
  const OngoingTripScreen({Key? key}) : super(key: key);

  @override
  State<OngoingTripScreen> createState() => _OngoingTripScreenState();
}

class _OngoingTripScreenState extends State<OngoingTripScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 40,
          width: screenWidth,
          color: Colors.grey.shade300,
          child: const Center(
            child: Text(
              "Time to Delivery - 04:20",
              style: TextStyle(
                color: Color(0xff042B52),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: MaterialButton(
                    onPressed: () {},
                    child: const Icon(
                      Icons.phone,
                      color: Color(0xff042B52),
                    ),
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Color(0xff042B52),
                      ),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: const Color(0xff7c94b6),
                        image: const DecorationImage(
                          image: NetworkImage('http://i.imgur.com/QSev0hg.jpg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50.0)),
                        border: Border.all(
                          color: const Color(0xff042B52),
                          width: 4.0,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Driver Name",
                        style:
                            TextStyle(color: Color(0xff042B52), fontSize: 16),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "xyz 182",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                MaterialButton(
                  onPressed: () {},
                  child: const Icon(
                    Icons.mail,
                    color: Color(0xff042B52),
                  ),
                  shape: const CircleBorder(
                    side: BorderSide(
                      color: Color(0xff042B52),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextButton(
            onPressed: () {
              // //Go to Trip Started Screen
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const RatingScreen(),
              //   ),
              // );
            },
            child: const Text(
              "Cancel Ride...",
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xffF1CA2D),
                  fontFamily: "Regular"),
            ),
          ),
        )
      ],
    );
  }
}
