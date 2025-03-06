// map_screen.dart
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  final LatLng _initialPosition = const LatLng(37.7749, -122.4194); // Default to San Francisco
  final Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    setState(() {
      _markers.add(
        Marker(
          markerId: const MarkerId("current_location"),
          position: _initialPosition,
          infoWindow: const InfoWindow(title: "Your Location"),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Map")),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 14.0,
        ),
        markers: _markers,
      ),
    );
  }
}
