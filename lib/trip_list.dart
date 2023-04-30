import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';
import 'package:intl/intl.dart';
import 'ModifyDialog.dart';


class TripList extends StatelessWidget {
  // final List<Trip> trips;
  // TripList({required this.trips});

  @override
  Widget build(BuildContext context) {
    final tripProvider = context.watch<TripProvider>();
    final trips = tripProvider.trips;
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
                  _showModifyDialog(context, trip);
                },
                icon: Icon(Icons.edit),
              ),

              IconButton(
                onPressed: (){ tripProvider.removeTrip(index);},
                icon: const Icon(Icons.delete_forever),
              )
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
                Text('Budget: ${trip.budget}'),
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

}
// This was for testing purposes
// class TripCard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final tripProvider = Provider.of<TripProvider>(context);
//     final trips = tripProvider.trips;
//
//     return ListView.builder(
//       itemCount: trips.length,
//       itemBuilder: (BuildContext context, int index) {
//         return Card(
//           child: Column(
//             children: [
//               Text(trips[index].destination),
//               Text(trips[index].start.toString()),
//               Text(trips[index].end.toString()),
//               Text(trips[index].flight.departure),
//               Text(trips[index].flight.arrival),
//               Text(trips[index].flight.flightNum),
//               Text(trips[index].hotel.roomNum.toString()),
//               Text(trips[index].budget.toString()),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
