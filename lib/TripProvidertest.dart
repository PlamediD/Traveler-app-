import 'package:flutter/material.dart';
import 'object_models.dart';

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

  int get tripsLength => _trips.length;

}
