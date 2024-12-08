import 'package:flutter/material.dart';
import '../navbar/navBar.dart'; // Import the navbar file

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
  int _selectedIndex = 0; // Track selected index for nav bar

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Container(
                width: 120,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFF8B9FF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                  ),
                ),
                child: const Center(
                  child: Text(
                    "Jargal",
                    style: TextStyle(
                      color: Color(0xFF0A0E21),
                      fontSize: 18,
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
                ],
              ),
            ),
            const SizedBox(height: 10),
            // Main Content
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: _buildContent(),
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Handle page navigation here
    // For example:
    // if (index == 0) {
    //   Navigator.pushNamed(context, '/today');
    // }
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
          fontSize: 14,
          color: isActive ? const Color(0xFFF8B9FF) : Colors.grey,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (selectedTab == "Өнөөдөр") {
      return _buildTodayContent();
    } else {
      return Center(
        child: Text(
          "$selectedTab цэсний агуулга",
          style: const TextStyle(color: Colors.white, fontSize: 14),
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
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8B9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Text(
            "Амьдралын зам үргэлж толигор байдаггүй ч бэрхшээл бүрийг давж доодох хүч, тэсвэрээ байнга танд байгааг санаарай.",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF0A0E21),
            ),
          ),
        ),
        const SizedBox(height: 12),
        // Daily Plan Section with adjusted padding for title
        Padding(
          padding: const EdgeInsets.only(top: 8), // Move title down
          child: const Text(
            "Өдрийн төлөв",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 5),
        // Sliders Grid
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 2, // Adjust aspect ratio for compact layout
          children: [
            _buildCustomSlider(
              title: "Мөнгө",
              value: 50,
              color: Colors.yellow,
            ),
            _buildCustomSlider(
              title: "Ажил",
              value: 70,
              color: Colors.orange,
            ),
            _buildCustomSlider(
              title: "Хайр дурлал",
              value: 90,
              color: Colors.pinkAccent,
            ),
            _buildCustomSlider(
              title: "Гэр бүл",
              value: 90,
              color: Colors.cyan,
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Lucky Numbers Section
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFF8B9FF),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailItem("Азын тоо:", "15"),
              const SizedBox(height: 8),
              _buildDetailItem("Азтай цаг:", "12:40-17:40"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCustomSlider({
    required String title,
    required int value,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Number Box
            Container(
              width: 40, // Smaller width
              height: 40, // Smaller height
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  value.toString(),
                  style: const TextStyle(
                    fontSize: 14, // Smaller font
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6), // Reduced spacing
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10), // Adjusted spacing
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12, // Smaller title font
                      color: Colors.white,
                    ),
                  ),
                  SliderTheme(
                    data: SliderThemeData(
                      thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                      trackHeight: 3, // Slimmer track
                    ),
                    child: Slider(
                      value: value.toDouble(),
                      min: 0,
                      max: 100,
                      activeColor: color,
                      inactiveColor: color.withOpacity(0.4),
                      onChanged: (newValue) {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
