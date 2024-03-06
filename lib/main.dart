import 'package:flutter/material.dart';
import 'package:front_end/screens/home.dart';
import 'package:front_end/screens/onboarding.dart';
import 'package:front_end/screens/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  late Widget screen;

  Future checkSeen() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seen = (prefs.getBool('seen') ?? false);
    if (seen) {
      setState(() {
        screen = const Home();
      });
    } else {
      await prefs.setBool('seen', true);
      setState(() {
        screen = const Onboarding();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkSeen();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(
          const Duration(seconds: 1),
        ),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? screen
                : const Splash(),
      ),
    );
  }
}
