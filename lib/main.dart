import 'package:flutter/material.dart';


import 'forms.dart';
void main() {
  runApp(const TravelApp());
}

class TravelApp extends StatelessWidget {
  const TravelApp({super.key, this.startTime});
  final DateTime? startTime;
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel App',
      home:Forms()
    );
  }
}
