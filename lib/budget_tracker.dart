import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';


class BudgetTracker extends StatefulWidget {
  final Trip selectedTrip;

  BudgetTracker({required this.selectedTrip});

  @override
  _BudgetTrackerState createState() => _BudgetTrackerState();
}

class _BudgetTrackerState extends State<BudgetTracker> {
  TextEditingController _expenseCategoryController = TextEditingController();
  TextEditingController _expenseAmountController = TextEditingController();

  @override
  void dispose() {
    _expenseCategoryController.dispose();
    _expenseAmountController.dispose();
    super.dispose();
  }

  void removeExpense(Expense expense) {
    context.read<TripProvider>().removeExpense(widget.selectedTrip, expense.category);

  }

  void modifyExpense(Expense expense, int newAmount) {
    context.read<TripProvider>().modifyExpense(widget.selectedTrip, expense.category, newAmount);
  }


  @override
  Widget build(BuildContext context) {
    final tripProvider = context.watch<TripProvider>();

    int remainingBudget = tripProvider.getRemainingBudget(widget.selectedTrip);
    int originalBudget = widget.selectedTrip.budget;
    List<Expense> expenses = tripProvider.getAllExpenses(widget.selectedTrip);



    return Scaffold(
      appBar: AppBar(
        title: Text('Budget Tracker'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Expenses',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: expenses.length,
                itemBuilder: (BuildContext context, int index) {
                  final expense = expenses[index];
                  return ListTile(
                    title: Text(expense.category),
                    subtitle: Text('Amount: ${expense.amount}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                TextEditingController controller =
                                TextEditingController(text: expense.amount.toString());
                                return AlertDialog(
                                  title: Text('Modify Expense'),
                                  content: TextField(
                                    controller: controller,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      labelText: 'Amount',
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        int newAmount = int.tryParse(controller.text) ?? 0;
                                        if (newAmount > 0) {
                                          modifyExpense(expense, newAmount);
                                          Navigator.of(context).pop();
                                        }
                                      },
                                      child: Text('Save'),
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
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeExpense(expense);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 16.0),
              Text(
                'Original Budget: ',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('    ~$originalBudget dollars', style: TextStyle(fontSize: 18)),
              Text(
                'Remaining Budget:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text('    ~$remainingBudget dollars', style: TextStyle(fontSize: 18, color: Colors.red)),
              SizedBox(height: 16.0),
              Text(
                'Register New Expense',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _expenseCategoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                ),
              ),
              SizedBox(height: 8.0),
              TextField(
                controller: _expenseAmountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  String category = _expenseCategoryController.text;
                  int amount = int.tryParse(_expenseAmountController.text) ?? 0;

                  if (category.isNotEmpty && amount > 0) {
                    tripProvider.addExpense(widget.selectedTrip, category, amount);
                    _expenseCategoryController.clear();
                    _expenseAmountController.clear();
                  }
                },
                child: Text('Add Expense'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
