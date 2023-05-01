

import 'package:flutter/material.dart';
import 'package:travel_app/TripProvidertest.dart';
import 'package:travel_app/object_models.dart';

class ModifyDialog extends StatefulWidget {
  final Trip trip;

  const ModifyDialog({Key? key, required this.trip}) : super(key: key);

  @override
  _ModifyDialogState createState() => _ModifyDialogState();
}

class _ModifyDialogState extends State<ModifyDialog> {
  late TextEditingController _checkInController;
  late TextEditingController _checkOutController;

  @override
  void initState() {
    super.initState();
    _checkInController =
        TextEditingController(text: widget.trip.hotel.checkIn.toString());
    _checkOutController =
        TextEditingController(text: widget.trip.hotel.checkOut.toString());
  }

  @override
  void dispose() {
    _checkInController.dispose();
    _checkOutController.dispose();
    super.dispose();
  }

  void _submitChanges() {
    final newCheckInDate = DateTime.parse(_checkInController.text);
    final newCheckOutDate = DateTime.parse(_checkOutController.text);
    TripProvider provider = TripProvider();
    provider.modifyHotel(widget.trip, newCheckInDate, newCheckOutDate);

    // Update the hotel information in the current widget state
    setState(() {
      widget.trip.hotel.checkIn = newCheckInDate;
      widget.trip.hotel.checkOut = newCheckOutDate;
    });

    Navigator.pop(context);
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Modify Hotel Info'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _checkInController,
            decoration: InputDecoration(
              labelText: 'Check-In Date (YYYY-MM-DD)',
            ),
          ),
          TextField(
            controller: _checkOutController,
            decoration: InputDecoration(
              labelText: 'Check-Out Date (YYYY-MM-DD)',
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitChanges,
          child: Text('Save Changes'),
        ),
      ],
    );
  }
}
