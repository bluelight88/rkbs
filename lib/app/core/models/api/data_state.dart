import 'api_model.dart';

abstract class DataState<T> {}

final class DataSuccess<T> extends DataState {
  final T data;
  final String msg;
  DataSuccess(this.data, {this.msg = ""});
}

final class DataFailure<T> extends DataState {
  final ErrorModel error;
  DataFailure(this.error);
}

final class UnknownDataFailure<T> extends DataState {
  final T error;
  UnknownDataFailure(this.error);
}
