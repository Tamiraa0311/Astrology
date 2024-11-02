import 'package:flutter/material.dart';

class ZodiacPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 450,
      height: 852,
      child: Stack(
        children: [
          // Background Image
          Container(
            width: 450,
            height: 852,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/stars_background.jpg"), // Ensure asset path is correct
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Title Text
          Positioned(
            top: 450, // Positioning from the top
            left: 130, // Positioning from the left
            child: Text(
              'Зурхай',
              style: TextStyle(
                color: Color(0xFFEFF8FF),
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                height: 1.2,
                letterSpacing: 2.16,
              ),
            ),
          ),
          // Zodiac Symbols Container with positioned icon
          Positioned(
            top: 450, // Change this value to move the icon up or down
            left: 70, // Change this value to move the icon left or right
            child: Transform(
              transform: Matrix4.identity()
                ..rotateZ(-1.57), // Adjust rotation if needed
              child: Container(
                width: 251,
                height: 212,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/png-image.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
