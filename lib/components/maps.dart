
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController? mapController;
  Location location = Location();
  Set<Marker> markers = {};

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    await _getUserLocation();
  }

  Future<void> _getUserLocation() async {
    final userLocation = await location.getLocation();
    setState(
      () {
        markers.add(
          Marker(
            markerId: MarkerId('userLocation'),
            position: LatLng(userLocation.latitude!, userLocation.longitude!),
            infoWindow: InfoWindow(title: 'Sua Localização'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            CameraPosition(target: LatLng(37.7749, -122.4194), zoom: 2),
      ),
    );
  }
}
