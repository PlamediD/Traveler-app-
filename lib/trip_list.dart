import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';
import 'package:intl/intl.dart';
import 'ModifyDialog.dart';
import 'budget_tracker.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'packing_list_tracker.dart';



class TripList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final tripProvider = context.watch<TripProvider>();

    final trips = tripProvider.trips;


  /*
    List<Packing_List> packingList = tripProvider.getPackingList(3);
    print(packingList);
   */

    FirebaseService firebaseService = FirebaseService();



    return ListView.builder(
      itemCount: trips.length,
      itemBuilder: (BuildContext context, int index) {
        final trip = trips[index];
        final startDateFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.start);
        final endDateFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.end);

        return ListTile(
          title: Text(trip.destination),
          subtitle: Text('$startDateFormatted - $endDateFormatted'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    _showTripDetails(context, trip);
                  },
                  icon: const Icon(Icons.flight)
              ),


              IconButton(
                onPressed: () {
                  _showBudgetTracker(context, trip);
                },
                icon: Icon(Icons.account_balance_wallet),
              ),

              IconButton(
                onPressed: () {
                  _showPackingList(context, index);
                },
                icon: Icon(Icons.list),
              ),
              IconButton(
                onPressed: () {
                  _showModifyDialog(context, trip);
                },
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () {
                  _showDeleteConfirmation(context, index);
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showTripDetails(BuildContext context, Trip trip) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final startDateFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.start);
        final endDateFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.end);
        final checkInFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.hotel.checkIn);
        final checkOutFormatted = DateFormat('yyyy-MM-dd hh:mm a').format(trip.hotel.checkOut);

        return AlertDialog(
          title: Text(trip.destination),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Start Date: $startDateFormatted'),
                Text('End Date: $endDateFormatted'),
                Text('Budget: ${trip.budget} dollars'),
                Text('Flight:'),
                Text(' - Departure: ${trip.flight.departure}'),
                Text(' - Arrival: ${trip.flight.arrival}'),
                Text(' - Flight Number: ${trip.flight.flightNum}'),
                Text('Hotel:'),
                Text(' - Check-in: $checkInFormatted'),
                Text(' - Check-out: $checkOutFormatted'),
                Text(' - Room Number: ${trip.hotel.roomNum}'),




              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  void _showModifyDialog(BuildContext context, Trip trip) {
    showDialog(
      context: context,
      builder: (context) {
        return ModifyDialog(trip: trip);
      },
    );
  }


  void _showBudgetTracker(BuildContext context, Trip trip) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BudgetTracker(selectedTrip: trip),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int tripIndex) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Trip'),
          content: Text('Are you sure you want to delete this trip?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final tripProvider = Provider.of<TripProvider>(context, listen: false);
                tripProvider.removeTrip(tripIndex);
                Navigator.of(context).pop();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showPackingList(BuildContext context, int tripIndex) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PackingListTracker(tripIndex: tripIndex),
      ),
    );
  }



}          
