import 'package:flutter/material.dart';

class PlanetPage extends StatefulWidget {
  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  String selectedPlanet = 'Cap'; // Default planet
  double selectedScale = 1.5; // Scale for selected planet
  double otherScale = 1.0; // Scale for other planets

  // Planet data
  final List<Map<String, String>> planets = [
    {
      'name': 'Cap',
      'image': 'assets/moon.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
    },
    {
      'name': 'Mars',
      'image': 'assets/mars.png',
      'description': 'Mars is the Red Planet.',
    },
    {
      'name': 'Sun',
      'image': 'assets/sun.png',
      'description': 'The Sun is the center of the Solar System.',
    },
    {
      'name': 'Earth',
      'image': 'assets/earth.png',
      'description': 'Earth is our home planet.',
    },
    {
      'name': 'Venus',
      'image': 'assets/venus.png',
      'description': 'Venus is known as Earth\'s twin.',
    },
    {
      'name': 'Jupiter',
      'image': 'assets/jupiter.png',
      'description': 'Jupiter is the largest planet in the Solar System.',
    },
    {
      'name': 'Saturn',
      'image': 'assets/saturn.png',
      'description': 'Saturn is famous for its rings.',
    },
  ];

  // ScrollController for scrolling between planets
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1C1C4E), // Background color
      body: Column(
        children: [
          // Top Spacing
          SizedBox(height: 50),

          // Planets (Scrollable horizontally)
          Expanded(
            flex: 3,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              itemCount: planets.length,
              itemBuilder: (context, index) {
                final planet = planets[index];
                final isSelected = planet['name'] == selectedPlanet;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPlanet = planet['name']!;
                    });

                    // Scroll to the selected planet
                    _scrollController.animateTo(
                      index * 160.0, // Scroll position based on index
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: AnimatedScale(
                    scale: isSelected ? selectedScale : otherScale,
                    duration: Duration(milliseconds: 300),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            planet['image']!,
                            width: 120,
                            height: 120,
                          ),
                          SizedBox(height: 10),
                          Text(
                            planet['name']!,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Planet Name
          Text(
            selectedPlanet,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          // Planet Description
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color(0xFF303057),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                planets.firstWhere((planet) =>
                    planet['name'] == selectedPlanet)['description']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ),
          ),

          // Bottom Navigation Bar
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            color: Color(0xFF303057),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNavItem('assets/earth.png', 'Overview'),
                _buildNavItem('assets/moon.png', 'Cap'),
                _buildNavItem('assets/sanchir.png', 'Exploration'),
                _buildNavItem('assets/saturn.png', 'Orbit'),
                _buildNavItem('assets/sun.png', 'Profile'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String iconPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          width: 30,
          height: 30,
        ),
        SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }
}
