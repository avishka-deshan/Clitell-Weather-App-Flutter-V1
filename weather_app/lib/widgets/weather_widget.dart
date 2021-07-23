import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/main.dart';
import 'package:weather_app/screens/weather_page.dart';

class WeatherWidget extends StatefulWidget {
  String cityName = "";
  int temperature = 0;
  String updatedDate = '';
  String sunriseTime = '';
  String sunsetTime = '';
  String dayTime = '';
  int feelsLike = 0;
  int tempMin = 0;
  int tempMax = 0;
  int pressure = 0;
  int humidity = 0;
  String description = '';
  String desIcon = '';
  String windSpeed = '';
  String windDirection = '';
  String country = '';
  double visibility = 0;

  WeatherWidget(String cityName, int temp, String date, String sunrise, String sunset, String day, int feels, int min,
      int max, int pressure, int humidity, String desc, String desIcon, String speed, String direc, String country, double visibility) {
    this.cityName = cityName;
    this.temperature = temp;
    this.updatedDate = date;
    this.sunriseTime = sunrise;
    this.sunsetTime = sunset;
    this.dayTime = day;
    this.feelsLike = feels;
    this.tempMin = min;
    this.tempMax = max;
    this.pressure = pressure;
    this.humidity = humidity;
    this.description = desc;
    this.desIcon = desIcon;
    this.windSpeed = speed;
    this.windDirection = direc;
    this.country = country;
    this.visibility = visibility;
  }

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Row(
                      children: [
                        Text(
                          widget.cityName,
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          widget.country,
                          style: GoogleFonts.lato(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(widget.updatedDate,
                            style: GoogleFonts.lato(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        IconButton(
                          icon: AnimatedIcon(
                            icon: AnimatedIcons.search_ellipsis,
                            progress: controller,
                            size: 30,
                            color: Colors.white,
                          ),
                          onPressed: () => toggleIcon(0),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/smile.png",
                            width: 50,
                            height: 50,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Good " + widget.dayTime,
                              style: GoogleFonts.lato(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.temperature.toString() + "\u2103",
                          style: GoogleFonts.nunito(
                            fontSize: 90,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/up-arrow.png",
                                    width: 20,
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    widget.tempMax.toString() + "\u2103",
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/down-arrow.png",
                                    width: 20,
                                    height: 30,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    widget.tempMin.toString() + "\u2103",
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "Feels Like: " + widget.feelsLike.toString() + "\u2103",
                      style: GoogleFonts.nunito(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  widget.desIcon,
                                  width: 30,
                                  height: 30,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(widget.description,
                                    style: GoogleFonts.nunito(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/sun.png",
                            width: 30,
                            height: 30,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Rise: " + widget.sunriseTime,
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          Text("Set: " + widget.sunsetTime,
                              style: GoogleFonts.nunito(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.white30,
                )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Wind",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(widget.windSpeed,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text("km/h " + widget.windDirection,
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Pressure",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(widget.pressure.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text("mb",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Humidity",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(widget.humidity.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text("%",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "Visibility",
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        Text(widget.visibility.toString(),
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                        Text("km",
                            style: GoogleFonts.lato(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void toggleIcon(int index) async {
    setState(() {
      controller.forward().then((_) async {
        streamController.add(index);
        await Future.delayed(Duration(seconds: 1));
        controller.reverse();
      });
    });
  }
}
