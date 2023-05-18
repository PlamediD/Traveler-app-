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

  void addExpense(String category, int amount) {
    final expense = Expense(category: category, amount: amount);
    expenses ??= []; // Initialize the list if it's null
    expenses!.add(expense);
    notifyListeners();

  }


  int getTotalExpenses() {
    if (expenses == null) {
      return 0;
    }

    return expenses!.fold(0, (sum, expense) => sum + expense.amount);
  }

  int getRemainingBudget() {

    return budget - getTotalExpenses();

  }

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
