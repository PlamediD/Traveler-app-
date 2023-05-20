// widget_test.dart
// Casey Nguyen
// PURPOSE: This file runs widget tests for our TravelApp.
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.
// 4.30.2023: Outlined proper tests for Milestone 1.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/TripProvidertest.dart';
import 'package:travel_app/budget_tracker.dart';
import 'package:travel_app/main.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/object_models.dart';


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
         // Attempt to navigate to the next page.
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         // Expect to find the main details of the forms page.
         expect(find.text("Trip Details:"), findsOneWidget);
         expect(find.text("Flight Info:"), findsOneWidget);
         expect(find.text("Hotel Info:"), findsOneWidget);
       });

   // TEST: Ensure that the back button works
   // EXPECT: Return to main page.
   testWidgets("User should be able to go back to the first page",
           (WidgetTester tester) async{
         await tester.pumpWidget(
             const MaterialApp(
                 home: Scaffold(
                     body: MyApp()
                 )
             )
         );
         // Navigate to the forms page.
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         // Attempt to navigate backwards.
         final backPage = find.byIcon(Icons.arrow_back);
         await tester.tap(backPage);
         await tester.pumpAndSettle();
         // Expect to find the title of the app bar.
         expect(find.text("Trip Planner"), findsOneWidget);
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
         // Navigate to the forms page.
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         // Attempt to submit.
         final submit = find.text("Submit");
         await tester.tap(submit);
         await tester.pumpAndSettle();
         // Expect to find the main details of the forms page.
         expect(find.text("Trip Details:"), findsOneWidget);
         expect(find.text("Flight Info:"), findsOneWidget);
         expect(find.text("Hotel Info:"), findsOneWidget);
       });

   // TEST: Submitting with incomplete input.
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
         // Navigate to the forms page.
         final nextPage = find.byIcon(Icons.add);
         await tester.tap(nextPage);
         await tester.pumpAndSettle();
         // Insert some dummy info.
         final textBox = find.byType(TextFormField).first;
         await tester.enterText(textBox, "Seattle");
         // Attempt to submit.
         final submit = find.text("Submit");
         await tester.tap(submit);
         await tester.pumpAndSettle();
         // Expect to find the main details of the forms page.
         expect(find.text("Trip Details:"), findsOneWidget);
         expect(find.text("Flight Info:"), findsOneWidget);
         expect(find.text("Hotel Info:"), findsOneWidget);
       });

   //Testing Search widget and weather widgets
   testWidgets("Search Widget Added", (WidgetTester tester) async {
     await tester.pumpWidget(const MaterialApp(home: Scaffold(body: MyApp())));
     expect(find.text("Location"), findsOneWidget);
   });

   testWidgets("Getting Weather Data for a location", (tester) async {
     await tester.pumpWidget(const MaterialApp(home: Scaffold(body: MyApp())));
     expect(find.text("Location"), findsOneWidget);
     final searchWidget = find.byKey(const ValueKey("searchWidget"));
     final searchIconButton = find.byKey(const ValueKey("searchIconButton"));
     await tester.enterText(searchWidget, "China");
     await tester.tap(searchIconButton);
     await tester.pumpAndSettle();
   });
}