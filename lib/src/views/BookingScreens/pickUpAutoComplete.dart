import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import '../../controllers/BookingController.dart';

class PickUpAutoComplete extends StatefulWidget {
  const PickUpAutoComplete({Key? key}) : super(key: key);

  @override
  State<PickUpAutoComplete> createState() => _PickUpAutoCompleteState();
}

class _PickUpAutoCompleteState extends State<PickUpAutoComplete> {
  final bookingController = Get.put(BookingController());

  final _controller = TextEditingController();
  var uuid = const Uuid();
  String _sessionToken = "";
  List<dynamic> _placeList = [];
  String latLng = "";

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _onChanged();
    });
  }

  _onChanged() {
    if (_sessionToken == null) {
      setState(() {
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xff042B52),
          title: const Text(
            "Pickup Location",
            style:
                TextStyle(fontFamily: "Regular", fontWeight: FontWeight.bold),
          ),
        ),
        //body
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.topCenter,
                  child: TextField(
                    controller: _controller,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: "Your Pick up Location",
                      focusColor: Colors.white,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      prefixIcon: Icon(Icons.map),
                      suffixIcon: Icon(Icons.cancel),
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _placeList.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: screenWidth,
                      child: ListTile(
                          enabled: true,
                          leading: const Icon(
                            Icons.location_pin,
                            color: Color(0xffF1CA2D),
                          ),
                          title: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                fit: FlexFit.tight,
                                child: Text(
                                  _placeList[index]["description"],
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            bookingController.updatePickUpLocationAddress(
                                _placeList[index]["description"]);
                            getPosition(index);
                            Navigator.pop(context);
                          }),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getSuggestion(String input) async {
    String kPLACESAPIKEY = "AIzaSyCBx7lRHvmRJEeMbCIJWgjsUArU24Awq_k";
    String type = '.ug';
    String baseURL =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request =
        '$baseURL?input=$input&key=$kPLACESAPIKEY&sessiontoken=$_sessionToken';
    var response = await http.get(Uri.parse(request));
    if (response.statusCode == 200) {
      setState(() {
        _placeList = json.decode(response.body)['predictions'];
      });
    } else {
      throw Exception('Failed to load predictions');
    }
  }

  void getPosition(int index) async {
    String address = _placeList[index]["description"];
    String key = "AIzaSyCBx7lRHvmRJEeMbCIJWgjsUArU24Awq_k";
    String url =
        "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$key";

    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      // String location = json.decode(response.body)["results"][0]["geometry"];
      double latitude = jsonDecode(response.body)["results"][0]["geometry"]
          ["location"]["lat"];
      double longitude = jsonDecode(response.body)["results"][0]["geometry"]
          ["location"]["lng"];
      latLng = "Location: latLng($latitude, $longitude)";
      print("Location: latLng($latitude, $longitude)");

      bookingController.updatePickUpLat(latitude);
      bookingController.updatePickUpLng(longitude);
    }
  }
}
