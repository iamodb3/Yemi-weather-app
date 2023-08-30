import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(
        useMaterial3: true,
      ),
      // .copyWith(
      //     appBarTheme: const AppBarTheme(
      //   color: Colors.white,
      // )),
      home: const WeatherScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
