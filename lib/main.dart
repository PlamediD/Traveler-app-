// import 'package:flutter/material.dart';
//
//
// import 'forms.dart';
// void main() {
//   runApp(const TravelApp());
// }
//
// class TravelApp extends StatelessWidget {
//   const TravelApp({super.key, this.startTime});
//   final DateTime? startTime;
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Travel App',
//       home:Forms()
//     );
//   }
// }

//  Main written by Plamedi
// It includes the trip registration feature.
// It has a little + icon on the bottom right that they user can click to register a new trip.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'object_models.dart';
import 'trip_list.dart';
import 'forms.dart';

// void main() {
//   runApp(MyApp());
// }
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TripProvider>(create: (_) => TripProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'My Trips'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Trip> _trips = [
    Trip(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 7)),
        destination: 'New York',
        flight: Flight(
            departure: 'Boston',
            arrival: 'New York',
            flightNum: 'AA1234'),
        hotel: Hotel(
            checkIn: DateTime.now(),
            checkOut: DateTime.now().add(Duration(days: 7)),
            roomNum: 1),
        budget: 2000),
    Trip(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 10)),
        destination: 'San Francisco',
        flight: Flight(
            departure: 'Boston',
            arrival: 'San Francisco',
            flightNum: 'UA5678'),
        hotel: Hotel(
            checkIn: DateTime.now(),
            checkOut: DateTime.now().add(Duration(days: 10)),
            roomNum: 2),
        budget: 3000),
    Trip(
        start: DateTime.now(),
        end: DateTime.now().add(Duration(days: 14)),
        destination: 'London',
        flight: Flight(
            departure: 'Boston',
            arrival: 'London',
            flightNum: 'BA5678'),
        hotel: Hotel(
            checkIn: DateTime.now(),
            checkOut: DateTime.now().add(Duration(days: 14)),
            roomNum: 2),
        budget: 5000),
  ];

  void _addTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Forms()),
    ).then((newTrip) {
      if (newTrip != null) {
        setState(() {
          _trips.add(newTrip);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: TripList(trips: _trips),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrip,
        tooltip: 'Add Trip',
        child: Icon(Icons.add),
      ),
    );
  }
}

