import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:uphill/camera_page.dart';
import 'package:uphill/map_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();
  String locationText = " ";

  @override
  void initState() {
    requestLocationPermission();
    userController.addListener(() {
      setState(() {});
    });

    passwordController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  void requestLocationPermission() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        // Handle the case where the user did not enable location services.
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        // Handle the case where the user denied location permission.
        return;
      }
    }
  }

  Future<String> getCurrentLocation() async {
    Location location = Location();

    try {
      LocationData locationData = await location.getLocation();

      double? latitude = locationData.latitude;
      double? longitude = locationData.longitude;
      String locationText = "$latitude,  $longitude";

      if (kDebugMode) {
        print("Latitude: $latitude, Longitude: $longitude");
      }
    } catch (e) {
      // Handle exceptions (e.g., location services disabled or permissions denied).
      print("Error getting location: $e");
    }
    return locationText;
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(top: screenHeight * 0.25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const MapPage()));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/click.png', // Replace with your logo image path
                        width: screenWidth * 0.90,
                        height: screenHeight * 0.40,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: const Text(
                      'Tap to add a destination',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      top: screenHeight * 0.10,
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: const Text(
                      'Your current address',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        getCurrentLocation();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.red, // Set button color to green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        "location",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(
                      left: screenWidth * 0.20,
                      right: screenWidth * 0.20,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        await availableCameras().then((value) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => const CameraPage()));
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.green, // Set button color to green
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      child: const Text(
                        'Take a picture',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
