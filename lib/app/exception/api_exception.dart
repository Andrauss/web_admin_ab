import 'api_error_type.dart';

/// Representa um erro da API com o tipo definido na propriedade [type]
class ApiException implements Exception {
  final Map<String, dynamic> errorData;
  final ApiErrorType type;

  ApiException(this.type, this.errorData);

  ApiExceptionErrorData get errorDetails =>
      ApiExceptionErrorData.fromJson(this.errorData);
}

class ApiExceptionErrorData {
  final String? code;
  final String? message;
  final String? exception;

  ApiExceptionErrorData({this.code, this.message, this.exception});

  factory ApiExceptionErrorData.fromJson(Map<String, dynamic> json) =>
      ApiExceptionErrorData(
          code: json["code"],
          message: json["message"],
          exception: json["exception"]);
}
