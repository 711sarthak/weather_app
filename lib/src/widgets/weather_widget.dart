import 'package:flutter/material.dart';
import 'package:flutter_weather/src/model/weather.dart';
import 'package:flutter_weather/src/utils/converters.dart';
import 'package:flutter_weather/src/widgets/value_tile.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({this.weather}) : assert(weather != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${this.weather.cityName},${this.weather.country}',
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Colors.black,
                  fontSize: 25),
            ),
            Icon(
              Icons.location_city,
              color: Colors.grey,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.location_on,
              color: Colors.red,
            ),
            Text(
              '${this.weather.latitude} ,${this.weather.longitude}',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 15),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Card(
            child: Container(
              height: 70,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Feels Like:'),
                  Text(
                    '${this.weather.feelsLike.as(TemperatureUnit.celsius).round()}°C',
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              height: 70,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Visibility:'),
                  Text(
                    '${this.weather.visibility}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              height: 70,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Pressure:'),
                  Text(
                    '${this.weather.pressure}',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
          Card(
            child: Container(
              height: 70,
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('Humidity:'),
                  Text(
                    '${this.weather.humidity}%',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 70,
            ),
            Card(
              child: Container(
                height: 70,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Min Temp:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${this.weather.minTemperature.as(TemperatureUnit.celsius).round()}°C',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Container(
                height: 70,
                width: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      'Max Temp:',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    Text(
                      '${this.weather.maxTemperature.as(TemperatureUnit.celsius).round()}°C',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: 70,
            )
          ],
        ),
        SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Sunrise and Sunset:',
            style: TextStyle(fontSize: 23, fontWeight: FontWeight.w800),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 30,
            ),
            Card(
              child: Container(
                  width: 110,
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: new AssetImage("assets/images/cloudy.png"),
                        height: 50,
                        width: 50,
                      ),
                      ValueTile(
                        "",
                        '${DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunrise * 1000))} IST',
                      ),
                    ],
                  )),
            ),
            Card(
              child: Container(
                  width: 110,
                  height: 110,
                  child: Column(
                    children: <Widget>[
                      Image(
                        image: new AssetImage("assets/images/sea.png"),
                        height: 50,
                        width: 50,
                      ),
                      ValueTile(
                        "",
                        '${DateFormat('h:m a').format(DateTime.fromMillisecondsSinceEpoch(this.weather.sunset * 1000))} IST',
                      ),
                    ],
                  )),
            ),
            SizedBox(
              width: 30,
            ),
          ],
        ),
      ],
    );
  }
}
