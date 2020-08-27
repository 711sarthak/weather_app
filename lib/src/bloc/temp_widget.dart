import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/utils/converters.dart';

class TemperatureWidget extends StatelessWidget {
  final Weather weather;

  TemperatureWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 150,
              ),
              Image(
                image: AssetImage('assets/images/Rain.png'),
                height: 100,
                width: 150,
              ),
            ],
          ),
          SizedBox(
            width: 50,
          ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(height: 140),
                Text(
                  '${this.weather.temperature.as(TemperatureUnit.celsius).round()}°C',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
                Text(
                  '${this.weather.main}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ]),
        ],
      ),
    );
  }
}
