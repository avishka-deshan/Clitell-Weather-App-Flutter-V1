import 'package:intl/intl.dart';

class WeatherResponse {
  final String cityName;
  final TempResponse temperature;
  final updatedDate;
  final sunriseTime;
  final sunsetTime;
  final dayTime;
  WeatherResponse(this.cityName, this.temperature,this.updatedDate, this.sunriseTime,this.sunsetTime, this.dayTime);

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

    final temperature = TempResponse.fromJson(tempJson);
    print(cityName);

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

    print(upTime);
    print(riseTime);
    print(setTime);
    print(dayTime);

    return WeatherResponse(cityName, temperature, updatedDate,sunriseTime,sunsetTime,dayTime);
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

class SunRiseSetResponse{
  final int sunrise;
  final int sunset;

  SunRiseSetResponse(this.sunrise, this.sunset);

  factory SunRiseSetResponse.fromJson(Map<String, dynamic> json) {
    final sunriseLong = json['sunrise']*1000;
    final sunsetLong = json['sunset']*1000;
    return SunRiseSetResponse(sunriseLong,sunsetLong);
  }

}

