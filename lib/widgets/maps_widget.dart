import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

class DirectionsWidget extends StatefulWidget {
  @override
  _DirectionsWidgetState createState() => _DirectionsWidgetState();
}

class _DirectionsWidgetState extends State<DirectionsWidget> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  GoogleMapController? mapController;
  List<Marker> markers = [];
  String distance = '';
  String duration = '';
  Set<Polyline> mapPolylines = {};

  CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194), // Default camera position (San Francisco)
    zoom: 12,
  );

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _searchDirections() async {
    final String startLocation = startController.text;
    final String endLocation = endController.text;

    if (startLocation.isEmpty || endLocation.isEmpty) {
      // If either start or end location is empty, display an error message
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Please enter both start and end locations.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }
    // API key, will be deleted later to avoid getting charged for services
    final String apiKey = 'AIzaSyCim9vkA322LhQYZ5j1XI7PtemPC91ycMI';

    // Construct the API URL
    final String apiUrl =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$startLocation&destination=$endLocation&key=$apiKey';

    // Make the HTTP request
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> routes = data['routes'];
      if (routes.isNotEmpty) {
        final Map<String, dynamic> route = routes[0];
        final Map<String, dynamic> legs = route['legs'][0];

        final String distanceText = legs['distance']['text'];
        final String durationText = legs['duration']['text'];

        final LatLng startLatLng = LatLng(
          legs['start_location']['lat'],
          legs['start_location']['lng'],
        );
        final LatLng endLatLng = LatLng(
          legs['end_location']['lat'],
          legs['end_location']['lng'],
        );

        setState(() {
          markers = [
            Marker(
              markerId: MarkerId('start'),
              position: startLatLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
            ),
            Marker(
              markerId: MarkerId('end'),
              position: endLatLng,
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            ),
          ];
          distance = distanceText;
          duration = durationText;
        });

        // Move the camera to show both start and end locations
        final LatLngBounds bounds = LatLngBounds(
          southwest: LatLng(
            startLatLng.latitude < endLatLng.latitude ? startLatLng.latitude : endLatLng.latitude,
            startLatLng.longitude < endLatLng.longitude ? startLatLng.longitude : endLatLng.longitude,
          ),
          northeast: LatLng(
            startLatLng.latitude > endLatLng.latitude ? startLatLng.latitude : endLatLng.latitude,
            startLatLng.longitude > endLatLng.longitude ? startLatLng.longitude : endLatLng.longitude,
          ),
        );
        mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));

        // Draw the route path on the map
        final List<LatLng> routeCoordinates = _decodePolyline(route['overview_polyline']['points']);
        final Polyline routePolyline = Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: routeCoordinates,
          width: 5,
        );

        setState(() {
          mapPolylines.clear();
          mapPolylines.add(routePolyline);
        });
      } else {
        // No routes found
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No routes found.'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } else {
      // Error response
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to retrieve directions.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Directions'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                TextField(
                  controller: startController,
                  decoration: InputDecoration(
                    labelText: 'Start Location',
                  ),
                ),
                TextField(
                  controller: endController,
                  decoration: InputDecoration(
                    labelText: 'End Location',
                  ),
                ),
                ElevatedButton(
                  onPressed: _searchDirections,
                  child: Text('Search Directions'),
                ),
              ],
            ),
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              onMapCreated: _onMapCreated,
              markers: Set<Marker>.from(markers),
              polylines: mapPolylines,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text('Distance: $distance'),
                Text('Duration: $duration'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<LatLng> _decodePolyline(String encoded) {
  List<LatLng> polyLineList = [];
  int index = 0;
  int len = encoded.length;
  int lat = 0;
  int lng = 0;

  while (index < len) {
    int b;
    int shift = 0;
    int result = 0;

    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);

    int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lat += dlat;

    shift = 0;
    result = 0;

    do {
      b = encoded.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);

    int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    lng += dlng;

    LatLng point = LatLng(
      lat / 1e5,
      lng / 1e5,
    );
    polyLineList.add(point);
  }

  return polyLineList;
}