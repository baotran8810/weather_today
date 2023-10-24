import 'package:dio/dio.dart';
import 'package:weather_today/api/api_endpoints.dart';
import 'package:weather_today/base/base_service.dart';

class WeatherService extends BaseService {
  Future<Response> getWeather(String value) async {
    final body = {"key": apiToken, "q": value};

    final response = await get(WheatherApi.getWheather, params: body);

    return response;
  }
}
