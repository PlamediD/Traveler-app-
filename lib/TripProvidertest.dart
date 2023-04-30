import 'package:flutter/material.dart';
import 'object_models.dart';
import 'package:provider/provider.dart';

class TripProvider with ChangeNotifier {
  final List<Trip> _trips = [];

  List<Trip> get trips => _trips;

  void addTrip(Trip newTrip, {
    required DateTime start,
    required DateTime end,
    required String destination,
    required Flight flight,
    required Hotel hotel,
    required int budget,
  }) {
    final trip = Trip(
      start: start,
      end: end,
      destination: destination,
      flight: flight,
      hotel: hotel,
      budget: budget,
    );
    _trips.add(trip);
    notifyListeners();
  }

  void removeTrip(int index){
    _trips.removeAt(index);
    notifyListeners();
  }
  void modifyHotel(Trip trip, DateTime newCheckInDate, DateTime newCheckOutDate) {
    final hotel = trip.hotel;
    final newHotel = Hotel(
      checkIn: newCheckInDate ?? hotel.checkIn,
      checkOut: newCheckOutDate ?? hotel.checkOut,
      roomNum: hotel.roomNum,
    );
    final index = _trips.indexWhere((t) => t == trip);
    if (index >= 0) {
      _trips[index] = Trip(
        start: trip.start,
        end: trip.end,
        destination: trip.destination,
        flight: trip.flight,
        hotel: newHotel,
        budget: trip.budget,
      );
      notifyListeners();
    }
  }

  int get tripsLength => _trips.length;

}
