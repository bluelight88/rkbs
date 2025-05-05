import 'api_model.dart';

final class ErrorException implements Exception {
  ErrorModel error;
  ErrorException(this.error);

  @override
  String toString() => error.description;
}
