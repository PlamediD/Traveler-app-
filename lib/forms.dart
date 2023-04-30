import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'TripProvidertest.dart';
import 'form_buttons.dart';
import 'object_models.dart';
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
  TextEditingController _budget = TextEditingController();
  int currIndex = -1;

  @override
  Widget build(BuildContext context) {
    final tripProvider = Provider.of<TripProvider>(context, listen: false);
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
                StringInputButton(textInput:_budget, labelText: "Budget",),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ElevatedButton(onPressed:() {
                      Trip newTrip = Trip(
                        start: _flightStartTime!,
                        end: _flightEndTime!,
                        destination: _Destination.text,
                        flight: Flight(
                          departure: _departure.text,
                          arrival: _arrival.text,
                          flightNum: _flightNum.text,
                        ),
                        hotel: Hotel(
                          checkIn: _checkIn!,
                          checkOut: _checkOut!,
                          roomNum: int.parse(_roomNum.text),
                        ),
                        budget: int.parse(_budget.text),
                      );

                      // Add the new trip to the provider.
                      tripProvider.addTrip(newTrip, start: _flightStartTime!,
                          end: _flightEndTime!,
                          destination: _Destination.text,
                          flight: newTrip.flight,
                          hotel: newTrip.hotel,
                          budget: int.parse(_budget.text));
                      print('Trip was added. Have fun in ${_Destination.text}');

                      // Close the form and go back to the previous screen.
                      Navigator.pop(context);
                    }, child: Text('Submit'))
                  ],
                ),
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