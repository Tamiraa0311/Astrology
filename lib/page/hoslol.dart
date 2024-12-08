import 'package:flutter/material.dart';

void main() {
  runApp(const ZodiacApp());
}

class ZodiacApp extends StatelessWidget {
  const ZodiacApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Зурхайн хослол',
      theme: ThemeData(
        useMaterial3: false, // Material 3-г идэвхгүй болгоно
        scaffoldBackgroundColor: const Color(0xFF0C0E2F),
      ),
      home: const MatchPage(),
    );
  }
}

// Match Page
class MatchPage extends StatefulWidget {
  const MatchPage({super.key});

  @override
  State<MatchPage> createState() => _MatchPageState();
}

class _MatchPageState extends State<MatchPage> {
  Zodiac? selectedZodiac1;
  Zodiac? selectedZodiac2;

  final List<Zodiac> zodiacs = [
    Zodiac(name: 'Хонь', imagePath: 'assets/aries.png', compatibility: 'Хонь болон үхэр маш сайн таардаг. Хамгийн шийдвэртэй хүчтэй, найдвартай холбоо. Авууштай нь хонь өөрийн үхрээ хөдлөх л юм бол уяж зогсоож амждаг. Хонь үнэнч, шударга, тусархуу байсан ч энэ нь ховор тохиолдол. Хонь буцалж бургилж байхад үхэр тайван суудаг. Энэ нь хонинд хамгийн сайн эм болж өгдөг. Сэтгэл санааны нийлэмжээрээ учирдаг хосууд. Үхрийн өөрийнхөөрөө зүтгэдэг зан, уян биш байдал эмэгтэй хонийг бухимдуулна. Тэдний бэлгийн харьцаанд ямар ч асуудал байхгүй. Үхэр хонь 30 нас хүрснээсээ хойш учирвал илүү таатай.'),
    Zodiac(name: 'Үхэр', imagePath: 'assets/taurus.png', compatibility: 'Үхэр болон ихэр тохиромж багатай. ...'),
    Zodiac(name: 'Ихэр', imagePath: 'assets/gemini.png', compatibility: 'Ихэр болон мэлхий дундаж таарамжтай. ...'),
    Zodiac(name: 'Мэлхий', imagePath: 'assets/cancer.png', compatibility: 'Мэлхий болон арслан гайхалтай зохицдог. ...'),
    Zodiac(name: 'Арслан', imagePath: 'assets/leo.png', compatibility: 'Арслан болон охин таардаггүй. ...'),
    Zodiac(name: 'Охин', imagePath: 'assets/virgo.png', compatibility: 'Охин болон жинлүүр эв найртай. ...'),
    Zodiac(name: 'Жинлүүр', imagePath: 'assets/libra.png', compatibility: 'Жинлүүр болон хилэнц дундаж. ...'),
    Zodiac(name: 'Хилэнц', imagePath: 'assets/scorpio.png', compatibility: 'Хилэнц болон нум сайн зохицно. ...'),
    Zodiac(name: 'Нум', imagePath: 'assets/sagittarius.png', compatibility: 'Нум болон матар сайхан хослол. ...'),
    Zodiac(name: 'Матар', imagePath: 'assets/capricorn.png', compatibility: 'Матар болон хумх таардаггүй. ...'),
    Zodiac(name: 'Хумх', imagePath: 'assets/aquarius.png', compatibility: 'Хумх болон загас гайхалтай хос. ...'),
    Zodiac(name: 'Загас', imagePath: 'assets/pisces.png', compatibility: 'Загас болон хонь маш сайн таарна. ...'),
  ];

  void selectZodiac(Zodiac zodiac) {
    setState(() {
      if (selectedZodiac1 == null) {
        selectedZodiac1 = zodiac;
      } else if (selectedZodiac2 == null && selectedZodiac1 != zodiac) {
        selectedZodiac2 = zodiac;
      } else if (selectedZodiac1 == zodiac) {
        selectedZodiac1 = null;
      } else if (selectedZodiac2 == zodiac) {
        selectedZodiac2 = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Зурхайн Хослол'),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          // Display selected Zodiac images
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFF4B0F9),
                child: selectedZodiac1 != null
                    ? Image.asset(selectedZodiac1!.imagePath, fit: BoxFit.contain)
                    : null,
              ),
              const SizedBox(width: 16),
              const Text('+', style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 24)),
              const SizedBox(width: 16),
              CircleAvatar(
                radius: 40,
                backgroundColor: const Color(0xFFF4B0F9),
                child: selectedZodiac2 != null
                    ? Image.asset(selectedZodiac2!.imagePath, fit: BoxFit.contain)
                    : null,
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Button to show compatibility
          ElevatedButton(
            onPressed: selectedZodiac1 != null && selectedZodiac2 != null
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CompatibilityPage(
                          zodiac1: selectedZodiac1!,
                          zodiac2: selectedZodiac2!,
                        ),
                      ),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF4B0F9),
              foregroundColor: const Color(0xFFFFFFFF),
            ),
            child: const Text('Хослол'),
          ),
          const SizedBox(height: 16),
          // Zodiac Selector Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: zodiacs.length,
              itemBuilder: (context, index) {
                final zodiac = zodiacs[index];
                return GestureDetector(
                  onTap: () => selectZodiac(zodiac),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: selectedZodiac1 == zodiac || selectedZodiac2 == zodiac
                            ? const Color(0xFFF4B0F9)
                            : const Color(0xFF0C0E2F),
                        child: Image.asset(zodiac.imagePath, fit: BoxFit.contain),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        zodiac.name,
                        style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 14),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Zodiac Model
class Zodiac {
  final String name;
  final String imagePath;
  final String compatibility;

  Zodiac({
    required this.name,
    required this.imagePath,
    required this.compatibility,
  });
}

// Compatibility Page
class CompatibilityPage extends StatelessWidget {
  final Zodiac zodiac1;
  final Zodiac zodiac2;

  const CompatibilityPage({super.key, required this.zodiac1, required this.zodiac2});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Таарамжийн мэдээлэл'),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '${zodiac1.name} болон ${zodiac2.name}',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              zodiac1.compatibility,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Text(
              zodiac2.compatibility,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
