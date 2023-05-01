// widget_test.dart
// Casey Nguyen
// PURPOSE: This file runs widget tests for our TravelApp.
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.
// 4.30.2023: Outlined proper tests for Milestone 1.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/main.dart';

main(){
  // TEST: Ensure that the app loads properly.
  // VERIFIER: The "Forms" button exists.
   testWidgets("The main page should open properly",
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

   // TEST: Ensure that the forms page opens properly.
   // EXPECT: Forms page information exists.
   testWidgets("The forms page should open",
           (WidgetTester tester) async{
         await tester.pumpWidget(
             const MaterialApp(
                 home: Scaffold(
                     body: MyApp()
                 )
             )
         );
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         expect(find.text("Trip Details:"), findsOneWidget);
         expect(find.text("Flight Info:"), findsOneWidget);
         expect(find.text("Hotel Info:"), findsOneWidget);
       });

   // TEST: Submitting with no input.
   // EXPECT: Remain on the forms page.
   testWidgets("Submitting with no input should keep user on forms page",
           (WidgetTester tester) async{
         await tester.pumpWidget(
             const MaterialApp(
                 home: Scaffold(
                     body: MyApp()
                 )
             )
         );
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         final submit = find.text("Submit");
         await tester.tap(submit);
         await tester.pumpAndSettle();
         expect(find.text("Trip Details:"), findsOneWidget);
         expect(find.text("Flight Info:"), findsOneWidget);
         expect(find.text("Hotel Info:"), findsOneWidget);
       });

   // TEST: Proper submission.
   testWidgets("User should be able to add a date using calendar picker",
   (WidgetTester tester) async{
     await tester.pumpWidget(
         const MaterialApp(
             home: Scaffold(
                 body: MyApp()
             )
         )
     );
     final nextPage = find.byIcon(Icons.add);
     await tester.tap(nextPage);
     await tester.pump();
     await tester.pump();
     // Let's enter all the strings first.

   });
}