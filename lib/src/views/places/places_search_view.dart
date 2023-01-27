import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class PlaceDetail {
  String? label, description;
  final double lat, long;

  PlaceDetail({
    this.label,
    this.description,
    required this.lat,
    required this.long,
  });

  factory PlaceDetail.fromJson(Map<String, dynamic> data) {
    return PlaceDetail(
      lat: data['geometry']["location"]["lat"],
      long: data['geometry']["location"]["lng"],
      description: data['formatted_address'],
    );
  }

  static Future<PlaceDetail?> searchAddressDetail(
      String placeId, String address) async {
    String key = "AIzaSyCBx7lRHvmRJEeMbCIJWgjsUArU24Awq_k";
    String url =
        'https://maps.googleapis.com/maps/api/place/details/json?fields=formatted_address,name,geometry&place_id=$placeId&key=$key';

    // "https://maps.googleapis.com/maps/api/geocode/json?address=$address&key=$key";
    try {
      var response = await http.get(Uri.parse(url));
      PlaceDetail detail =
          PlaceDetail.fromJson(Map.from(jsonDecode(response.body)["result"]));
      detail.label = address;
      return detail;
    } catch (e) {
      return null;
    }
  }
}

class PlacesSearchResult {
  final String? description, placeId, reference, label;

  PlacesSearchResult({
    this.description,
    this.placeId,
    this.reference,
    this.label,
  });

  factory PlacesSearchResult.fromJson(Map<String, dynamic> data) {
    return PlacesSearchResult(
      description: data['description'],
      placeId: data['place_id'],
      reference: data['reference'],
      label: data['structured_formatting']['main_text'],
    );
  }

  static Future<List<PlacesSearchResult>> searchLocation(
      var text, String country) async {
    try {
      String kGoogleApiKey = 'AIzaSyCBx7lRHvmRJEeMbCIJWgjsUArU24Awq_k';
      String baseURL =
          'https://maps.googleapis.com/maps/api/place/autocomplete/json';

      String request =
          '$baseURL?input=$text&key=$kGoogleApiKey&components=country%3A$country';

      var response = await http.get(Uri.parse(request));

      final predictions = json.decode(response.body)['predictions'];

      return List.from(predictions)
          .map((e) => PlacesSearchResult.fromJson(Map.from(e)))
          .toList();
    } catch (e) {
      print('Place Search Error =====');
      print(e);
      return [];
    }
  }
}

class PlacesSearchView extends StatefulWidget {
  const PlacesSearchView({
    Key? key,
    required this.title,
    required this.placeholder,
    this.onPlaceSelect,
    required this.countryCode,
  }) : super(key: key);
  final String title;
  final String placeholder;
  final String? countryCode;
  final Function(PlaceDetail? detail)? onPlaceSelect;

  @override
  State<PlacesSearchView> createState() => _PlacesSearchViewState();
}

class _PlacesSearchViewState extends State<PlacesSearchView> {
  final _placesController =
      StreamController<List<PlacesSearchResult>>.broadcast();

  String countryCode = 'ZA';

  @override
  void initState() {
    if (widget.countryCode != null) {
      countryCode = widget.countryCode!;
    } else {
      getCountryCode();
    }
    initializeSearch();
    super.initState();
  }

  @override
  void dispose() {
    _placesController.close();
    super.dispose();
  }

  Future<void> initializeSearch() async {
    List<PlacesSearchResult> results =
        await PlacesSearchResult.searchLocation('a', countryCode);
    _placesController.sink.add(results);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actionsIconTheme: const IconThemeData(
              color: Color(0xff646464),
            ),
            iconTheme: const IconThemeData(
              color: Color(0xff646464),
            ),
            centerTitle: false,
            leadingWidth: 0,
            leading: Container(),
            elevation: 2,
            title: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: const Icon(
                        Icons.arrow_back,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildSearchField(),
              ],
            ),
            toolbarHeight: 100,
          ),
          //body
          body: StreamBuilder<List<PlacesSearchResult>>(
            stream: _placesController.stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated(
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (_, __) => const Divider(height: 5),
                itemBuilder: (context, index) {
                  PlacesSearchResult result = snapshot.data![index];
                  return ListTile(
                    // leading:
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 3,
                    ),
                    title: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xff646464).withOpacity(.15),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Icon(
                            Icons.location_pin,
                            color: Colors.blueGrey,
                            size: 19,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                result.label ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                result.description!,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 14.0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          // color: Colors.blueGrey,
                          size: 16,
                        ),
                      ],
                    ),
                    onTap: () async {
                      PlaceDetail? detail =
                          await PlaceDetail.searchAddressDetail(
                              result.placeId!, result.description!);
                      if (widget.onPlaceSelect != null) {
                        widget.onPlaceSelect!(detail);
                      }
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Future<String> getCountryCode() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    debugPrint('location: ${position.latitude}');

    var addresses =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var code = addresses.first.isoCountryCode ?? 'ZA';
    setState(() {
      countryCode = code;
    });
    print('=======================');
    print(code);

    return code; // this will return country code
  }

  _buildSearchField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      autofocus: false,
      onChanged: (text) async {
        List<PlacesSearchResult> results =
            await PlacesSearchResult.searchLocation(text, countryCode);
        _placesController.sink.add(results);
      },
      style: const TextStyle(
        fontSize: 14,
        color: Color.fromRGBO(0, 0, 0, 0.87),
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: widget.placeholder,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 14.0,
          color: Color(0xff646464),
        ),
        filled: true,
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: Color(0xff646464),
        ),
        counterText: '',
        counter: null,
        fillColor: const Color(0xff646464).withOpacity(.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
          // BorderSide(
          //   width: 1.2,
          //   color: Colors.grey[350]!,
          // ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
          // BorderSide(
          //   width: 1.2,
          //   color: Colors.grey[350]!,
          // ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: BorderSide.none,
          // const BorderSide(
          //   width: 1.8,
          //   color: Color(0xff042B52),
          // ),
        ),
      ),
    );
  }
}
