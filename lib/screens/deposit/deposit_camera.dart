import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:front_end/provider/deposit/deposit_provider.dart';
import 'package:front_end/screens/deposit/deposit_display.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DepositCamera extends ConsumerStatefulWidget {
  DepositCamera({super.key, required this.cameras});

  final List<CameraDescription> cameras;

  @override
  _DepositCameraState createState() => _DepositCameraState();
}

class _DepositCameraState extends ConsumerState<DepositCamera> {
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
      final whichCheckprovided = ref.read(whichCheck);
      if (whichCheckprovided == 1) {
        ref.read(checkFront.notifier).state = File(picture.path);
      } else if (whichCheckprovided == 2) {
        ref.read(checkBack.notifier).state = File(picture.path);
      }
      print('Which ${whichCheckprovided}');
      context.go('/deposit_display');
      // Navigator.pop(context);
      // print('Camera screen: \n${picture.path}');
    } catch (e) {
      print('Error taking picture: $e');
      context.go('deposit_second');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.go('/deposit_second');
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    context.go('/deposit_second');
                  },
                  icon: Icon(Icons.arrow_back),
                ),
              ),
              body: Center(child: Text('Error: ${snapshot.error}')),
            );
          } else {
            double oneTenthWidth = MediaQuery.of(context).size.width * 0.2;

            return Scaffold(
              appBar: AppBar(
                title: Text('Put the check inside the box'),
                leading: IconButton(
                  onPressed: () {
                    context.go('/deposit_second');
                  },
                  icon: Icon(Icons.arrow_back),
                ),
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
