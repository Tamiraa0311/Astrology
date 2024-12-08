import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart'; // MongoDB package

// MongoDB connection setup
Future<List<Map<String, dynamic>>> fetchZodiacs() async {
  final db = await Db.create("mongodb://localhost:27017/zodiac_db");
  await db.open();
  var collection = db.collection('zodiacs');
  var zodiacs = await collection.find().toList();
  await db.close();
  return zodiacs;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ZodiacApp());
}

// Main Zodiac App
class ZodiacApp extends StatelessWidget {
  const ZodiacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zodiac Signs',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF7B3EB4)),
        scaffoldBackgroundColor: const Color(0xFF0C0E2F),
        useMaterial3: true,
      ),
      home: const ZodiacPage(), // Set ZodiacPage as the home page
    );
  }
}

// Zodiac Main Page
class ZodiacPage extends StatefulWidget {
  const ZodiacPage({super.key});

  @override
  _ZodiacPageState createState() => _ZodiacPageState();
}

class _ZodiacPageState extends State<ZodiacPage> {
  late Future<List<Map<String, dynamic>>> _zodiacs;

  @override
  void initState() {
    super.initState();
    _zodiacs = fetchZodiacs(); // Fetch data when the page loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ордууд'),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _zodiacs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          } else {
            // Data fetched successfully, show zodiac signs
            var zodiacs = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                ),
                itemCount: zodiacs.length,
                itemBuilder: (context, index) {
                  var zodiac = zodiacs[index];
                  return ZodiacTile(
                    imagePath: zodiac['imagePath'] ?? '',
                    name: zodiac['name'] ?? 'Unknown',
                    dateRange: zodiac['dateRange'] ?? '',
                    description: zodiac['description'] ?? '',
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

// Zodiac Tile
class ZodiacTile extends StatelessWidget {
  final String imagePath;
  final String name;
  final String dateRange;
  final String description;

  const ZodiacTile({
    required this.imagePath,
    required this.name,
    required this.dateRange,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ZodiacDetailPage(
              imagePath: imagePath,
              name: name,
              dateRange: dateRange,
              description: description,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0C0E2F),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Image.network(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFF4B0F9),
            ),
          ),
        ],
      ),
    );
  }
}

// Zodiac Detail Page
class ZodiacDetailPage extends StatelessWidget {
  final String imagePath;
  final String name;
  final String dateRange;
  final String description;

  const ZodiacDetailPage({
    required this.imagePath,
    required this.name,
    required this.dateRange,
    required this.description,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(imagePath),
            const SizedBox(height: 16.0),
            Text(
              dateRange,
              style: const TextStyle(fontSize: 18.0, color: Color(0xFFF4B0F9)),
            ),
            const SizedBox(height: 16.0),
            Text(
              description,
              style: const TextStyle(fontSize: 16.0, color: Color(0xFFF4B0F9)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
