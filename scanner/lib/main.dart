import 'package:flutter/material.dart';

import 'package:scanner/screen/onboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool ischeck = false;
  @override
  void initState() {
    super.initState();
    // var boolValues = getBoolValues();
    // print(boolValues);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // ignore: unrelated_type_equality_checks
        // home: ischeck ? const BottomNavigationContainor() : OnboardScreen());
        home: OnboardScreen());
  }

  getBoolValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool val = prefs.getBool('check') ?? false;
    setState(() {
      ischeck = val;
      print(ischeck);
    });
  }
}
