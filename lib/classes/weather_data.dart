import 'package:intl/intl.dart';

enum IconType { thunderstorm, drizzle, rain, snow, atmosphere, clear, clouds }

class Coord {
  double lat;
  double lon;
  Coord({required this.lat, required this.lon});
  Coord.fromJson(Map<String, dynamic> json)
      : lat = json["lat"],
        lon = json["lon"];
}

class WeatherType {
  int id;
  String main;
  String description;
  String icon;
  WeatherType(
      {required this.id,
      required this.main,
      required this.description,
      required this.icon});

  WeatherType.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        main = json["main"],
        description = json["description"],
        icon = json["icon"];
}

class WeatherParams {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;
  int? seaLevel;
  int? grndLevel;
  WeatherParams(
      {required this.temp,
      required this.feelsLike,
      required this.tempMin,
      required this.tempMax,
      required this.pressure,
      required this.humidity,
      required this.seaLevel,
      required this.grndLevel});

  WeatherParams.fromJson(Map<String, dynamic> json)
      : temp = double.parse(json["temp"].toString()),
        feelsLike = double.parse(json["feels_like"].toString()),
        tempMin = double.parse(json["temp_min"].toString()),
        tempMax = double.parse(json["temp_max"].toString()),
        pressure = json["pressure"],
        humidity = json["humidity"],
        seaLevel = json["sea_level"],
        grndLevel = json["grnd_level"] {}
}

class WindData {
  double speed;
  int deg;

  WindData({
    required this.speed,
    required this.deg,
  });

  WindData.fromJson(Map<String, dynamic> json)
      : speed = double.parse(json["speed"].toString()),
        deg = json["deg"];
}

class WeatherData {
  Coord _coord;
  WeatherType _weatherType;
  String _base;
  WeatherParams _weatherParams;
  int _visibility;
  WindData? _windData;
  int _date;
  int _sunrise;
  int _sunset;
  String? _address;

  WeatherData.fromJson(Map<String, dynamic> json)
      : _coord = Coord.fromJson(json["coord"]),
        _visibility = json["visibility"],
        _base = json["base"],
        _date = json["dt"],
        _weatherParams = WeatherParams.fromJson(json["main"]),
        _sunrise = json["sys"]["sunrise"],
        _sunset = json["sys"]["sunset"],
        _weatherType = WeatherType.fromJson(json["weather"][0]),
        _windData = WindData.fromJson(json["wind"]);

  void setAddress(String address) {
    _address = address;
  }

  //getters
  String? get address => _address;
  String get dayOrNight => _dayOrNight();
  String get date => secondsToDate(_date, "EEE, d MMMM");
  String get sunrise => secondsToDate(_sunrise, "H:m");
  String get sunset => secondsToDate(_sunset, "H:m");
  int get temp => kelvinToCelsius(_weatherParams.temp);
  int get feelsLikeTemp => kelvinToCelsius(_weatherParams.feelsLike);
  int get humidity => _weatherParams.humidity;
  int get pressure => _weatherParams.pressure;
  int get windSpeed => _windData!.speed.round();
  String get iconName => iconTypeToAddr(weatherCodeToIcon(_weatherType.id));
  //utils
  String _dayOrNight() {
    DateTime sunsetTime =
        DateTime.fromMillisecondsSinceEpoch((_sunset * 1000), isUtc: true);
    DateTime sunriseTime =
        DateTime.fromMillisecondsSinceEpoch((_sunset * 1000), isUtc: true);
    DateTime currentTime =
        DateTime.fromMillisecondsSinceEpoch((_date * 1000), isUtc: true);
    if (currentTime.hour > sunriseTime.hour &&
        currentTime.hour < sunsetTime.hour) {
      return "day";
    } else {
      return 'night';
    }
  }

  String secondsToDate(int seconds, String format) {
    DateTime tmp =
        DateTime.fromMillisecondsSinceEpoch((seconds * 1000), isUtc: true)
            .toLocal();
    return DateFormat(format).format(tmp);
  }

  int kelvinToCelsius(double kelvin) {
    return (kelvin - 273.16).round();
  }

  IconType weatherCodeToIcon(int weatherCode) {
    int id = (weatherCode / 100).truncate();
    IconType iconType = IconType.clear;

    switch (id) {
      case 2:
        iconType = IconType.thunderstorm;
        break;
      case 3:
        iconType = IconType.drizzle;
        break;
      case 5:
        iconType = IconType.rain;
        break;
      case 6:
        iconType = IconType.snow;
        break;
      case 7:
        iconType = IconType.atmosphere;
        break;
      case 8:
        if (weatherCode == 800) {
          iconType = IconType.clear;
        } else {
          iconType = IconType.clouds;
        }
        break;
    }
    return iconType;
  }

  String iconTypeToAddr(IconType iconType) {
    return iconType.toString().substring(
          9,
        );
  }
}
