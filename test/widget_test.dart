// widget_test.dart
// Casey Nguyen
// PURPOSE: This file runs widget tests for our TravelApp.
// TESTING:
// - Time logic
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.
// 4.30.2023: Testing runs.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:travel_app/form_buttons.dart';
import 'package:travel_app/forms.dart';
import 'package:travel_app/main.dart';

main(){
  // EXPECT: Main menu runs.
   testWidgets("Check that the main menu runs",
   (WidgetTester tester) async{
     await tester.pumpWidget(
       const MaterialApp(
         home: Scaffold(
           body: MyApp()
         )
       )
     );
     expect(find.byIcon(Icons.add), findsOneWidget);
   });

   testWidgets("Check the forms page opens",
           (WidgetTester tester) async{
         await tester.pumpWidget(
             const MaterialApp(
                 home: Scaffold(
                     body: MyApp()
                 )
             )
         );
       });
}