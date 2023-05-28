import 'package:cloud_firestore/cloud_firestore.dart';
import 'object_models.dart';


class FirebaseService {
  final CollectionReference _tripsCollection =
  FirebaseFirestore.instance.collection('trips');

  //To modify later
  List<Packing_List> defaultPackingList = [
    Packing_List(name: 'Sleepwear', isPacked: false),
    Packing_List(name: 'Underwear', isPacked: false),
    Packing_List(name: 'Shoes', isPacked: false),
    Packing_List(name: 'Soap', isPacked: false),
  ];

  Future<List<Trip>> getTrips() async {
    QuerySnapshot snapshot = await _tripsCollection.get();
    List<Trip> trips = [];

    for (QueryDocumentSnapshot document in snapshot.docs) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;


      Trip trip = Trip(
        start: data['start'].toDate(),
        end: data['end'].toDate(),
        destination: data['destination'],
        flight: Flight(
          departure: data['flight']['departure'],
          arrival: data['flight']['arrival'],
          flightNum: data['flight']['flightNum'],
        ),
        hotel: Hotel(
          checkIn: data['hotel']['checkIn'].toDate(),
          checkOut: data['hotel']['checkOut'].toDate(),
          roomNum: data['hotel']['roomNum'],
        ),
        budget: data['budget'],

        packing_list: (data['packing_list'] as List<dynamic>)
          ?.map((item)=>Packing_List(
            name: item['name'],
            isPacked: item['isPacked'])).toList(),
        expenses: (data['expenses'] as List<dynamic>?)
            ?.map((expense) => Expense(
          category: expense['category'],
          amount: expense['amount'],
        ))
            .toList(),

      );

      trips.add(trip);

    }
    return trips;
  }

  Future<void> addPackingListItem(Trip trip, String itemToPack) async {
    // Get the trip ID
    String? tripId = await _getTripId(trip);

    if (tripId != null) {
      // Retrieve the existing packing list
      List<Packing_List>? packingList = trip.packing_list;

      if (packingList == null) {
        packingList = [];
      }

      // Create a new packing list item
      Packing_List newItem = Packing_List(name: itemToPack, isPacked: false);

      // Add the new item to the packing list
      packingList.add(newItem);

      // Update the trip in the database
      await _tripsCollection.doc(tripId).update({
        'packing_list': packingList.map((item) => {
          'name': item.name,
          'isPacked': item.isPacked,
        }).toList(),
      });
    }
  }

  Future<void> addTrip(Trip trip) async {

    // Create the default packing list

    // Set the default packing list to the trip
    trip.packing_list = defaultPackingList;

    // Add the trip to Firestore
    await _tripsCollection.add({
      'start': trip.start,
      'end': trip.end,
      'destination': trip.destination,
      'flight': {
        'departure': trip.flight.departure,
        'arrival': trip.flight.arrival,
        'flightNum': trip.flight.flightNum,
      },
      'hotel': {
        'checkIn': trip.hotel.checkIn,
        'checkOut': trip.hotel.checkOut,
        'roomNum': trip.hotel.roomNum,
      },
      'budget': trip.budget,
      'expenses': trip.expenses?.map((expense) => {
        'category': expense.category,
        'amount': expense.amount,
      }).toList(),
      'packing_list': trip.packing_list?.map((item) => {
        'name': item.name,
        'isPacked': item.isPacked,
      }).toList(),
    });
  }

  Future<void> deleteTrip(Trip trip) async {
    String ?tripId = await _getTripId(trip);

    if (tripId != null) {
      await _tripsCollection.doc(tripId).delete();
    }
  }
  Future<List<Packing_List>> getPackingList(Trip trip) async {
    String? tripId = await _getTripId(trip);

    if (tripId != null) {
      DocumentSnapshot snapshot = await _tripsCollection.doc(tripId).get();
      Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;

      if (data != null && data.containsKey('packing_list')) {
        List<dynamic>? packingListData = data['packing_list'];

        if (packingListData != null) {
          List<Packing_List> packingList = packingListData.map((item) {
            return Packing_List(
              name: item['name'],
              isPacked: item['isPacked'],
            );
          }).toList();

          return packingList;
        }
      }
    }

    return [];
  }

  Future<void> modifyHotel(Trip trip, DateTime newCheckInDate, DateTime newCheckOutDate) async {
    String? tripId = await _getTripId(trip);

    if (tripId != null) {
      await _tripsCollection.doc(tripId).update({
        'hotel': {
          'checkIn': newCheckInDate,
          'checkOut': newCheckOutDate,
          'roomNum': trip.hotel.roomNum,
        },
      });
    }
  }

  Map<String, dynamic> _convertTripToMap(Trip trip) {
    return {
      'start': trip.start,
      'end': trip.end,
      'destination': trip.destination,
      'flight': {
        'departure': trip.flight.departure,
        'arrival': trip.flight.arrival,
        'flightNum': trip.flight.flightNum,
      },
      'hotel': {
        'checkIn': trip.hotel.checkIn,
        'checkOut': trip.hotel.checkOut,
        'roomNum': trip.hotel.roomNum,
      },
      'packing_list': trip.packing_list != null
          ? List<Map<String, dynamic>>.from(trip.packing_list!.map((item) => {
        'name': item.name,
        'isPacked': item.isPacked,
      }))
          : null,
      'budget': trip.budget,
      'expenses': trip.expenses?.map((expense) => {
        'category': expense.category,
        'amount': expense.amount,
      }).toList(),
    };
  }


  Future<void> updateTrip(Trip trip) async {
    String? tripId = await _getTripId(trip);

    if (tripId != null) {
      Map<String, dynamic> tripData = _convertTripToMap(trip);

      // Retrieve the existing packing list from the database
      DocumentSnapshot snapshot = await _tripsCollection.doc(tripId).get();
      Map<String, dynamic>? existingData = snapshot.data() as Map<String, dynamic>?;

      // Update the 'packing_list' key only if it exists in the existing data
      if (existingData != null && existingData.containsKey('packing_list')) {
        tripData['packing_list'] = existingData['packing_list'];
      }

      await _tripsCollection.doc(tripId).set(tripData);
    }
  }


  Future<String?> _getTripId(Trip trip) async {
    QuerySnapshot snapshot = await _tripsCollection
        .where('destination', isEqualTo: trip.destination)
        .where('start', isEqualTo: trip.start)
        .where('end', isEqualTo: trip.end)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first.id;
    }

    return null;
  }
  Future<void> updatePackingItem(Trip trip, int index, bool isPacked) async {
    String? tripId = await _getTripId(trip);

    if (tripId != null) {
      // Retrieve the existing packing list
      List<Packing_List>? packingList = trip.packing_list;

      if (packingList != null && index >= 0 && index < packingList.length) {
        // Update the isPacked value of the specified packing item
        packingList[index].isPacked = isPacked;

        // Update the trip in the database
        await _tripsCollection.doc(tripId).update({
          'packing_list': packingList.map((item) => {
            'name': item.name,
            'isPacked': item.isPacked,
          }).toList(),
        });
      }
    }
  }


}
