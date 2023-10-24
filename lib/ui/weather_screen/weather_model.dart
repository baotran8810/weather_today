import 'package:adv_flutter_weather/flutter_weather_bg.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_today/data/enum.dart';
import 'package:weather_today/data/model/get_weather_response.dart';
import 'package:weather_today/data/repositories/weather_repository.dart';
import 'package:weather_today/utils/commons.dart';

class WeatherModel extends ChangeNotifier {
  GetWeatherResponse? weather;

  ViewState viewState = ViewState.initial;

  String errorMsg = "";

  WeatherType weatherType = WeatherType.cloudy;
  Future<void> getData({String? value}) async {
    try {
      if (value != null) {
        viewState = ViewState.loading;
        notifyListeners();
      }
      weather = await WeatherRepository().getWeather(value ?? "Vietnam");
      updateWeatherType();
      viewState = ViewState.loaded;
      notifyListeners();
    } catch (error) {
      errorMsg = getErrorMessage(error);
      viewState = ViewState.error;
      notifyListeners();
    }
  }

  void updateWeatherType() {
    final code = weather?.current.condition.code;
    final isDay = weather?.current.isDay;

    switch (code) {
      case 1000:
        if (isDay == 1) {
          weatherType = WeatherType.sunny;
        } else {
          weatherType = WeatherType.sunnyNight;
        }
        break;
      case 1003:
      case 1006:
      case 1009:
      case 1063:
        if (isDay == 1) {
          weatherType = WeatherType.cloudy;
        } else {
          weatherType = WeatherType.cloudyNight;
        }
        break;
      case 1030:
      case 1135:
        weatherType = WeatherType.foggy;
        break;
      case 1183:
      case 1186:
        weatherType = WeatherType.lightRainy;
        break;
      case 1189:
        weatherType = WeatherType.middleRainy;
        break;
      case 1195:
        weatherType = WeatherType.middleRainy;
        break;
    }
  }
}
