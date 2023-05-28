import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/container.dart';
//import 'package:flutter/src/widgets/framework.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({super.key});

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  late GoogleMapController mapController;
  late Location location;
  late LatLng currentLocation;

  //final LatLng _center = const LatLng(45.521563, -122.677433);
  @override
  void initState() {
    super.initState();
    location = Location();
    currentLocation = const LatLng(45.521563, -122.677433);
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Future<void> _getUserLocation() async {
    final hasPermission = await location.hasPermission();
    if (hasPermission == PermissionStatus.denied) {
      await location.requestPermission();
      _getUserLocation();
      return;
    }

    final locationData = await location.getLocation();
    setState(() {
      currentLocation = LatLng(
        locationData.latitude!,
        locationData.longitude!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('GOOGLE MAPS'),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition:
              CameraPosition(target: currentLocation, zoom: 11.0),
          markers: {
            Marker(
              markerId: const MarkerId('currentLocation'),
              position: currentLocation,
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueAzure),
            ),
          },
        ));
  }
}
