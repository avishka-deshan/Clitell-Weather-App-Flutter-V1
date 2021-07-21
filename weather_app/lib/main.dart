
import 'package:flutter/material.dart';
import 'package:weather_app/screens/weather_page.dart';

main(){
 runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Weather App",
      theme: ThemeData(
        primarySwatch: Colors.indigo,
            visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WeatherPage(),
    );
  }
}