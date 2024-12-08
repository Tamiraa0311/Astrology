import 'package:flutter/material.dart';

class MyNavBarPage extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  MyNavBarPage({required this.selectedIndex, required this.onItemTapped});

  // List of items for the navigation bar
  final List<Map<String, String>> navItems = [
    {'iconPath': 'assets/menu/today.png', 'label': 'Өнөөдөр'},
    {'iconPath': 'assets/menu/month.png', 'label': 'Сар'},
    {'iconPath': 'assets/menu/orduud.png', 'label': 'Хослол'},
    {'iconPath': 'assets/menu/hoslol.png', 'label': 'Ордууд'},
    {'iconPath': 'assets/menu/profile.png', 'label': 'Профайл'},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      width: MediaQuery.of(context).size.width * 0.8, // 80% of the screen width
      decoration: BoxDecoration(
        color: Color(0xFFF8B9FF), // Background color of the navbar
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30), // Rounded top-left corner
          topRight: Radius.circular(30), // Rounded top-right corner
          bottomLeft: Radius.circular(30), // Rounded bottom-left corner
          bottomRight: Radius.circular(30), // Rounded bottom-right corner
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, -2),
            blurRadius: 6,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(navItems.length, (index) {
          final item = navItems[index];
          return _buildNavItem(
              context, item['iconPath']!, item['label']!, index);
        }),
      ),
    );
  }

  // Custom method to build navigation items
  Widget _buildNavItem(
      BuildContext context, String iconPath, String label, int index) {
    bool isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () {
        onItemTapped(index); // Update selected index

        // Handle navigation based on selected item
        if (index == 0) {
          // Navigate to "Сар" page (PlanetPage)
          Navigator.pushNamed(
              context, '/today'); // Change this route accordingly
        }
        if (index == 1) {
          // Navigate to "Хослол" page (GenderPage)
          Navigator.pushNamed(
              context, '/planet'); // Change this route accordingly
          // Add other navigation logic for other items as needed
        }
        if (index == 2) {
          Navigator.pushNamed(context, '/hoslol');
        }
        if (index == 3) {
          Navigator.pushNamed(context, '/orduud');
        }
        if (index == 4) {
          Navigator.pushNamed(context, '/profile');
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300), // Smooth transition for size
            width: isSelected ? 40 : 30, // Increase icon size when selected
            height: isSelected ? 40 : 30, // Increase icon size when selected
            child: Image.asset(
              iconPath,
              fit: BoxFit.contain, // Ensure the icon fits
            ),
          ),
          SizedBox(height: 6),
          AnimatedOpacity(
            duration:
                Duration(milliseconds: 300), // Smooth transition for opacity
            opacity: isSelected ? 1 : 0.7, // Change opacity when selected
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: isSelected
                    ? Color(0xFF0A0E21)
                    : Colors.black54, // Change color for selected item
              ),
            ),
          ),
        ],
      ),
    );
  }
}
