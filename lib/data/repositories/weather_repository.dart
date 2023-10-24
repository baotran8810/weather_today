import 'package:weather_today/api/services/weather_service.dart';
import 'package:weather_today/data/model/get_weather_response.dart';

class WeatherRepository {
  final WeatherService _service = WeatherService();

  Future<GetWeatherResponse> getWeather(String value) async {
    final response = await _service.getWeather(value);

    final result = GetWeatherResponse.fromJson(response.data);

    return result;
  }
}
