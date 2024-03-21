import 'package:counter_with_bloc/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("test if app works", () {
    testWidgets("testing counter increment and decrement",
        (widgetTester) async {
      await widgetTester.pumpWidget(const MyApp());

      expect(find.text("0"), findsOneWidget); //verify that we start at 0

      await widgetTester.tap(find.byIcon(Icons.add));

      await widgetTester.pump(); // pump next frame

      expect(find.text("1"),
          findsOneWidget); // verify that we incremented 1 up to 1.

      await widgetTester.tap(find.byIcon(Icons.remove));

      await widgetTester.pumpAndSettle();

      expect(
          find.text("0"), findsOneWidget); //verify we decremented 1 down to 0.
      for (int i = 0; i < 3; i++) {
        await widgetTester.tap(find.byIcon(Icons.add));
      }
      await widgetTester.pump();

      expect(find.byType(SnackBar),
          findsOneWidget); // check if we get snackbar
    });
  });
}
