import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

class MapPage extends StatefulWidget{
  const MapPage({Key? key}): super(key:key);
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body: GoogleMap(initialCameraPosition: CameraPosition(
          target: LatLng(0,0)))
    );
  }
}