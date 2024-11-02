// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:horoscope_app/main.dart';
import 'package:horoscope_app/page/startpage.dart';

void main() {
  testWidgets('Start widget is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(FlutterApp());

    // Verify that the Start widget is present.
    expect(find.byType(Start), findsOneWidget);
    expect(find.text('Зурхай'), findsOneWidget);
  });
}
