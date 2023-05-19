// unit_test.dart
// Haonan Wang
// PURPOSE: This file runs unit tests for our TravelApp.
//
// HISTORY
// 4.29.2023: Tests outlined based on current master.

// Imports
import 'package:flutter_test/flutter_test.dart';
import 'package:travel_app/object_models.dart';

// Main
main(){
  group('Trip', ()
  {
    test('start date should be set correctly', () {
      final goodFlight = Flight(arrival: "2023-01-01", departure: "2023-01-07",
          flightNum: "Waystar Royco 34");
      DateTime date1 = DateTime.now();
      DateTime date2 = DateTime(2023, 10, 07);
      final goodHotel = Hotel(checkIn: date1, checkOut: date2, roomNum: 21);
      final goodTrip = Trip(start: date1,
          end: date2,
          destination: "Hawaii",
          flight: goodFlight,
          hotel: goodHotel,
          budget: 500);
      expect(goodTrip.start, date1);
    });
    test('end date should be set correctly', () {
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
          budget: 500);
      expect(goodTrip.end, date2);
    });
    test('hotel should be set correctly', () {
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
          budget: 500);
      expect(goodTrip.hotel.roomNum, 21);
    });
      test('destination should be set correctly', () {
        final goodFlight = Flight(
            arrival: "2023-01-01", departure: "2023-01-07",
            flightNum: "Waystar Royco 34");
        DateTime date2 = DateTime.now();
        DateTime date1 = DateTime(2023, 01, 07);
        final goodHotel = Hotel(checkIn: date1, checkOut: date2, roomNum: 21);
        final goodTrip = Trip(start: date1,
            end: date2,
            destination: "Hawaii",
            flight: goodFlight,
            hotel: goodHotel,
            budget: 500);
        expect(goodTrip.destination, 'Hawaii');
    });
    test('flight should be set correctly', () {
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
          budget: 500);
      expect(goodTrip.flight.flightNum, "Waystar Royco 34");
    });
  });
}