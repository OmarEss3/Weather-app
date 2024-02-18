import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get_weather_cubits/get_weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/sevices/weather_services.dart';
import 'package:weather_app/views/search_view.dart';

class GetWeatherCubit extends Cubit<WeatherState> {
  GetWeatherCubit() : super(WeatherInitialState());
  WeatherModel? weatherModel;

  getWeather({required String cityName}) async {
    try {
      weatherModel =
          await WeatherServices(Dio()).getCurrentWeather(cityName: cityName);
      emit(WeatherLoadedState(weatherModel: weatherModel!));
    } catch (e) {
      emit(WeatherFailureState(e.toString()));
    }
  }
}
