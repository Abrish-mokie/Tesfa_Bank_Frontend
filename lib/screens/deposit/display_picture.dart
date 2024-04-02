import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  const DisplayPicture(
      {super.key, required this.location, required this.check});

  final XFile? location;

  final Function(XFile? image) check;

  @override
  Widget build(BuildContext context) {
    double oneTenthWidth = MediaQuery.of(context).size.width * 0.2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Put the check inside the box'),
        centerTitle: true,
      ),
      body: location == null
          ? Center(
              child: Text('No image'),
            )
          : Stack(
              children: [
                Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Image.file(File(location!.path)),
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
                          onPressed: () {
                            check(location);
                            Navigator.of(context).popUntil(
                              (route) {
                                return route.settings.name == 'camera';
                              },
                            );
                          },
                          child: Icon(Icons.done),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            check(null);
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.remove_circle_outline_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
    ;
  }
}
