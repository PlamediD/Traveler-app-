import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/search_widget.dart';
import 'widgets/weather_data_widget.dart';
import 'model/weather_data_model.dart';

class WeatherView extends StatefulWidget {
  const WeatherView({super.key});

  @override
  State<WeatherView> createState() => _WeatherViewState();
}

class _WeatherViewState extends State<WeatherView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ChangeNotifierProvider(
        create: (context) => WeatherDataModel(),
        child: Column(
          children: [SearchWidget(), WeatherDataView()],
        ),
      ),
    );
  }
}
