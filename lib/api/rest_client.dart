import 'package:curl_logger_dio_interceptor/curl_logger_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class RestClient {
  static const kTimeout = 2;
  static const kEnableLog = kDebugMode;
  static const kAccessToken = 'access_token';
  static const kDeviceId = "x-device-id";
  static const kDeviceType = "x-device-type";

  static List<int>? sslCert;
  // ApiErrorCallback? _onApiError;

  static late Dio dio;
  late Map<String, dynamic> _headers;

  void init(
    String baseUrl, {
    String? deviceId,
    String? userAgent,
    String? accessToken,
    // ApiErrorCallback? errorCallback,
  }) {
    _headers = {
      'Content-Type': 'application/json',
      kAccessToken: '$accessToken',
      kDeviceId: deviceId,
      kDeviceType: "2",
    };

    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: kTimeout),
      receiveTimeout: const Duration(seconds: kTimeout),
      headers: _headers,
      responseType: ResponseType.json,
      validateStatus: (status) {
        return status! < 500;
      },
    ));

    final httpClientAdapter = DefaultHttpClientAdapter();
    dio.httpClientAdapter = httpClientAdapter;

    if (kEnableLog) {
      dio.interceptors.add(
        PrettyDioLogger(
          requestBody: true,
          responseBody: true,
          requestHeader: true,
        ),
      );
    }

    dio.interceptors.add(CurlLoggerDioInterceptor(printOnSuccess: true));
    // dio.interceptors.add(
    //   InterceptorsWrapper(
    //     onError: (dioError, handler) => _errorInterceptor(dioError, handler),
    //   ),
    // );

    // _onApiError = errorCallback;
  }

  void setToken(String token) {
    dio.options.headers[kAccessToken] = token;
  }

  void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
  }

  void clearToken() {
    _headers.remove(kAccessToken);
  }

  // dynamic _errorInterceptor(DioError error, ErrorInterceptorHandler handler) {
  //   if (_onApiError != null) {
  //     _onApiError!(error, handler);
  //   }
  //   return error;
  // }
}
