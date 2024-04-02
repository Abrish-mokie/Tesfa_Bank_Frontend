import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:front_end/screens/deposit/camera_screen.dart';
import 'package:front_end/widgets/custom_button.dart';

class AccountChoose extends StatefulWidget {
  const AccountChoose({super.key});

  @override
  State<AccountChoose> createState() => _AccountChooseState();
}

class _AccountChooseState extends State<AccountChoose> {
  // selected account
  String? selectedAccount;
  // Drop down items
  List<String> accountList = ['Chequing Account', 'Saving Account'];

  // controller for the amount text field
  TextEditingController amount = TextEditingController();

  // controller for the amount text field
  TextEditingController memo = TextEditingController();

  // File for storing paycheck front side
  File? checkFront;

  // File for storing paycheck back side
  File? checkBack;

  late final cameras = availableCameras().then((value) => value);

  void cameraController(BuildContext context, bool isFront) async {
    final cameraList = await cameras;

    Navigator.of(context).push(
      MaterialPageRoute(
        settings: const RouteSettings(name: "camera"),
        builder: (context) => CameraScreen(
          cameras: cameraList,
          onPicked: (File? image) {
            if (image != null) {
              setState(
                () {
                  if (isFront) {
                    checkFront = image;
                  } else {
                    checkBack = image;
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    amount.dispose();
    memo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Deposit'),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButton(
                  isExpanded: true,
                  hint: Text('Select an account'),
                  value: selectedAccount,
                  items: accountList.map((account) {
                    return DropdownMenuItem(
                      child: Text(account),
                      value: account,
                    );
                  }).toList(),
                  onChanged: (account) {
                    setState(
                      () {
                        selectedAccount = account;
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: amount,
                  decoration: InputDecoration(
                    hintText: 'Amount \$',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                SizedBox(
                  height: 25,
                ),
                TextField(
                  controller: memo,
                  maxLines: 4,
                  decoration: InputDecoration(
                    hintText: 'Memo (Optional)',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                    child: Text(
                  'Take pictures of Cheques',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              cameraController(context, false);
                            },
                            icon: checkBack == null
                                ? Icon(Icons.camera_alt, size: 30)
                                : Image.file(
                                    checkBack!,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Front')
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                            onPressed: () {
                              cameraController(context, true);
                            },
                            icon: checkFront == null
                                ? Icon(Icons.camera_alt, size: 30)
                                : Image.file(
                                    checkFront!,
                                    height: 50,
                                    width: 50,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text('Back')
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 90,
                ),
                CustomButton(
                  onPressed: () {},
                  title: 'Continue',
                  width: double.infinity,
                  isDisabled: false,
                ),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ));
  }
}
