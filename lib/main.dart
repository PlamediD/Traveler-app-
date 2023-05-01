
//  Main written by Plamedi
// It includes the trip registration feature.
// It has a little + icon on the bottom right that they user can click to register a new trip.
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'trip_list.dart';
import 'forms.dart';

void main() {
  runApp(const MyApp());
}

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, _) => MyHomePage(title: 'Trip Planner',),
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TripProvider(),
      child: MaterialApp.router(
        title: 'Trip Planner',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        routerConfig: router,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _addTrip() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Forms()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: TripList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrip,
        tooltip: 'Add Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}

