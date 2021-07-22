
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/data_management.dart';
import 'package:weather_app/weather_response.dart';
import 'package:weather_app/widgets/weather_widget.dart';
import 'package:geolocator/geolocator.dart';

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
  String updatedDate = '';
  String sunriseTime = '';
  String sunsetTime = '';
  String dayTime = '';

  @override
  void initState() {
    // TODO: implement initState
    getUserLocation(searchText);
    super.initState();
  }

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
              bgImage,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.black38),
            ),
            WeatherWidget(cityName, temperature, updatedDate,sunriseTime,sunsetTime,dayTime),
          ],
        ),
      ),
    );
  }

  getUserLocation(String location) async {//call this async method from whereever you need

    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      String? location = placemarks[0].subAdministrativeArea;
      searchText = location!;
      search(searchText);
    }catch(err){
      print(err);
    }
    return await Geolocator.getCurrentPosition();

  }

  void search(String searchText) async {

    WeatherResponse weatherResponse;
    final response = await DataManagement().getWeather(searchText);
    setState(() {
      weatherResponse = response;
      cityName = weatherResponse.cityName;
      temperature = weatherResponse.temperature.temperature;
      updatedDate = weatherResponse.updatedDate;
      sunriseTime = weatherResponse.sunriseTime;
      sunsetTime = weatherResponse.sunsetTime;
      dayTime = weatherResponse.dayTime;

      if(dayTime == "Night"){
        bgImage = 'assets/images/nightBackground.jpg';
      }else if(dayTime =="Morning"){
        bgImage = 'assets/images/morningBackground.jpg';
      }else if(dayTime == "Afternoon"){
        bgImage = 'assets/images/noonBackground.jpg';
      }else{
        bgImage = 'assets/images/eveningBackground.jpg';
      }
    });
  }
}

