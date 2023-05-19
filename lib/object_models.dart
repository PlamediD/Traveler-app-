import 'package:flutter/cupertino.dart';

class Trip with ChangeNotifier{
  DateTime start;
  DateTime end;
  String destination;
  Flight flight;
  Hotel hotel;
  int budget;
  List<Expense> ?expenses;

  Trip({
    required this.start,
    required this.end,
    required this.destination,
    required this.flight,
    required this.hotel,
    required this.budget,
    this.expenses ,
  });



}

class Expense {
  String category;
  int amount;

  Expense({required this.category, required this.amount});
}

class Flight {
  String departure;
  String arrival;
  String flightNum;

  Flight({
    required this.departure,
    required this.arrival,
    required this.flightNum,
  });
}

class Hotel {
  DateTime checkIn;
  DateTime checkOut;
  int roomNum;

  Hotel({
    required this.checkIn,
    required this.checkOut,
    required this.roomNum,
  });
}
