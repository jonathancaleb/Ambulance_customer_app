// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math' show cos, sqrt, asin;
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

import '../models/driver_data_model.dart';
import '../services/exporter.dart';
import '../services/secrets.dart';

///This provides the actual MapController class.
final getxMapController = Get.put(MapController());

class MapController extends GetxController {
// Google Plex
  final CameraPosition initialLocation = const CameraPosition(
    //target: LatLng(0.0, 0.0),
    target: LatLng(37.43296265331129, -122.08832357078792),
    zoom: 14.4746,
  );

  final Completer<GoogleMapController> completer = Completer();

  late GoogleMapController mapController;

  late Position currentPosition;
  String currentAddress = 'Use My Current Location';
  // String destinationAddress = 'Select Destination';

  // Current Device country code
  // Used for location search boundary
  String? currentCountryCode;

  String startAddress = '';
  String destinationAddress = 'Set your Delivery Location';
  // String? placeDistance;

// to get startup and destination cordinates
  String startingAddress = ' ';
  double startLat = 0.0;
  double startLong = 0.0;
  String destAddress = ' ';
  double destLat = 0.0;
  double destLong = 0.0;
  DriverDataModel? driverDataModel;

  Set<Marker> markers = {};

  final Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];

  final scaffoldKey = GlobalKey<ScaffoldState>();
  BitmapDescriptor? customMarker, destinationMarkerIcon, driverMarkerIcon;

  void updateMapController(GoogleMapController controller) {
    String mapStyle;

    mapController = controller;
    rootBundle.loadString('assets/map_style.txt').then((string) {
      mapStyle = string;
      mapController.setMapStyle(mapStyle);
    });
    update();
  }

  updatePickUpLocationAddress(String address) {
    currentAddress = address;
    startAddress = address;
    update();
  }

  updateDeliveryAddress(String address) {
    destinationAddress = address;
    update();
  }

  String getDeliveryLocationAddress() {
    return destinationAddress;
  }

  //update driver position on map
  void updateDriverLocation(DriverDataModel driverData) {
    driverDataModel = driverDataModel;
    if (driverDataModel != null) {
      Marker driverMarker = Marker(
        markerId: const MarkerId('driver'),
        position: LatLng(double.parse(driverDataModel!.data.lat),
            double.parse(driverDataModel!.data.long)),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title:
              'driver ${driverDataModel!.data.lat} ${driverDataModel!.data.long}',
          snippet: startAddress,
        ),
        icon: driverMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );
      markers.add(driverMarker);
      update();
    }
  }

  Future<Uint8List> _getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width, targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _setSourceAndDestinationMarkerIcon() async {
    final Uint8List markerIcon =
        await _getBytesFromAsset('assets/navigation.png', 70);
    final Uint8List driverIcon =
        await _getBytesFromAsset('assets/navigation.png', 70);
    final Uint8List destinationIcon =
        await _getBytesFromAsset('assets/map.png', 70);
    customMarker = BitmapDescriptor.fromBytes(markerIcon);
    driverMarkerIcon = BitmapDescriptor.fromBytes(driverIcon);
    destinationMarkerIcon = BitmapDescriptor.fromBytes(destinationIcon);
    update();
  }

  // for updating and fetching the starting cordinates
  updatePickuplatitudeLongitude(String address) async {
    startingAddress = address;
    List<Location> startPlacemark = await locationFromAddress(startingAddress);
    startLat = startPlacemark[0].latitude;
    startLong = startPlacemark[0].longitude;
    update();
  }

  /// Update Pickup location with location details
  setPickupLatLng(
      {required double lat, required double lng, required String address}) {
    startingAddress = address;
    startAddress = address;
    currentAddress = address;
    startLat = lat;
    startLong = lng;
    update();
  }

  /// Update drop off location (destination) with location details
  setDestinationLatLng(
      {required double lat, required double lng, required String address}) {
    destAddress = address;
    destinationAddress = address;
    destLat = lat;
    destLong = lng;
    update();
  }

  /// Initialize User country code
  /// Used for location search boundary to users location
  /// ! NOT USED switched to _getAddress()
  Future<void> initUserCountryCode() async {
    if (currentPosition.latitude > 0.0 && currentPosition.longitude > 0.0) {
      var addresses = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      var code = addresses.first.isoCountryCode ?? 'ZA';
      currentCountryCode = code;
      update();
    }
  }

  double getPickupLatitude() {
    return startLat;
  }

  double getPickupLongitude() {
    return startLong;
  }

  updateDestinationLatitudelongitude(String address) async {
    destAddress = address;
    List<Location> destinationPlacemark =
        await locationFromAddress(destAddress);
    destLat = destinationPlacemark[0].latitude;
    destLong = destinationPlacemark[0].longitude;
    update();
  }

  double getDestinationLatitude() {
    return destLat;
  }

  double getDestinationLongitude() {
    return destLong;
  }

