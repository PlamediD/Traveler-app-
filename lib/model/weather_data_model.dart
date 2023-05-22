import 'package:geocoding/geocoding.dart';
import 'classes/weather_data.dart';
import 'services/weather_api.dart';
import 'package:flutter/material.dart';

class WeatherDataModel extends ChangeNotifier {
  WeatherData? _weatherData;
  final WeatherAPI _weatherAPI = WeatherAPI();
  WeatherData? get weatherData => _weatherData;

  WeatherDataModel();
  Future<void> getWeatherData(String address) async {
    Location? location;
    Map<String, dynamic>? json;
    WeatherData? weatherData;
    Placemark? placemark;
    if (address != "") {
      location = await _weatherAPI.getLocationByAddress(address);
    }

    if (location != null) {
      placemark = await _weatherAPI.getPlaceMarkByLocation(
          location.latitude, location.longitude);
      json = await _weatherAPI.getWeatherDataFromAPI(
          location.latitude, location.longitude);
    }
    if (json != null) {
      weatherData = WeatherData.fromJson(json);
    }
    if (weatherData != null) {
      if (placemark != null) {
        if (placemark.locality!.isNotEmpty &&
            placemark.administrativeArea!.isNotEmpty) {
          weatherData.setAddress(
              '${placemark.locality}, ${placemark.administrativeArea}');
        } else if (placemark.administrativeArea!.isNotEmpty &&
            placemark.country!.isNotEmpty) {
          weatherData.setAddress(
              '${placemark.administrativeArea}, ${placemark.country}');
        } else if (placemark.country!.isNotEmpty) {
          weatherData.setAddress('${placemark.country}');
        } else {
          weatherData.setAddress(address);
        }
      } else {
        weatherData.setAddress(address);
      }

      _weatherData = weatherData;
    }

    notifyListeners();
  }
}
