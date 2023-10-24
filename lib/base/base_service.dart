import 'package:dio/dio.dart';
import 'package:weather_today/api/exceptions/api_exception.dart';
import 'package:weather_today/api/rest_client.dart';

abstract class BaseService {
  Future<dynamic> get(String path, {Map<String, dynamic>? params}) async {
    final response = await RestClient.dio.get(path, queryParameters: params);

    return _handleResponse(response);
  }

  dynamic _handleResponse(Response response) {
    if (response.statusCode != 200) {
      throw ApiException.fromJson(response.data);
    }

    if (response.data is String) {
      return response.data;
    }
    return response;
  }
}