// this initializes the map controller
  Future<void> init() async {
    print("Initialization Started");

    // get permission to access location
    await _requestPermissions();
    print("Permissions Sorted");
    _setSourceAndDestinationMarkerIcon();
  }

  // void showRouteAndCalculateDistance(BuildContext context) async {
  //   if (markers.isNotEmpty) markers.clear();
  //   if (polylines.isNotEmpty) {
  //     polylines.clear();
  //   }
  //   if (polylineCoordinates.isNotEmpty) {
  //     polylineCoordinates.clear();
  //   }
  //   placeDistance = null;

  //   calculateDistance().then((isCalculated) {
  //     if (isCalculated) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Distance Calculated Sucessfully'),
  //         ),
  //       );
  //     } else {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         const SnackBar(
  //           content: Text('Error Calculating Distance'),
  //         ),
  //       );
  //     }
  //   });

  //   update();
  // }

  Future<void> _requestPermissions() async {
    //requesting permission
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
  }

  // Method for retrieving the current location
  Future<void> getCurrentLocation() async {
    print("Started Getting Location");

    // When we reach here, permissions are granted and we can
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      currentPosition = position;
      print('CURRENT POS: $currentPosition');
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(position.latitude, position.longitude),
            zoom: 14.4746,
          ),
        ),
      );

      update();
      await _getAddress();
    }).catchError((e) {
      print(e);
    });
  }

  // Method for retrieving the address
  _getAddress() async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);

      Placemark place = p[0];

      //Update start latitude and longitude
      startLat = currentPosition.latitude;
      startLong = currentPosition.longitude;
      Marker startMarker = Marker(
        markerId: const MarkerId('me'),
        position: LatLng(startLat, startLong),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title: 'Start $startLat $startLong',
          snippet: startAddress,
        ),
        icon: destinationMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );
      markers.add(startMarker);
      currentAddress =
          "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
      startAddress = currentAddress;
      startingAddress = currentAddress;

      var code = place.isoCountryCode;
      currentCountryCode = code;

      update();
    } catch (e) {
      print(e);
    }
  }

  // Method for calculating the distance between two places
  Future<bool> calculateDistance() async {
    try {
      // Retrieving placemarks from addresses
      List<Location> startPlacemark = await locationFromAddress(startAddress);
      List<Location> destinationPlacemark =
          await locationFromAddress(destinationAddress);

      // Use the retrieved coordinates of the current position,
      // instead of the address if the start position is user's
      // current position, as it results in better accuracy.
      double startLatitude = startPlacemark[0].latitude;
      double startLongitude = startPlacemark[0].longitude;

      double destinationLatitude = destinationPlacemark[0].latitude;
      double destinationLongitude = destinationPlacemark[0].longitude;

      String startCoordinatesString = '($startLatitude, $startLongitude)';
      String destinationCoordinatesString =
          '($destinationLatitude, $destinationLongitude)';

      // Start Location Marker
      Marker startMarker = Marker(
        markerId: MarkerId(startCoordinatesString),
        position: LatLng(startLatitude, startLongitude),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title: 'Start $startCoordinatesString',
          snippet: startAddress,
        ),
        icon: destinationMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );

      // Destination Location Marker
      Marker destinationMarker = Marker(
        markerId: MarkerId(destinationCoordinatesString),
        position: LatLng(destinationLatitude, destinationLongitude),
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: const Offset(0.5, 0.5),
        infoWindow: InfoWindow(
          title: 'Destination $destinationCoordinatesString',
          snippet: destinationAddress,
        ),
        icon: destinationMarkerIcon ?? BitmapDescriptor.defaultMarker,
      );

      // Adding the markers to the list
      markers
          .removeWhere((element) => element.markerId == const MarkerId('me'));
      markers.add(startMarker);
      print("pickup marker establised");
      markers.add(destinationMarker);
      print("destination marker establised");

      print(
        'START COORDINATES: ($startLatitude, $startLongitude)',
      );
      print(
        'DESTINATION COORDINATES: ($destinationLatitude, $destinationLongitude)',
      );

      // Calculating to check that the position relative
      // to the frame, and pan & zoom the camera accordingly.
      double miny = (startLatitude <= destinationLatitude)
          ? startLatitude
          : destinationLatitude;
      double minx = (startLongitude <= destinationLongitude)
          ? startLongitude
          : destinationLongitude;
      double maxy = (startLatitude <= destinationLatitude)
          ? destinationLatitude
          : startLatitude;
      double maxx = (startLongitude <= destinationLongitude)
          ? destinationLongitude
          : startLongitude;

      double southWestLatitude = miny;
      double southWestLongitude = minx;

      double northEastLatitude = maxy;
      double northEastLongitude = maxx;

      // Accommodate the two locations within the
      // camera view of the map
      mapController.animateCamera(
        CameraUpdate.newLatLngBounds(
          LatLngBounds(
            northeast: LatLng(northEastLatitude, northEastLongitude),
            southwest: LatLng(southWestLatitude, southWestLongitude),
          ),
          150.0,
        ),
      );

      // Calculating the distance between the start and the end positions
      // with a straight path, without considering any route
      // double distanceInMeters = await Geolocator.bearingBetween(
      //   startLatitude,
      //   startLongitude,
      //   destinationLatitude,
      //   destinationLongitude,
      // );

      await _createPolylines(startLatitude, startLongitude, destinationLatitude,
          destinationLongitude);

      // double totalDistance = 0.0;

      // Calculating the total distance by adding the distance
      // between small segments
      // for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      //   totalDistance += _coordinateDistance(
      //     polylineCoordinates[i].latitude,
      //     polylineCoordinates[i].longitude,
      //     polylineCoordinates[i + 1].latitude,
      //     polylineCoordinates[i + 1].longitude,
      //   );
      // }

      // placeDistance = totalDistance.toStringAsFixed(2);
      // print('DISTANCE: $placeDistance km');
      update();

      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }

  // Formula for calculating distance between two coordinates
  // https://stackoverflow.com/a/54138876/11910277
  // ignore: unused_element
  double _coordinateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  // Create the polylines for showing the route between two places
  _createPolylines(
    double startLatitude,
    double startLongitude,
    double destinationLatitude,
    double destinationLongitude,
  ) async {
    //remove lines if exist
    polylines.removeWhere(
        (element) => element.polylineId == const PolylineId('poly'));

    // Initializing PolylinePoints
    PolylinePoints polylinePoints = PolylinePoints();

    // Generating the list of coordinates to be used for
    // drawing the polylines
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      Secrets.mapAPIKeyV2, // Google Maps API Key
      PointLatLng(startLatitude, startLongitude),
      PointLatLng(destinationLatitude, destinationLongitude),
      travelMode: TravelMode.driving,
    );
    print("my results for the polylines ${result.points}");
    // print(result.points);

    // Adding the coordinates to the list
    if (result.points.isNotEmpty) {
      //remove pre- existent polylineCoordinates
      polylineCoordinates.clear();
      for (var element in result.points) {
        //add pre- existent polylineCoordinates
        polylineCoordinates.add(LatLng(element.latitude, element.longitude));
      }
    } else {
      print(result.errorMessage);
    }

    // Defining an ID
    PolylineId id = const PolylineId('poly');

    // Initializing Polyline
    Polyline polyline = Polyline(
      polylineId: id,
      color: const Color(0xff042B52),
      points: polylineCoordinates,
      width: 5,
    );

    // Adding the polyline to the map
    polylines.add(polyline);
    update();
  }
}
