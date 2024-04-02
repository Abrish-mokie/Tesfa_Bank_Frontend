import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:front_end/screens/deposit/display_picture.dart';

class CameraScreen extends StatefulWidget {
  CameraScreen({super.key, required this.cameras, required this.onPicked});

  final List<CameraDescription> cameras;

  final void Function(File? image) onPicked;

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isFlashOn = true;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.cameras[0], ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashOn = !_isFlashOn;
      _isFlashOn
          ? _controller.setFlashMode(FlashMode.torch)
          : _controller.setFlashMode(FlashMode.off);
    });
  }

  void takePicture() async {
    try {
      XFile? picture = await _controller.takePicture();
      // Do something with the captured picture (e.g., save it, display it)
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DisplayPicture(
            location: picture,
            check: (image) {
              picture = image;
            },
          ),
        ),
      );
      widget.onPicked(picture == null ? null : File(picture!.path));
      // Navigator.pop(context);
      // print('Camera screen: \n${picture.path}');
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(),
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else {
            double oneTenthWidth = MediaQuery.of(context).size.width * 0.2;

            return Scaffold(
              appBar: AppBar(
                title: Text('Put the check inside the box'),
                centerTitle: true,
              ),
              body: Stack(
                children: [
                  Positioned.fill(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: CameraPreview(_controller),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    left: 0,
                    child: Container(
                      width: oneTenthWidth,
                      color: Color.fromARGB(220, 178, 169, 169),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: oneTenthWidth,
                    left: oneTenthWidth,
                    child: Container(
                      height: oneTenthWidth,
                      color: Color.fromARGB(220, 178, 169, 169),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: oneTenthWidth,
                      color: Color.fromARGB(220, 178, 169, 169),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: oneTenthWidth,
                    right: oneTenthWidth,
                    child: Container(
                      height: oneTenthWidth,
                      color: Color.fromARGB(220, 178, 169, 169),
                    ),
                  ),
                  Positioned(
                    left: oneTenthWidth,
                    right: oneTenthWidth,
                    top: oneTenthWidth,
                    bottom: oneTenthWidth,
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 5)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: takePicture,
                            child: Icon(Icons.camera),
                          ),
                          ElevatedButton(
                              onPressed: _toggleFlash,
                              child: _isFlashOn
                                  ? Icon(Icons.flash_on)
                                  : Icon(Icons.flash_off))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        });
  }
}
