import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  Position? position;

  Future<Position> getCurrentLocation() async {
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

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition:
            const CameraPosition(target: LatLng(-15.7801, -47.9292), zoom: 4),
        onMapCreated: (controller) {
          getCurrentLocation();
          mapController = controller;

          // ignore: unused_local_variable
          StreamSubscription<Position> positionStream =
              Geolocator.getPositionStream().listen((Position? position) {
            mapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    zoom: 20.5,
                    target: LatLng(position!.latitude.toDouble(),
                        position.longitude.toDouble())),
              ),
            );

            print("${position.latitude}, ${position.longitude} ");
          });
          setState(() {
            dispose();
          });
        },
        myLocationEnabled: true,
      ),
    );
  }

  final snackBarError = const SnackBar(
    content: Text(
      'Por favor para ter uma melhor experiência com nosso app, verifique se permitiiu a localização ou se está desativada!',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.lightGreen,
    duration: Duration(seconds: 30),
  );
}
