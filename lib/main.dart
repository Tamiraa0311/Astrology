import 'package:flutter/material.dart';
import './page/startpage.dart'; // Import the new startpage.dart file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Startpage(), // Set Startpage as the initial screen
    );
  }
}
