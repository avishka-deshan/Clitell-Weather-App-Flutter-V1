import 'dart:convert';

import 'package:flutter/foundation.dart';

class CityResponse {
  final String cityName;
  final TempResponse temperature;

  CityResponse(this.cityName, this.temperature);

  factory CityResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final tempJson = json['main'];
    final temperature = TempResponse.fromJson(tempJson);
    print(cityName);
    return CityResponse(cityName, temperature);
  }
}

class TempResponse {
  final int temperature;

  TempResponse(this.temperature);

  factory TempResponse.fromJson(Map<String, dynamic> json) {
    final double kTemperature = json['temp'];
    final int temperature = kTemperature.toInt() - 273;
    print(temperature);
    return TempResponse(temperature);
  }
}
