import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';

class AddItemForm extends StatefulWidget {
  final int tripIndex;

  const AddItemForm({required this.tripIndex});

  @override
  _AddItemFormState createState() => _AddItemFormState();
}

class _AddItemFormState extends State<AddItemForm> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();

  @override
  void dispose() {
    _itemNameController.dispose();
    super.dispose();
  }

  void _addItem() {
    if (_formKey.currentState?.validate() == true) {
      final itemName = _itemNameController.text;

      if (itemName.isNotEmpty) {
        // Access the TripProvider using Provider.of<TripProvider>(context)
        final tripProvider = Provider.of<TripProvider>(context, listen: false);

        // Call the addPackingListItem method to add the item to the packing list
        tripProvider.addPackingListItem(widget.tripIndex, itemName);

        // Clear the text field
        _itemNameController.clear();

        // Close the form
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView( // Wrap with SingleChildScrollView
      child: AlertDialog(
        title: Text('Add Item to Packing List'),
        content: Form(
          key: _formKey,
          child: TextFormField(
            controller: _itemNameController,
            decoration: InputDecoration(
              labelText: 'Item Name',
            ),
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter the item name';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            child: Text('Add'),
            onPressed: _addItem,
          ),
        ],
      ),
    );
  }
}