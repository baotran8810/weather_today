import 'package:dio/dio.dart';
import 'package:weather_today/api/exceptions/api_exception.dart';

String getErrorMessage(error) {
  if (error is DioException) {
    return "Cannot connect";
  }
  if (error is ApiException) {
    return error.error.message;
  }
  return error.toString().replaceAll('Exception: ', '');
}
