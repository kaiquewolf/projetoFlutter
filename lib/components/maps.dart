// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:projeto_flutter_mylink/controllers/maps.permissions.dart';

class Maps extends StatefulWidget {
  const Maps({super.key});

  @override
  State<Maps> createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  late GoogleMapController mapController;
  Position? position;

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
              Geolocator.getPositionStream().listen(
            (Position? position) {
              mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                      zoom: 20.5,
                      target: LatLng(position!.latitude.toDouble(),
                          position.longitude.toDouble())),
                ),
              );
            },
          );
        },
        myLocationEnabled: true,
      ),
    );
  }
}
