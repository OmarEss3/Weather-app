import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_app/models/weather_model.dart';

class WeatherServices {
  final Dio dio;
  final String baseUrl = "https://api.weatherapi.com/v1";
  final String apiKey = "f66ff582c1344becb61113801233011";
  WeatherServices(this.dio);
  Future<WeatherModel> getCurrentWeather({required String cityName}) async {
    try { 
      Response response = await dio
          .get('$baseUrl/forecast.json?key=$apiKey&q=$cityName&days=1');
      WeatherModel weatherModel = WeatherModel.fromJson(response.data);
      return weatherModel;
    } on DioException catch (e) {
      final String errMessage =
          e.response?.data['error']['message'] ?? 'oops there is error';
      throw errMessage;
    } catch (e) {
      log(e.toString());
      throw Exception('oops there is error');
    }
  }
}
