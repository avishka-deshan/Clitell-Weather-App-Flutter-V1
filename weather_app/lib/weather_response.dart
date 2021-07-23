import 'package:intl/intl.dart';

class WeatherResponse {
  final String cityName;
  final int temperature;
  final updatedDate;
  final sunriseTime;
  final sunsetTime;
  final dayTime;
  final feelsLike;
  final tempMin;
  final tempMax;
  final pressure;
  final humidity;
  final description;
  final windSpeed;
  final windDirection;
  final country;
  final visibility;

  WeatherResponse(this.cityName, this.temperature,this.updatedDate, this.sunriseTime,this.sunsetTime, this.dayTime, this.feelsLike, this.tempMin,this.tempMax,
      this.pressure,this.humidity,this.description,this.windSpeed,this.windDirection,this.country,this.visibility);

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];
    final tempJson = json['main'];
    final dateLong = json['dt']*1000;
    final int timeZoneLong = json['timezone']*1000;
    final sunriseJson =  json['sys'];

    final dateFormat = new DateFormat('HH:mm a EEE dd MMM yyyy ');
    final updatedDate = dateFormat.format(new DateTime.fromMillisecondsSinceEpoch(dateLong));
    final timeFormat = new DateFormat('HH:mm a');
    final updatedTime = timeFormat.format(new DateTime.fromMillisecondsSinceEpoch(dateLong));
    print(updatedDate);

    final temperature = TempResponse.fromJson(tempJson).temperature;
    print(cityName);
    final feelsLike =  TempResponse.fromJson(tempJson).feelsLike;

    final sunTime = SunRiseSetResponse.fromJson(sunriseJson);
    final sunriseLong = sunTime.sunrise;
    final sunsetLong = sunTime.sunset;
    final dateFormatTime = new DateFormat('HH:mm a');
    final sunriseTime =  dateFormatTime.format(new DateTime.fromMillisecondsSinceEpoch(sunriseLong+timeZoneLong).toUtc());
    final sunsetTime =  dateFormatTime.format(new DateTime.fromMillisecondsSinceEpoch(sunsetLong+timeZoneLong).toUtc());
    final noon = dateFormatTime.format(new DateTime.fromMillisecondsSinceEpoch(43200000).toUtc());
    print(noon);

    DateTime upTime = new DateFormat("HH:mm").parse(updatedTime);
    DateTime riseTime = new DateFormat("HH:mm").parse(sunriseTime);
    DateTime setTime = new DateFormat("HH:mm").parse(sunsetTime);
    DateTime noonTime = new DateFormat("HH:mm").parse("12:00");
    DateTime eveningTime = new DateFormat("HH:mm").parse("17:00");

    final dayTime;
    if(upTime.isAfter(riseTime) && upTime.isBefore(noonTime)){
      dayTime = "Morning";
      print(dayTime);
    }else if(upTime.isAfter(noonTime) && upTime.isBefore(eveningTime)){
      dayTime = "Afternoon";
    }else if(upTime.isAfter(eveningTime) && upTime.isBefore(setTime)){
      dayTime = "Evening";
    }else{
      dayTime = "Night";
    }

    final country = SunRiseSetResponse.fromJson(sunriseJson).country;

    final tempMin = TempResponse.fromJson(tempJson).tempMin;
    final tempMax = TempResponse.fromJson(tempJson).tempMax;
    final pressure = TempResponse.fromJson(tempJson).pressure;
    final humidity = TempResponse.fromJson(tempJson).humidity;

    final weatherInfoJson = json['weather'][0];
    final description = WeatherInfo.fromJson(weatherInfoJson).description;

    final windJson = json['wind'];
    final windSpeed = Wind.fromJson(windJson).speed;
    final windDirection = Wind.fromJson(windJson).direction;

    final visibility = json['visibility']/1000.toInt();

    print(upTime);
    print(riseTime);
    print(setTime);
    print(dayTime);

    return WeatherResponse(cityName, temperature, updatedDate,sunriseTime,sunsetTime,dayTime,feelsLike,tempMin,tempMax,pressure,humidity,description,windSpeed,windDirection,country,visibility);
  }

}

class TempResponse {
  final int temperature;
  final int feelsLike;
  final int tempMin;
  final int tempMax;
  final int pressure;
  final int humidity;

  TempResponse(this.temperature, this.feelsLike, this.tempMin,this.tempMax,this.pressure,this.humidity);

  factory TempResponse.fromJson(Map<String, dynamic> json) {
    final  kTemperature = json['temp'];
    final int temperature = kTemperature.toInt() - 273;

    final kFellsLike = json['feels_like'];
    final int feelsLike = kFellsLike.toInt() - 273;

    final kTempMin = json['temp_min'];
    final int tempMin = kTempMin.toInt() -273;

    final kTempMax = json['temp_max'];
    final int tempMax = kTempMax.toInt() -273;

    final pressure = json['pressure'];

    final humidity = json['humidity'];

    print(temperature);
    print(feelsLike);
    return TempResponse(temperature,feelsLike,tempMin,tempMax,pressure,humidity);
  }
}

class SunRiseSetResponse{
  final int sunrise;
  final int sunset;
  final String country;

  SunRiseSetResponse(this.sunrise, this.sunset, this.country);

  factory SunRiseSetResponse.fromJson(Map<String, dynamic> json) {
    final sunriseLong = json['sunrise']*1000;
    final sunsetLong = json['sunset']*1000;
    final country = json['country'];
    return SunRiseSetResponse(sunriseLong,sunsetLong,country);
  }

}

class WeatherInfo{
  final String description;

  WeatherInfo(this.description);

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];

    return WeatherInfo(description);
  }
}

class Wind {
  final String speed;
  final String direction;

  Wind(this.speed, this.direction);

  factory Wind.fromJson(Map<String, dynamic> json) {
    final speed = json['speed'].toString();
    final degree = json['deg'];

    List<String> directions = ["N", "NE", "E", "SE", "S", "SW", "W", "NW"];
    int dirPosition = ((((degree) % 360) / 45) % 8).round();
    final direction = directions[dirPosition];

    return Wind(speed, direction);
  }
}

