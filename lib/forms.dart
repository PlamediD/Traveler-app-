import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'form_buttons.dart';
class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  State<Forms> createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final formKey = GlobalKey<FormState>();
  DateTime? _flightStartTime, _flightEndTime, _checkIn,_checkOut;
  TextEditingController _Destination = TextEditingController();
  TextEditingController _departure = TextEditingController();
  TextEditingController _arrival = TextEditingController();
  TextEditingController _flightNum = TextEditingController();
  TextEditingController _roomNum = TextEditingController();
  int currIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Travel Form')
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key:formKey,
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text("Trip Details:", style: TextStyle(fontSize: 25),),
                InkWell(
                  onTap: () async{
                    DateTime? startTime = await pickDateTime(context);
                    if(startTime != null){
                      _flightStartTime = startTime;
                      setState(() {});
                    }
                  },
                  child: StartTimeButton(startTime: _flightStartTime),
                ),
                InkWell(
                  onTap: () async{
                    DateTime? endTime = await pickDateTime(context);
                    if(endTime != null){
                      _flightEndTime = endTime;
                      setState(() {});
                    }
                  },
                  child: EndTimeButton(startTime: _flightStartTime, endTime: _flightEndTime),
                ),
                StringInputButton(textInput:_Destination, labelText: "Destination",),
                FlightInfo(departure: _departure, arrival: _arrival, flightNum: _flightNum),
                Text(
                  "Hotel Info:",
                  style: TextStyle(fontSize: 25),
                ),
                InkWell(
                  onTap: () async{
                    DateTime? startTime = await pickDateTime(context);
                    if(startTime != null){
                      _checkIn = startTime;
                      setState(() {});
                    }
                  },
                  child: StartTimeButton(startTime: _checkIn),
                ),
                InkWell(
                  onTap: () async{
                    DateTime? endTime = await pickDateTime(context);
                    if(endTime != null){
                      _checkOut = endTime;
                      setState(() {});
                    }
                  },
                  child: EndTimeButton(startTime: _checkIn, endTime: _checkOut),
                ),
                StringInputButton(textInput:_roomNum, labelText: "Room Number",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FlightInfo extends StatelessWidget {
  const FlightInfo({super.key, required this.departure, required this.arrival, required this.flightNum});
  final TextEditingController departure;
  final TextEditingController arrival;
  final TextEditingController flightNum;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          "Flight Info:",
          style: TextStyle(fontSize: 25),
        ),
        StringInputButton(textInput: departure, labelText: "Departure",),
        StringInputButton(textInput: arrival, labelText: "Arrival",),
        StringInputButton(textInput: flightNum, labelText: "Flight Number",),
      ],
    );
  }
}

