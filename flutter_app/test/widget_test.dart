// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:fitness_app/main.dart';

void main() {
  testWidgets('Проверка запуска приложения', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that app starts correctly
    // Проверяем наличие хотя бы одного текста из приложения
    expect(find.text('Главная'), findsOneWidget);
    expect(find.text('Питание'), findsOneWidget);
    expect(find.text('Упражнения'), findsOneWidget);
    expect(find.text('Настройки'), findsOneWidget);
  });
}
