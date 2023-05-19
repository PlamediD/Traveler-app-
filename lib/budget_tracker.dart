import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'object_models.dart';
import 'trip_list.dart';

class BudgetTrackingScreen extends StatelessWidget {
  final Trip trip;

  BudgetTrackingScreen({required this.trip});

  @override
  Widget build(BuildContext context) {
    final totalExpenses = trip.getTotalExpenses();
    final remainingBudget = trip.getRemainingBudget();

    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracking'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Expenses: $totalExpenses',
              style: TextStyle(fontSize: 16),
            ),
            Text(
              'Remaining Budget: $remainingBudget',
              style: TextStyle(fontSize: 16),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _showAddExpenseDialog(context);
              },
              icon: Icon(Icons.add),
              label: Text('Add expense'),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String category = '';
        int amount = 0;

        return AlertDialog(
          title: Text('Add Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Category'),
                onChanged: (value) {
                  category = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                onChanged: (value) {
                  amount = int.tryParse(value) ?? 0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                trip.addExpense(category, amount);

                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}