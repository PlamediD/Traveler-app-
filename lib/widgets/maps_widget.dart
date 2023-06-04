import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

const LatLng currentLocation = LatLng(47.6062, 122.3321);

class MapPage extends StatefulWidget{
  const MapPage({Key? key}): super(key:key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  late GoogleMapController mapController;
  Map<String, Marker> _markers = {};
  addMarker(String id, LatLng location){
    var marker = Marker(
      markerId: MarkerId(id),
      position: location,
    );
    _markers[id] = marker;
    setState(() {});
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: GoogleMap(
          initialCameraPosition: const CameraPosition(
          target: currentLocation,
          zoom: 14),
        onMapCreated: (controller){
          mapController = controller;
          addMarker('test', currentLocation);
        },
        markers: _markers.values.toSet(),
      )
    );
  }
}