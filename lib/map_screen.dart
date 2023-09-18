import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LocationData? _currentLocation; // Store the current location data
  final Location _location = Location();

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  // Initialize the map
  void _initMap() async {
    try {
      final LocationData locationData = await _location.getLocation();
      setState(() {
        _currentLocation = locationData;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    LatLng? initialLatLng; // Initialize as null

    if (_currentLocation != null) {
      // If we have a valid location, create a LatLng object
      initialLatLng = LatLng(
        _currentLocation!.latitude!,
        _currentLocation!.longitude!,
      );
    }

    return Scaffold(
      body: initialLatLng != null
          ? GoogleMap(
              initialCameraPosition: CameraPosition(
                target: initialLatLng,
                zoom: 14,
              ),
            )
          : const Center(
              child:
                  CircularProgressIndicator(), // Show a loading indicator while fetching the location
            ),
    );
  }
}
