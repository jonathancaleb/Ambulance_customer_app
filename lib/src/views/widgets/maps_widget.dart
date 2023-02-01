import '../../services/exporter.dart';

class MapsWidget extends StatefulWidget {
  final CameraPosition initialLocation;
  final Set<Marker> markers;
  final Set<Polyline> polylines;
  final void Function(GoogleMapController)? onMapCreated;
  const MapsWidget({
    Key? key,
    required this.initialLocation,
    required this.markers,
    required this.polylines,
    required this.onMapCreated,
  }) : super(key: key);

  @override
  State<MapsWidget> createState() => _MapsWidgetState();
}

class _MapsWidgetState extends State<MapsWidget> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: widget.initialLocation,
      //   myLocationEnabled: true,
      myLocationButtonEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
      polylines: widget.polylines,
      onMapCreated: widget.onMapCreated,
      markers: widget.markers,
    );
  }
}
