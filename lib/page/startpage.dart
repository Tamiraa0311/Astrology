import 'package:flutter/material.dart';

class Startpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        // Set the background image dynamically
        decoration: const BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/stars_background.jpg'), // Path to your image
            fit: BoxFit.cover, // This ensures the image covers the whole screen
            alignment: Alignment.center, // Align the image to the center
          ),
        ),
        width: screenWidth, // Fill the screen width
        height: screenHeight, // Fill the screen height
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              'assets/png-image.png',
              width: 251,
              height: 212,
            ),

            const SizedBox(height: 20), // Space between the image and the text
            // Centered text
            const Text(
              'Зурхай',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
