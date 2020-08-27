import 'package:flutter/material.dart';
import 'package:flutter_weather/src/screens/weather_screen.dart';

class Routes {
  static final mainRoute = <String, WidgetBuilder>{
    '/home': (context) => WeatherScreen(),
  };
}
