import 'package:flutter/material.dart';
import 'object_models.dart';
import 'package:provider/provider.dart';
import 'budget_tracker.dart';

class TripProvider extends ChangeNotifier {
  final List<Trip> _trips = [];

  List<Trip> get trips => _trips;
  final List <Expense>_expenses=[];
  List <Expense> get expenses=>_expenses;

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
      checkIn: newCheckInDate,
      checkOut: newCheckOutDate,
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


  void addExpense(Trip trip, String category, int amount) {
    final expense = Expense(category: category, amount: amount);
    trip.expenses ??= [];
    trip.expenses!.add(expense);
    notifyListeners();
  }
  void removeExpense(Trip trip, String category, int amount) {
    final expense = Expense(category: category, amount: amount);
    trip.expenses ??= [];
    trip.expenses!.remove(expense);
    notifyListeners();
  }

  void modifyExpense(Trip trip, String category, int newAmount) {
    if (trip.expenses != null) {
      for (int i = 0; i < trip.expenses!.length; i++) {
        if (trip.expenses![i].category == category) {
          trip.expenses![i].amount = newAmount;
          break;
        }
      }
      notifyListeners();
    }
  }


  int getRemainingBudget(Trip trip) {
    int totalExpenses = 0;
    trip.expenses?.forEach((expense) {
      totalExpenses += expense.amount;
    });

    return trip.budget - totalExpenses;
  }

  List<Expense> getAllExpenses(Trip trip) {
    return trip.expenses ?? [];
  }


}
