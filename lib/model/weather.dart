import 'dart:convert';

import 'package:weather_app/functions/getweather.dart';

class WeatherModel {
  WeatherModel(
      {required this.weather,
      required this.name,
      required this.countryName,
      required this.windspeed});
  String? countryName;
  double? weather;
  String? name;
  double? windspeed;

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
      weather: json["main"]['temp'],
      name: json["name"],
      countryName: json['sys']['country'],
      windspeed: json['wind']['speed']);

  static Future<WeatherModel> getCurrentWeather({
    required double latitude,
    required double longitude,
  }) async {
    final baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?lat=${latitude}&lon=${longitude}&appid=$apiKey&units=metric';

    NetworkHelper helper = NetworkHelper(url: baseUrl);

    final response = await helper.getWeather();
    final json = jsonDecode(response);
    return WeatherModel.fromJson(json);
  }

  static const apiKey = 'ddd8723a38df5b28a23e057a755e5300';

  static Future<WeatherModel> getCityWeather({
    required String cityName,
  }) async {
    final baseUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=${cityName}&appid=${apiKey}&units=metric';

    NetworkHelper helper = NetworkHelper(url: baseUrl);

    final response = await helper.getWeather();
    final json = jsonDecode(response);
    return WeatherModel.fromJson(json);
  }
}
