import 'package:flutter/material.dart';
import 'weather_data_model.dart';
import 'package:provider/provider.dart';

class SearchWidget extends StatelessWidget {
  SearchWidget({super.key});

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.all(8.0),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: searchTextController,
            decoration: const InputDecoration(
                border: InputBorder.none, hintText: "Location"),
            key: ValueKey("searchWidget"),
            onChanged: (event) => print(event),
          ),
        ),
        IconButton(
            key: ValueKey("searchIconButton"),
            splashRadius: null,
            splashColor: Color(0x00ffffff),
            icon: Icon(
              Icons.search,
              size: 20.0,
            ),
            onPressed: () async {
              await context
                  .read<WeatherDataModel>()
                  .getWeatherData(searchTextController.text);
            })
      ]),
    );
  }
}
