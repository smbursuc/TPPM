import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';


void main() => runApp(MyApp());


class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  int value = -1;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text("Test")),
            body: GetBody()));
  }

  Widget GetBody() {
    return Center(
        child: ElevatedButton(
            child: Text(value == -1 ? "Random" : "Value: ${value}"),
            onPressed: onButtonPressed));

  }

  void onButtonPressed() {
    setState(() {
      value = Random().nextInt(100);
    });
  }

  MyAppState() {
    Timer.periodic(
        Duration(seconds: 1),
            (t) => setState(() {

          value++;
        }));

  }
}