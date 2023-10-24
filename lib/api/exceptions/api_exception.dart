class ApiException implements Exception {
  final Error error;

  ApiException({required this.error});

  ApiException.fromJson(Map<String, dynamic> json)
      : error = Error.fromJson(json['error']);
}

class Error {
  final int code;
  final String message;

  Error({required this.code, required this.message});

  Error.fromJson(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'];
}
