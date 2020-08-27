import 'package:flutter/material.dart';
import 'package:flutter_weather/main.dart';
import 'package:flutter_weather/src/api/weather_api_client.dart';
import 'package:flutter_weather/src/bloc/temp_widget.dart';
import 'package:flutter_weather/src/bloc/weather_bloc.dart';
import 'package:flutter_weather/src/bloc/weather_event.dart';
import 'package:flutter_weather/src/bloc/weather_state.dart';
import 'package:flutter_weather/src/repo/weather_repo.dart';
import 'package:flutter_weather/src/api/api_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather/src/widgets/weather_widget.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

enum OptionsMenu { changeCity }

class WeatherScreen extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
      weatherApiClient: WeatherApiClient(
          httpClient: http.Client(), apiKey: ApiKey.openWeatherMap));
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  WeatherBloc _weatherBloc;
  String _cityName = 'bengaluru';
  AnimationController _fadeController;
  Animation<double> _fadeAnimation;
  var controller;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(weatherRepository: widget.weatherRepository);
    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });
    _fadeController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.indigo,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                height: screenHeight / 3,
                child: Stack(
                  children: <Widget>[
                    searvhBar(context),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: BlocBuilder(
                                bloc: _weatherBloc,
                                // ignore: missing_return
                                builder: (_, WeatherState weatherState) {
                                  if (weatherState is WeatherLoaded) {
                                    this._cityName =
                                        weatherState.weather.cityName;
                                    _fadeController.reset();
                                    _fadeController.forward();
                                    return TemperatureWidget(
                                      weather: weatherState.weather,
                                    );
                                  } else if (weatherState is WeatherError ||
                                      weatherState is WeatherEmpty) {
                                    String errorText =
                                        'There was an error fetching weather data';
                                    if (weatherState is WeatherError) {
                                      if (weatherState.errorCode == 404) {
                                        errorText =
                                            'We have trouble fetching weather for $_cityName';
                                      }
                                    }
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          Icons.error_outline,
                                          color: Colors.redAccent,
                                          size: 24,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          errorText,
                                          style: TextStyle(
                                              color:
                                                  AppStateContainer.of(context)
                                                      .theme
                                                      .accentColor),
                                        ),
                                        FlatButton(
                                          child: Text(
                                            "Try Again",
                                            style: TextStyle(
                                                color: AppStateContainer.of(
                                                        context)
                                                    .theme
                                                    .accentColor),
                                          ),
                                          onPressed: _fetchWeatherWithCity,
                                        )
                                      ],
                                    );
                                  } else if (weatherState is WeatherLoading) {
                                    return Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor:
                                            AppStateContainer.of(context)
                                                .theme
                                                .primaryColor,
                                      ),
                                    );
                                  }
                                }),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: screenHeight / 1.5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: BlocBuilder(
                      bloc: _weatherBloc,
                      // ignore: missing_return
                      builder: (_, WeatherState weatherState) {
                        if (weatherState is WeatherLoaded) {
                          this._cityName = weatherState.weather.cityName;
                          _fadeController.reset();
                          _fadeController.forward();
                          return WeatherWidget(
                            weather: weatherState.weather,
                          );
                        } else if (weatherState is WeatherError ||
                            weatherState is WeatherEmpty) {
                          String errorText =
                              'There was an error fetching weather data';
                          if (weatherState is WeatherError) {
                            if (weatherState.errorCode == 404) {
                              errorText =
                                  'We have trouble fetching weather for $_cityName';
                            }
                          }
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                                size: 24,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                errorText,
                                style: TextStyle(
                                    color: AppStateContainer.of(context)
                                        .theme
                                        .accentColor),
                              ),
                              FlatButton(
                                child: Text(
                                  "Try Again",
                                  style: TextStyle(
                                      color: AppStateContainer.of(context)
                                          .theme
                                          .accentColor),
                                ),
                                onPressed: _fetchWeatherWithCity,
                              )
                            ],
                          );
                        } else if (weatherState is WeatherLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              backgroundColor: AppStateContainer.of(context)
                                  .theme
                                  .primaryColor,
                            ),
                          );
                        }
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  Widget searvhBar(context) {
    return Positioned(
      top: 50.0,
      right: 10.0,
      left: 10.0,
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          color: Colors.white,
        ),
        child: TextField(
          controller: controller,
          cursorColor: Colors.black,
          onTap: () => _showCityChangeDialog(),
          decoration: InputDecoration(
            hintText: "Enter City",
            border: InputBorder.none,
            contentPadding: EdgeInsets.only(left: 15.0, top: 16.0, bottom: 15),
            suffixIcon: Container(
              margin: EdgeInsets.only(left: 5, top: 10, bottom: 10),
              width: 10,
              height: 10,
              child: Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Change city', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'ok',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () {
                  _fetchWeatherWithCity();
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: TextField(
              autofocus: true,
              onChanged: (text) {
                _cityName = text;
              },
              decoration: InputDecoration(
                  hintText: 'Name of your city',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _fetchWeatherWithLocation().catchError((error) {
                        _fetchWeatherWithCity();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 16,
                    ),
                  )),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }

  _fetchWeatherWithCity() {
    _weatherBloc.dispatch(FetchWeather(cityName: _cityName));
  }

  _fetchWeatherWithLocation() async {
    var permissionHandler = PermissionHandler();
    var permissionResult = await permissionHandler
        .requestPermissions([PermissionGroup.locationWhenInUse]);

    switch (permissionResult[PermissionGroup.locationWhenInUse]) {
      case PermissionStatus.denied:
      case PermissionStatus.unknown:
        print('location permission denied');
        _showLocationDeniedDialog(permissionHandler);
        throw Error();
    }

    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    _weatherBloc.dispatch(FetchWeather(
        longitude: position.longitude, latitude: position.latitude));
  }

  void _showLocationDeniedDialog(PermissionHandler permissionHandler) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Location is disabled :(',
                style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  'Enable!',
                  style: TextStyle(color: Colors.green, fontSize: 16),
                ),
                onPressed: () {
                  permissionHandler.openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
