// import 'dart:ui';
import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  Future<Map<String, dynamic>> getCurrentWeather() async {
    // print('fn called');
    try {
      String cityName = 'London';
      final res = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/forecast?q=$cityName,uk&APPID=$openWeatherAPIKey'),
      );

      // print('api ended');
      final data = jsonDecode(res.body);

      if (data['cod'] != '200') {
        throw 'An unexpected error occured Yemi';
      }
      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('build fn called');
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
        ],
      ),
      // Main card.start
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          print(snapshot);
          // print(snapshot.runtimeType);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: const CircularProgressIndicator.adaptive());
          }

          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          final data = snapshot.data!;

          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                firstCard(context, "$currentTemp K", currentSky),
                SizedBox(
                  height: 5,
                ),
                secondCard(context),
                SizedBox(
                  height: 15,
                ),
                thirdCard(context),
              ],
            ),
          );
        },
      ),
      // Main card.start
    );
  }
}

SizedBox thirdCard(BuildContext context) {
  List secondIconList = [
    [Icon(Icons.water_drop), "Humidity", "94"],
    [Icon(Icons.air_outlined), "Wind Speed", "7.67"],
    [Icon(Icons.beach_access), "Pressure", "1006"],
  ];
  final myWidth = MediaQuery.of(context).size.width;
  return SizedBox(
    width: myWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Additional Information",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          width: myWidth,
          height: 100,
          child: ListView.builder(
              itemCount: secondIconList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        secondIconList[index][0],
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          secondIconList[index][1],
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          secondIconList[index][2],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    ),
  );
}

SizedBox secondCard(BuildContext context) {
  final myWidth = MediaQuery.of(context).size.width;
  return SizedBox(
    width: myWidth,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weather Forecast",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: myWidth,
          height: 120,
          child: ListView.builder(
              itemCount: 4,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Container(
                    height: 50,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 41, 41, 41),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "09:00",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Icon(Icons.cloud, size: 40),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "301.17",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
        ),
      ],
    ),
  );
}

Card firstCard(BuildContext context, String mainWeatherInk, String mainSky) {
  final myWidth = MediaQuery.of(context).size.width;
  return Card(
    elevation: 3.0,
    child: Container(
      height: 220,
      width: myWidth,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 41, 41, 41),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            mainWeatherInk,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.cloud,
            size: 70,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            mainSky,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
