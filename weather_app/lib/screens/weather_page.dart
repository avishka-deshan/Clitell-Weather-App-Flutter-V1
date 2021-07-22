import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/data_management.dart';
import 'package:weather_app/weather_response.dart';
import 'package:weather_app/widgets/weather_widget.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String bgImage = '';
  bool typing = false;
  String searchText = 'Colombo';
  String cityName = '';
  int temperature = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          style: TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              searchText = value;
            });
          },
        ),
        leading: IconButton(
          icon: Icon(Icons.search),
          iconSize: 30,
          onPressed: () {
            search(searchText);
          },
        ),
      ),
      body: Container(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            WeatherWidget(cityName, temperature),
          ],
        ),
      ),
    );
  }

  void search(String searchText) async {
    CityResponse cityResponse;
    final response = await DataManagement().getWeather(searchText);
    setState(() {
      cityResponse = response;
      cityName = cityResponse.cityName;
      temperature = cityResponse.temperature.temperature;
    });
  }
}

/*actions: [
Container(
margin:EdgeInsets.fromLTRB(0, 0, 20, 0),
child: GestureDetector(
onTap: () {},
child: SvgPicture.asset(
'assets/images/menu.svg',
semanticsLabel: "Menu Logo",
height: 25,
width: 25,
color: Colors.white,

),
),
)
],*/
