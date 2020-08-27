import 'package:flutter_weather/src/utils/converters.dart';

class Weather {
  int id;
  int time;
  int sunrise;
  int sunset;
  int humidity;
  int visibility;
  int pressure;

  String description;
  String iconCode;
  String main;
  String cityName;
  String country;

  double latitude;
  double longitude;

  double windSpeed;

  Temperature temperature;
  Temperature maxTemperature;
  Temperature minTemperature;
  Temperature feelsLike;

  List<Weather> forecast;

  Weather(
      {this.id,
      this.time,
      this.sunrise,
      this.sunset,
      this.humidity,
      this.pressure,
      this.visibility,
      this.description,
      this.iconCode,
      this.main,
      this.country,
      this.cityName,
      this.latitude,
      this.longitude,
      this.windSpeed,
      this.temperature,
      this.maxTemperature,
      this.minTemperature,
      this.feelsLike,
      this.forecast});

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      latitude: json['coord']['lat'],
      longitude: json['coord']['lon'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      feelsLike: Temperature(intToDouble(json['main']['feels_like'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      visibility: json['visibility'],
      pressure: json['main']['pressure'],
      windSpeed: intToDouble(json['wind']['speed']),
      country: json['sys']['country'],
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = List<Weather>();
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['main']['temp'],
          )),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }
}
