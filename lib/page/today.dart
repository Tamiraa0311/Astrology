import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jargal App',
      theme: ThemeData.dark(),
      home: MyCustomUI(),
    );
  }
}

class MyCustomUI extends StatefulWidget {
  @override
  _MyCustomUIState createState() => _MyCustomUIState();
}

class _MyCustomUIState extends State<MyCustomUI> {
  String selectedTab = "Өнөөдөр"; // Default tab is "Өнөөдөр"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section with "Jargal" inside a box of size 239x59
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 239, // Fixed width
                height: 59, // Fixed height
                padding: EdgeInsets.only(
                    left: 0,
                    right: 0,
                    top: 16,
                    bottom: 16), // No padding on the front side (left)
                decoration: BoxDecoration(
                  color: const Color(0xFFF8B9FF), // Background color of the box
                  borderRadius: BorderRadius.only(
                    topRight:
                        Radius.circular(12), // Only left side has border radius
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: Center(
                  // Center the text within the box
                  child: Text(
                    "Jargal",
                    style: TextStyle(
                      color: Colors.white, // Text color inside the box
                      fontSize: 24, // Adjusted font size for better fit
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            // Tab Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildTabItem("Өчигдөр"),
                  _buildTabItem("Өнөөдөр"),
                  _buildTabItem("Маргааш"),
                  _buildTabItem("Профайл"), // Added Profile Tab
                ],
              ),
            ),
            SizedBox(height: 20),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildTabItem(String label) {
    bool isActive = label == selectedTab;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTab = label;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 18,
          color: isActive ? const Color(0xFFF8B9FF) : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (selectedTab == "Өнөөдөр") {
      return _buildTodayContent();
    } else if (selectedTab == "Профайл") {
      return _buildProfileContent(); // Profile Content
    } else {
      return Center(
        child: Text(
          "$selectedTab цэсний агуулга",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }
  }

  Widget _buildTodayContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Message Box
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF8B9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            "Амьдралын зам үргэлж толигор байдаггүй ч бэрхшээл бүрийг давж доодох хүч, тэсвэрээ байнга танд байгааг санаарай.",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF0A0E21),
            ),
          ),
        ),
        SizedBox(height: 20),
        // Daily Plan Section
        Text(
          "Өдрийн төлөв",
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        _buildSliderRow("assets/money.png", "85", Colors.yellow),
        _buildSliderRow("assets/work.png", "70", Colors.orange),
        _buildSliderRow("assets/health.png", "90", Colors.pinkAccent),
        _buildSliderRow("assets/beauty.png", "70", Colors.orange),
        SizedBox(height: 20),
        // Other Details
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF8B9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem("Азын тоо:", "15"),
              SizedBox(height: 10),
              _buildDetailItem("Азтай цаг:", "12:40-17:40"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSliderRow(String iconPath, String value, Color color) {
    double parsedValue = double.tryParse(value) ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 30,
            height: 30,
          ),
          SizedBox(width: 10),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Slider(
              value: parsedValue,
              min: 0,
              max: 100,
              activeColor: color,
              inactiveColor: color.withOpacity(0.3),
              onChanged: (val) {
                setState(() {
                  // Update the value dynamically
                  parsedValue = val;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  // Profile Content
  Widget _buildProfileContent() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/profile.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Тамирын Жаргал',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Age: 28\nHobbies: Reading, Gaming, Music\nLocation: Ulaanbaatar',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    final navItems = [
      {'iconPath': 'assets/menu/today.png', 'label': 'Өнөөдөр'},
      {'iconPath': 'assets/menu/month.png', 'label': 'Сар'},
      {'iconPath': 'assets/menu/orduud.png', 'label': 'Ордууд'},
      {'iconPath': 'assets/menu/hoslol.png', 'label': 'Хослол'},
      {
        'iconPath': 'assets/menu/profile.png',
        'label': 'Профайл'
      }, // Profile Item
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFFF8B9FF),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: navItems
            .map((item) => IconButton(
                  icon: Image.asset(
                    item['iconPath']!,
                    width: 30,
                    height: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      selectedTab = item['label']!;
                    });
                  },
                ))
            .toList(),
      ),
    );
  }
}
