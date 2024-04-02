import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:front_end/screens/deposit/account_choose_page.dart';

class Deposite_page extends StatelessWidget {
  const Deposite_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Deposit Check'),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 35),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AccountChoose())),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(10),
                child: const Row(children: [
                  Icon(
                    Icons.camera_alt_outlined,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Deposit Checkque',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Take a photo of your cheque to deposite it to your account',
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(8)),
                padding: const EdgeInsets.all(10),
                child: const Row(children: [
                  Icon(
                    Icons.history,
                    size: 25,
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Mobile Deposit History',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'View a recent history of your mobile deposits',
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
