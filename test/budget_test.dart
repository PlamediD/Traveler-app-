
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/TripProvidertest.dart';
import 'package:travel_app/budget_tracker.dart';
import 'package:travel_app/main.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/object_models.dart';

main(){
  group('BudgetTracker Widget Test', () {
    late TripProvider tripProvider;
    late Trip selectedTrip;

    //Setup function to setup variables for tests
    setUp(() {
      final goodFlight = Flight(arrival: "2023-01-01", departure: "2023-01-07",
          flightNum: "Waystar Royco 34");
      DateTime date2 = DateTime.now();
      DateTime date1 = DateTime(2023, 01, 07);
      final goodHotel = Hotel(checkIn: date1, checkOut: date2, roomNum: 21);
      final goodTrip = Trip(start: date1,
          end: date2,
          destination: "Hawaii",
          flight: goodFlight,
          hotel: goodHotel,
          budget: 1000);
      tripProvider = TripProvider();
      selectedTrip = goodTrip;
    });

    testWidgets('Adding expense updates the UI', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<TripProvider>.value(value: tripProvider),
          ],
          child: MaterialApp(
            home: BudgetTracker(selectedTrip: selectedTrip),
          ),
        ),
      );

      // Verify that the initial UI displays the correct budget information

      //finds the two widgets displaying the same Budget Amount
      expect(find.text('Original Budget: '), findsOneWidget);
      expect(find.text('    ~1000 dollars'), findsNWidgets(2));
      expect(find.text('Remaining Budget:'), findsOneWidget);
      expect(find.text('    ~1000 dollars'), findsNWidgets(2));


      // Add an expense
      await tester.enterText(find.byType(TextField).first, 'Food');
      await tester.enterText(find.byType(TextField).last, '50');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify that the expense is added and budget information is updated
      expect(find.text('Expenses'), findsOneWidget);
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Amount: 50'), findsOneWidget);
      expect(find.text('Remaining Budget:'), findsOneWidget);
      expect(find.text('    ~950 dollars'), findsOneWidget);
    }); // End of Add expense

    testWidgets('Modifying expense updates the UI', (WidgetTester tester) async {
      // Add an expense to the selected trip
      selectedTrip.expenses = [Expense(category: 'Food', amount: 50)];

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider<TripProvider>(
              create: (_) => tripProvider, // Create a new instance of TripProvider
            ),
          ],
          child: MaterialApp(
            home: Builder(
              builder: (context) => BudgetTracker(selectedTrip: selectedTrip),
            ),
          ),
        ),
      );

      // Verify that the initial UI displays the added expense
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Amount: 50'), findsOneWidget);

      // Modify the expense
      await tester.tap(find.byIcon(Icons.edit).first);
      await tester.pumpAndSettle();

      expect(find.text('Modify Expense'), findsOneWidget);
      expect(find.byType(TextField), findsWidgets);

      // Update the expense amount by tapping the "Save" button in the dialog
      await tester.enterText(find.byType(TextField).last, '100'); // Update the index of the TextField
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle(); // Wait for all animations and async tasks to complete

      // Verify that the expense is modified and budget information is updated
      expect(find.text('Food'), findsOneWidget);
      expect(find.text('Amount: 100'), findsOneWidget);
      expect(find.text('    ~900 dollars'), findsOneWidget);
    });// End of Modify expense

    testWidgets('Deleting expense updates the UI', (WidgetTester tester) async {
      // Add an expense to the selected trip
      selectedTrip.expenses = [Expense(category: 'Food', amount: 50)];

    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<TripProvider>.value(value: tripProvider),
        ],
        child: MaterialApp(
          home: BudgetTracker(selectedTrip: selectedTrip),
        ),
      ),
    );

    // Verify that the initial UI displays the added expense
    expect(find.text('Food'), findsOneWidget);
    expect(find.text('Amount: 50'), findsOneWidget);

    // Delete the expense
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pumpAndSettle();

    // Verify that the expense is deleted and budget information is updated
    expect(find.text('Food'), findsNothing);
    expect(find.text('Amount: 50'), findsNothing);
    expect(find.text('    ~1000 dollars'), findsNWidgets(2));
  }); // End of Delete expense

  }); // End of Group
}