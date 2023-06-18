// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:e_movie/config/services/injection.dart';
import 'package:e_movie/presentation/pages/home/home_view.dart';

void main() {
  setUp(() => configureDependencies());

  testWidgets('Find All Component', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));
    expect(find.text('Hello!'), findsOneWidget, reason: 'This is the title');
    expect(find.byType(TextField), findsOneWidget,
        reason: 'This is the TextField for Search');
    expect(find.byType(IconButton), findsOneWidget,
        reason: 'This is the Button for launch Search');

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder, 'Makassar');
    expect(find.text('Makassar'), findsOneWidget);
  });
}
