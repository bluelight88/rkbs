part of 'appoinment_bloc.dart';

sealed class AppoinmentState extends Equatable {
  const AppoinmentState();

  @override
  List<Object> get props => [];
}

final class AppoinmentInitial extends AppoinmentState {}

final class AppoinmentLoading extends AppoinmentState {}

final class AppoinmentSuccess extends AppoinmentState {
  final List<AppoinmentData> appoinmentResponseData;

  const AppoinmentSuccess(this.appoinmentResponseData);
}

final class AppoinmentFailure extends AppoinmentState {
  final String message;

  const AppoinmentFailure(this.message);
}

