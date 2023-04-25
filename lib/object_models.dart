class Trip {
  DateTime start;
  DateTime end;
  String destination;
  Flight flight;
  Hotel hotel;
  int budget;
  Trip({
    required this.start,
    required this.end,
    required this.destination,
    required this.flight,
    required this.hotel,
    required this.budget
  });
}
class Flight {
  String departure;
  String arrival;
  String flightNum;
  Flight({
    required this.departure,
    required this.arrival,
    required this.flightNum
  });
}

class Hotel{
  DateTime checkIn;
  DateTime checkOut;
  String roomNum;

  Hotel({
    required this.checkIn,
    required this.checkOut,
    required this.roomNum
  });
}