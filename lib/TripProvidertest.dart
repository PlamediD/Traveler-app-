import 'dart:math';

import 'package:flutter/material.dart';
import 'object_models.dart';
import 'firebase.dart';


class TripProvider extends ChangeNotifier {
  late List<Trip> _trips = [];
  late List<Expense> _expenses = [];




  List<Trip> get trips => _trips;
  List<Expense> get expenses => _expenses;




  final FirebaseService _firebaseService = FirebaseService();
  TripProvider(){
    _trips=[];
    _expenses=[];

    fetchTrips();

  }


  Future<void> fetchTrips() async {
    try {
      List<Trip> fetchedTrips = await _firebaseService.getTrips();
      _trips.clear();
      _trips.addAll(fetchedTrips);
      notifyListeners();
    } catch (error) {
      // Handle error, such as showing an error message
      print('Error fetching trips: $error');
    }
  }

  List<Packing_List> getPackingList(int index) {
    if (index >= 0 && index < _trips.length) {

      return _trips[index].packing_list ?? [];
    }
    else {
      throw Exception('Invalid trip index');
    }
  }
  void addTrip(
      Trip newTrip, {
        required DateTime start,
        required DateTime end,
        required String destination,
        required Flight flight,
        required Hotel hotel,
        required int budget,
      }) async {
    final trip = Trip(
      start: start,
      end: end,
      destination: destination,
      flight: flight,
      hotel: hotel,
      budget: budget,
    );

    try {
      await _firebaseService.addTrip(trip);

      // Fetch the updated list of trips from Firebase
      List<Trip> fetchedTrips = await _firebaseService.getTrips();

      // Update the local _trips list with the fetched trips
      _trips.clear();
      _trips.addAll(fetchedTrips);
      notifyListeners();
    } catch (error) {
      // Handle error, such as showing an error message
      print('Error adding trip: $error');
    }
  }

  Trip getTripByIndex(int index) {
    if (index >= 0 && index < _trips.length) {
      final trip = _trips[index];


      return trip;
    } else {
      throw Exception('Invalid trip index');
    }
  }

  void removeTrip(int index){
    _firebaseService.deleteTrip(getTripByIndex(index));
    _trips.removeAt(index);
    notifyListeners();
  }


  void modifyHotel(Trip trip, DateTime newCheckInDate, DateTime newCheckOutDate) async {
    await _firebaseService.modifyHotel(trip, newCheckInDate, newCheckOutDate);

    final index = _trips.indexWhere((t) => t == trip);
    if (index >= 0) {
      final newHotel = Hotel(
        checkIn: newCheckInDate,
        checkOut: newCheckOutDate,
        roomNum: trip.hotel.roomNum,
      );

      _trips[index] = Trip(
        start: trip.start,
        end: trip.end,
        destination: trip.destination,
        flight: trip.flight,
        hotel: newHotel,
        budget: trip.budget,
        expenses: trip.expenses,

      );
      notifyListeners();
    }
  }


  int get tripsLength => _trips.length;

  void addExpense(Trip trip, String category, int amount) async {
    final expense = Expense(category: category, amount: amount);
    trip.expenses ??= [];
    trip.expenses!.add(expense);

    await _firebaseService.updateTrip(trip); // Update the trip in Firebase

    notifyListeners();
  }

  void modifyExpense(Trip trip, String category, int newAmount) {
    final expense = trip.expenses?.firstWhere((expense) => expense.category == category);
    if (expense != null) {
      expense.amount = newAmount;
      _firebaseService.updateTrip(trip); // Update the trip in Firebase
      notifyListeners();
    }
  }


  void removeExpense(Trip trip, String category) {
    trip.expenses?.removeWhere((expense) => expense.category == category);
    _firebaseService.updateTrip(trip); // Update the trip in Firebase
    notifyListeners();
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


  void updatePackingItem(Trip trip, int index, bool isPacked) async {
    await _firebaseService.updatePackingItem(trip, index, isPacked);

    final tripIndex = _trips.indexWhere((t) => t == trip);
    if (tripIndex >= 0) {
      final packingList = getPackingList(tripIndex);
      if (index >= 0 && index < packingList.length) {
        packingList[index].isPacked = isPacked;
        notifyListeners();
      }
    }
  }

  Future<void> addPackingListItem(int tripIndex, String itemToPack) async {
    if (tripIndex >= 0 && tripIndex < _trips.length) {
      final trip = _trips[tripIndex];
      await _firebaseService.addPackingListItem(trip, itemToPack);
      notifyListeners();
    } else {
      throw Exception('Invalid trip index');
    }
  }

}
