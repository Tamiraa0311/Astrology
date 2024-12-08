import 'package:flutter/material.dart';
import '../navbar/navBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlanetPage extends StatefulWidget {
  @override
  _PlanetPageState createState() => _PlanetPageState();
}

class _PlanetPageState extends State<PlanetPage> {
  int _selectedIndex = 1;

  // Default selected planet
  String selectedPlanet = '';
  double selectedScale = 1.2;
  double otherScale = 1.0;

  // Planets list (fetched dynamically)
  List<Map<String, dynamic>> planets = [];

  // ScrollController for smooth scrolling
  ScrollController _scrollController = ScrollController();

  // Fetch planet data from the backend
  Future<void> fetchPlanets() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.10:3000/planets'));
      if (response.statusCode == 200) {
        final List<dynamic> planetData = jsonDecode(response.body);

        setState(() {
          planets = planetData.map((data) {
            return {
              'name': data['name'],
              'image': data['image'],
              'description': data['description'],
            };
          }).toList();

          // Set the default selected planet
          if (planets.isNotEmpty) {
            selectedPlanet = planets[0]['name']!;
          }
        });
      } else {
        throw Exception('Failed to load planets');
      }
    } catch (e) {
      print('Error fetching planets: $e');
    }
  }

  // Handle navigation bar item selection
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchPlanets();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          children: [
            // Top Spacing for planets
            SizedBox(height: 20),

            // Planets (Horizontal scrolling with animation)
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.only(top: 70),
                child: planets.isEmpty
                    ? Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _scrollController,
                        itemCount: planets.length,
                        clipBehavior: Clip.none,
                        itemBuilder: (context, index) {
                          final planet = planets[index];
                          final isSelected = planet['name'] == selectedPlanet;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedPlanet = planet['name']!;
                              });

                              // Calculate the offset to center the selected planet
                              double screenWidth =
                                  MediaQuery.of(context).size.width;
                              double itemWidth =
                                  140.0; // Adjust to match your item's actual width
                              double targetOffset = (index * itemWidth) -
                                  (screenWidth - itemWidth) / 2;

                              // Clamp the offset to ensure it stays within bounds
                              targetOffset = targetOffset.clamp(
                                _scrollController.position.minScrollExtent,
                                _scrollController.position.maxScrollExtent,
                              );

                              _scrollController.animateTo(
                                targetOffset,
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
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.contain,
                                    ),
                                    SizedBox(height: 6),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),

            // Planet Name
            Text(
              selectedPlanet.isNotEmpty ? selectedPlanet : 'Loading...',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),

            // Planet Description
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Color(0xFF0A0E21),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Color(0xFFF8B9FF),
                      width: 2,
                    ),
                  ),
                  child: Text(
                    selectedPlanet.isNotEmpty
                        ? planets.firstWhere((planet) =>
                            planet['name'] == selectedPlanet)['description']!
                        : '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyNavBarPage(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
