import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../classes/weather_data.dart';
import '../model/weather_data_model.dart';
import 'dart:math';

class WeatherDataView extends StatefulWidget {
  const WeatherDataView({super.key});

  @override
  State<WeatherDataView> createState() => _WeatherDataViewState();
}

class _WeatherDataViewState extends State<WeatherDataView> {
  WeatherDataModel _weatherDataModel = WeatherDataModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Consumer<WeatherDataModel>(
            builder: (context, weatherDataModel, widget) {
          if (weatherDataModel.weatherData != null) {
            WeatherData weatherData = weatherDataModel.weatherData!;

            return Column(
              key: ValueKey("weatherDataColumn"),
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${weatherData.address}",
                          style: TextStyle(fontSize: 18),
                        ),
                        VerticalSpace(),
                        Row(children: [
                          Text("${(weatherData.temp)}\u00B0C",
                              style: TextStyle(fontSize: 32)),
                          const SizedBox(
                            width: 2,
                          ),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: Image(
                                image: AssetImage(
                                    "assets/weatherIcons/${weatherData.dayOrNight}/${weatherData.iconName}.png"),
                                fit: BoxFit.fitWidth),
                          )
                        ]),
                        Text("feels like ${weatherData.feelsLikeTemp}\u00B0C",
                            style: TextStyle(fontSize: 16))
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(weatherData.date,
                              style: TextStyle(fontSize: 18)),
                          VerticalSpace(),
                          const Text("Sunrise", style: TextStyle(fontSize: 16)),
                          Text(weatherData.sunrise),
                          VerticalSpace(),
                          const Text("Sunset", style: TextStyle(fontSize: 16)),
                          Text(weatherData.sunset)
                        ])
                  ],
                ),
                VerticalSpace(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        const Text("Humidity", style: TextStyle(fontSize: 16)),
                        Text("${weatherData.humidity} %")
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Pressure", style: TextStyle(fontSize: 16)),
                        Text("${weatherData.pressure} hPa")
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Wind Speed",
                            style: TextStyle(fontSize: 16)),
                        Text("${weatherData.windSpeed} ms")
                      ],
                    )
                  ],
                )
              ],
            );
          } else {
            return const Text("No Location Selected");
          }
        }),
      ]),
    );
  }
}

class VerticalSpace extends StatelessWidget {
  VerticalSpace({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 8,
    );
  }
}
