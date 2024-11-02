import 'package:flutter/material.dart';
import 'package:horoscope_app/page/startpage.dart';

void main() {
  runApp(Startpage());
}

class Startpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: ZodiacPage(),
          ),
        ),
      ),
    );
  }
}
