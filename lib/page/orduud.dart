import 'package:flutter/material.dart';

void main() {
  runApp(const ZodiacApp());
}

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
      home: const ZodiacPage(),
    );
  }
}

// Bottom Navigation Bar
class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NavItem> items = [
      NavItem(imagePath: 'assets/today.png', title: 'Өнөөдөр', page: const TodayPage()),
      NavItem(imagePath: 'assets/calendar.png', title: 'Сар', page: const CalendarPage()),
      NavItem(imagePath: 'assets/match.png', title: 'Хослол', page: const MatchPage()),
      NavItem(imagePath: 'assets/zodiac.png', title: 'Ордууд', page: const ZodiacPage()),
      NavItem(imagePath: 'assets/profile.png', title: 'Профайл', page: const ProfilePage()),
    ];

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
        color: Color(0xFFF4B0F9),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.map((item) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item.page),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color(0xFFF4B0F9),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(item.imagePath, fit: BoxFit.contain),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.title,
                  style: const TextStyle(color: Color(0xFFF4B0F9), fontSize: 14),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// Navigation Item Model
class NavItem {
  final String imagePath;
  final String title;
  final Widget page;

  NavItem({required this.imagePath, required this.title, required this.page});
}

// Zodiac Model
class Zodiac {
  final String imagePath;
  final String name;
  final String dateRange;
  final String description;

  Zodiac({
    required this.imagePath,
    required this.name,
    required this.dateRange,
    required this.description,
  });
}

// Zodiac Main Page
class ZodiacPage extends StatelessWidget {
  const ZodiacPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Zodiac> zodiacs = [
      Zodiac(
          imagePath: 'assets/aries.png',
          name: 'Хонь',
          dateRange: '3/21 - 4/19',
          description: 'Хонь – “Гал” махбодитой ордуудаас хамгийн гал цогтой нь юм. Хамгийн унтрашгүй ядрашгүй. Тэднийг анзаарахгүй байх аргагүй. Сэтгэлийн тэнхээ ихтэй, хувь хүмүүс. Хөөрүү дэгдэгнүүр зантай ихэнхдээ цочмог ууртай. Халуун цустай, тайлбар тавихад дурамжхан ханддаг. Хүмүүс тэдний халуун дотно элэгсэг харьцаанд татагддаг.'),
      Zodiac(
          imagePath: 'assets/taurus.png',
          name: 'Үхэр',
          dateRange: '4/20 - 5/20',
          description: 'Үхрийн ордод төрсөн хүмүүс ерөнхийдөө дуугуй, бие даасан, хариуцлагатай, даруу төлөв зантай. Зожиг. Зөрүүд. Бүдүүлэгдүү. Биеэ барих чадвар сайтай тул стрессд ордоггүй. Гэхдээ гэнэт уур нь хүрвэл замд дайралдсан бүгдийг арчаад өнгөрнө гэж мэд. Азаар энэ нь ховор тохиолддог. Үхэр тайван эсвэл уур хилэнд автана.'),
      Zodiac(
          imagePath: 'assets/gemini.png',
          name: 'Ихэр',
          dateRange: '5/21 - 6/20',
          description: 'Ихрийн орднынхоны нэг бол дулаан, нэг бол хүйтэн зан гаргадаг. Хамгийн хувирамтгай орд. Тэд өөрсдийнх нь эсрэг шүүмжлэл, элэглэл, доог тохууг зөнгөөрөө мэдэрч үл тоодог. Амьдралаа өөрийн хүсэл сонирхолд нийцүүлэхийг хичээдэг. Хэн нэгнээс шалтгаалж амьдрахыг хүсэхгүй.'),
      Zodiac(
          imagePath: 'assets/cancer.png',
          name: 'Мэлхий',
          dateRange: '6/21 - 7/22',
          description: 'Мэлхий бол Зодиакын хамгийн нууцлагдмал орд юм. Сарны нөлөө түүний араншин, мэдрэмж, зан аашийг шууд удирдана. Тэд нээлттэй бөгөөд мөрөөдөмтгий, тархи сайтай бөгөөд мэдрэмтгий хүмүүс. Орчин тойрныхондоо Мэлхий нь ойлгомжгүй, хачирхалтай хүн. Тэд мохошгүй энергитэй.'),
      Zodiac(
          imagePath: 'assets/leo.png',
          name: 'Арслан',
          dateRange: '7/23 - 8/22',
          description: 'Арслан орд нь удирдагч, өөртөө итгэлтэй, цогтой хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/virgo.png',
          name: 'Охин',
          dateRange: '8/23 - 9/22',
          description: 'Охин орд нь нарийн төвөгтэй, анхааралтай, ухаалаг хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/libra.png',
          name: 'Жинлүүр',
          dateRange: '9/23 - 10/22',
          description: 'Жинлүүр орд нь тэгшитгэл, шударга, эв нэгдлийг хүсэгч хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/scorpio.png',
          name: 'Хилэнц',
          dateRange: '10/23 - 11/21',
          description: 'Хилэнц орд нь хүчтэй, нууцлаг, шийдэмгий хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/sagittarius.png',
          name: 'Нум',
          dateRange: '11/22 - 12/21',
          description: 'Нум орд нь зоригтой, ачаалалтай, санал хүсэлтээр дүүрэн хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/capricorn.png',
          name: 'Матар',
          dateRange: '12/22 - 1/19',
          description: 'Матар орд нь хичээнгүй, төгс төгөлдөр хандлагатай хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/aquarius.png',
          name: 'Хумх',
          dateRange: '1/20 - 2/18',
          description: 'Хумх орд нь шинэлэг, өвөрмөц, уран бүтээлч хүмүүс байдаг.'),
      Zodiac(
          imagePath: 'assets/pisces.png',
          name: 'Загас',
          dateRange: '2/19 - 3/20',
          description: 'Загас орд нь мэдрэмтгий, уран сайхны мэдрэмжтэй хүмүүс байдаг.'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ордууд'),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: zodiacs.length,
          itemBuilder: (context, index) {
            return ZodiacTile(zodiac: zodiacs[index]);
          },
        ),
      ),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

// Zodiac Tile
class ZodiacTile extends StatelessWidget {
  final Zodiac zodiac;

  const ZodiacTile({required this.zodiac, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ZodiacDetailPage(zodiac: zodiac)),
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
                child: Image.asset(
                  zodiac.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            zodiac.name,
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
  final Zodiac zodiac;

  const ZodiacDetailPage({required this.zodiac, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(zodiac.name),
        backgroundColor: const Color(0xFFF4B0F9),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(zodiac.imagePath),
            const SizedBox(height: 16.0),
            Text(
              zodiac.dateRange,
              style: const TextStyle(fontSize: 18.0, color: Color(0xFFF4B0F9)),
            ),
            const SizedBox(height: 16.0),
            Text(
              zodiac.description,
              style: const TextStyle(fontSize: 16.0, color: Color(0xFFF4B0F9)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// Other Pages
class TodayPage extends StatelessWidget {
  const TodayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Өнөөдөр')),
      body: const Center(child: Text('Өнөөдрийн мэдээлэл.')),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сар')),
      body: const Center(child: Text('Сарын мэдээлэл.')),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class MatchPage extends StatelessWidget {
  const MatchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Хослол')),
      body: const Center(child: Text('Хослолын мэдээлэл.')),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Профайл')),
      body: const Center(child: Text('Профайл хуудас.')),
      bottomNavigationBar: const CustomBottomNav(),
    );
  }
}
