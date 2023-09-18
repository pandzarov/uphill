import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription>? cameras;
  const CameraPage({this.cameras, Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController controller;
  XFile? pictureFile;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  // Initialize the camera and handle errors
  Future<void> initializeCamera() async {
    if (widget.cameras == null || widget.cameras!.isEmpty) {
      // Handle case where there are no available cameras.
      print("No available cameras.");
    } else {
      controller = CameraController(
        widget.cameras![0],
        ResolutionPreset.max,
      );

      try {
        await controller.initialize();
        if (!mounted) {
          return;
        }
        setState(() {});
      } catch (e) {
        print("Error initializing camera: $e");
        // Handle the error, e.g., show an error message to the user.
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SizedBox(
              height: 400,
              width: 400,
              child: CameraPreview(controller),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () async {
              try {
                pictureFile = await controller.takePicture();
                setState(() {});
              } catch (e) {
                print("Error taking picture: $e");
                // Handle the error, e.g., show an error message to the user.
              }
            },
            child: const Text('Capture Image'),
          ),
        ),
        if (pictureFile != null)
          Image.file(
            File(pictureFile!.path),
            height: 200,
          ),
      ],
    );
  }
}
