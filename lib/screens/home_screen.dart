import 'package:flutter/material.dart';

import '../models/weather_model.dart';
import '../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WeatherModel> _weathers = [];

  void getWeatherData() async {
    _weathers = await WeatherService().getWeatherData();
    setState(() {});
  }

  @override
  void initState() {
    getWeatherData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: _weathers.length,
          itemBuilder: (context, index) {
            WeatherModel weatherModel = _weathers[index];
            return Container(
              padding: const EdgeInsets.all(20),
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                children: [
                  Text(weatherModel.day,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20)),
                  Image.network(
                    weatherModel.icon,
                    height: 100,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${weatherModel.description.toUpperCase()}  ${weatherModel.degree}",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                  ),
                  Text("Min : ${weatherModel.min}"),
                  Text("Max : ${weatherModel.max}"),
                  Text("Nem : ${weatherModel.humidity}"),
                  Text("Gece : ${weatherModel.night}"),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
