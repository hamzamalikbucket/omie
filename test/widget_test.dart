// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:youth_for_yoga/main.dart';

void main() {
  testWidgets('App loads welcome screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts with splash screen
    // Note: This test would need to be updated based on actual implementation
    // for now, we're just ensuring the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
