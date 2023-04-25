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
  DateTime? _flightStartTime;
  DateTime? _flightEndTime;
  DateTime? _checkIn;
  DateTime? _checkOut;
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
              children: [
                Text(
                  "Trip Details:",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height:20),
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
                SizedBox(height:20),
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
                SizedBox(height:20),
                StringInputButton(textInput:_Destination, labelText: "Destination",),
                SizedBox(height:20),
                Text(
                  "Flight Info:",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height:20),
                StringInputButton(textInput:_departure, labelText: "Departure",),
                SizedBox(height:20),
                StringInputButton(textInput:_arrival, labelText: "Arrival",),
                SizedBox(height:20),
                StringInputButton(textInput:_flightNum, labelText: "Flight Number",),
                SizedBox(height:20),
                Text(
                  "Hotel Info:",
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height:20),
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
                SizedBox(height:20),
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
                SizedBox(height:20),
                StringInputButton(textInput:_roomNum, labelText: "Room Number",),
                SizedBox(height:20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
