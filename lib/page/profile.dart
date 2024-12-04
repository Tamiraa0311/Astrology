import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zodiac Profile',
      theme: ThemeData.dark(),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  final List<Map<String, String>> navItems = [
    {'iconPath': 'assets/menu/today.png', 'label': 'Өнөөдөр'},
    {'iconPath': 'assets/menu/month.png', 'label': 'Сар'},
    {'iconPath': 'assets/menu/orduud.png', 'label': 'Ордууд'},
    {'iconPath': 'assets/menu/hoslol.png', 'label': 'Хослол'},
    {'iconPath': 'assets/menu/profile.png', 'label': 'Профайл'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Zodiac Image
              CircleAvatar(
                radius: 50,
                backgroundColor: Color(0xFFF8B9FF),
                child: Image.asset(
                  'assets/cancer.png', // Your zodiac symbol here
                  width: 60,
                  height: 60,
                ),
              ),
              SizedBox(height: 16),
              // Zodiac Title and Gender
              Text(
                'Мэлхий орд',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.female,
                    color: Color(0xFFF8B9FF),
                    size: 18,
                  ),
                  SizedBox(width: 8),
                  Text(
                    '♀',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xFFF8B9FF),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              // Profile Details
              _buildProfileInfo('Нэр:', 'Jargal'),
              _buildProfileInfo('Төрсөн он сар өдөр:', '2004.07.00'),
              _buildProfileInfo('Утасы дугаар:', '99991111'),
              _buildProfileInfo('Нууц үг:', '*****'),
              SizedBox(height: 20),
              // Zodiac Info (All inside one box)
              _buildZodiacInfoBox(),
              SizedBox(height: 20),
              // Bottom Navigation Bar
              _buildBottomNavBar(),
            ],
          ),
        ),
      ),
    );
  }

  // Method for creating individual profile info entries
  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF8B9FF),
            ),
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Method to build the zodiac info inside one box
  Widget _buildZodiacInfoBox() {
    return Container(
      padding: EdgeInsets.all(12), // Padding inside the box
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), // Rounded corners
        border: Border.all(color: Color(0xFFF8B9FF), width: 2), // Pink border
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileInfo('Элемент:', 'Ус'),
          _buildProfileInfo('Ивээл чулуу:', 'Бадмаараг'),
          _buildProfileInfo('Азын:', '2, 3, 15, 20'),
          _buildProfileInfo('Гараг:', 'Сар'),
          _buildProfileInfo('Зен совин, сэтгэл хөдлөлийн удирдагч:', 'Сар'),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF8B9FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: navItems
            .map((item) =>
                _buildBottomNavItem(item['iconPath']!, item['label']!))
            .toList(),
      ),
    );
  }

  Widget _buildBottomNavItem(String iconPath, String label) {
    return GestureDetector(
      onTap: () {
        // Handle navigation
      },
      child: Column(
        children: [
          Image.asset(
            iconPath,
            width: 30,
            height: 30,
          ),
          SizedBox(height: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
