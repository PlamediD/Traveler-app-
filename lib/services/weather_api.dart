import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class WeatherAPI {
  Future<Map<String, dynamic>?> getWeatherDataFromAPI(
      double lat, double lng) async {
    http.Response response;

    var baseUrl =
        "https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lng&appid=";
    const apikey = "f9ffe1343918d6bee2ebf2c76fc95778";
    final finalUrl = Uri.parse(baseUrl + apikey);

    try {
      response = await http.get(finalUrl);
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<Location?> getLocationByAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      return locations[0];
    } catch (e) {
      return null;
    }
  }

  Future<Placemark?> getPlaceMarkByLocation(double lat, double long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, long);
      return placemarks[0];
    } catch (e) {
      return null;
    }
  }
}
