
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'TripProvidertest.dart';
import 'trip_list.dart';
import 'forms.dart';
import 'views/weather_view.dart';
import 'firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


// void main() {
//   runApp(MyApp());
// }
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //final collectionReference = FirebaseFirestore.instance.collection('events');

  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

final router = GoRouter(
  initialLocation: '/home',
  routes: [
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, _) => MyHomePage(
        title: 'Trip Planner',
      ),
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
  MyHomePage({Key? key, required this.title}) : super(key: key);

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
      //Make Changes here to add your own widgets
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const WeatherView(),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.all(14.0),
            child: Text(
              "Trips",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(child: TripList())
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTrip,
        tooltip: 'Add Trip',
        child: const Icon(Icons.add),
      ),
    );
  }
}

