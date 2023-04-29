// unit_test.dart
// Casey Nguyen
// PURPOSE: This file runs unit tests for our TravelApp.
// TESTING:
// - Time logic
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.

// Imports
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/object_models.dart';

// Main
main(){
  group("Trip Logic:", (){
    test("Adding a trip successfully", (){
      final goodFlight = Flight(arrival: "2023-01-01", departure: "2023-01-07",
          flightNum: "Waystar Royco 34");
      DateTime date1 = DateTime(2023, 01, 02);
      DateTime date2 = DateTime(2023, 01, 07);
      final goodHotel = Hotel(checkIn: date1, checkOut: date2, roomNum: 21);
      final goodTrip = Trip(start: date1, end: date2, destination: "Hawaii",
          flight: goodFlight, hotel: goodHotel, budget: 500);
      List<Trip> test = [];
      test.add(goodTrip);
      expect(test.isNotEmpty, true);
    });
  });
}