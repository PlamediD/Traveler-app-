// widget_test.dart
// Casey Nguyen
// PURPOSE: This file runs widget tests for our TravelApp.
// TESTING:
// - Time logic
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/forms.dart';

main(){
  group("Incorrect time submission logic", (){
    testWidgets('If no dates are added, an error message appears',
            (WidgetTester tester) async {
          await tester.pumpWidget(
              const MaterialApp(
                  home: Scaffold(
                      body: Forms()
                  )
              )
          );
          final submit = find.text("Submit");
          await tester.tap(submit);
          await tester.pump();
          expect(find.text('Please select a start date and time'), findsOneWidget);
    });
    testWidgets('If start time exceeds end time, shoot an error.',
            (WidgetTester tester) async {
          await tester.pumpWidget(
              const MaterialApp(
                  home: Scaffold(
                      body: Forms()
                  )
              )
          );
          // Find our buttons
          final startButton = find.text("Start Time");
          final endButton = find.text("End Time");
          final submit = find.text("Submit");

          // Go through a datetime pick flow.
          await tester.tap(startButton);
          await tester.pump();
          final arrow = find.byIcon(Icons.arrow_forward_ios);
          await tester.tap(arrow);
          await tester.pump();
          final startPick = find.text("2");
          await tester.tap(startPick);
          await tester.pump();
          final ok = find.text("OK");

          await tester.tap(submit);
          await tester.pump();
          expect(find.text('Please select a start date and time'), findsOneWidget);
        });
  });
}