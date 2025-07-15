import 'dart:convert';

import '../../../utils/services/util_methods.dart';

class ApiResponseModel<T> {
  ErrorModel? error;
  bool status;
  String message;
  T data;

  ApiResponseModel(this.data, this.error, this.status, {this.message = ""});

  /// Global response handler from raw JSON
  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic json) fromJsonT,
  ) {
    final bool isSuccess = json['status'] == 'success';
    final String? rawObj = json['obj'];
    T? parsedData;

    if (isSuccess && rawObj != null && rawObj.isNotEmpty) {
      final dynamic decodedObj = jsonDecode(rawObj);
      parsedData = fromJsonT(decodedObj);
    }

    return ApiResponseModel<T>(
      parsedData as T,
      null,
      isSuccess,
      message: json['strMessage'] ?? '',
    );
  }
}

final class ErrorModel {
  String title, description;
  int statusCode;

  ErrorModel(this.title, this.description, this.statusCode);

  factory ErrorModel.fromJson(Map<String, dynamic> json) =>
      ErrorModel(json["title"], json["description"], json["statusCode"]);
}

class ValidationErrorModel {
  final String name;
  final String message;
  final List<String> arguments;
  final String exceptionType;

  ValidationErrorModel({
    required this.name,
    required this.message,
    required this.arguments,
    required this.exceptionType,
  });

  factory ValidationErrorModel.fromJson(Map<String, dynamic> json) =>
      ValidationErrorModel(
        name: json["name"],
        message: json["message"],
        arguments: List<String>.from(
          json["arguments"].map((x) => UtilMethods().emptyStringValueParser(x)),
        ),
        exceptionType: json["exception_type"],
      );
}

final class FileInfo {
  String path, name, ext;
  bool isFromNetwork;

  FileInfo({
    required this.path,
    required this.name,
    this.ext = '',
    this.isFromNetwork = false,
  });

  factory FileInfo.fromJson(Map<String, dynamic> json) =>
      FileInfo(path: json["id"], name: json["name"], isFromNetwork: true);
}
