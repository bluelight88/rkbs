part of 'booking_service_bloc.dart';

sealed class BookingServiceState extends Equatable {
  const BookingServiceState();

  @override
  List<Object> get props => [];
}

final class BookingServiceInitial extends BookingServiceState {}

final class BookingServiceLoading extends BookingServiceState {}

final class BookingServiceSuccess extends BookingServiceState {
  final BookingServiceSlotModel model;

  const BookingServiceSuccess({required this.model});
}

final class BookingServiceFailure extends BookingServiceState {
  final String message;

  const BookingServiceFailure({required this.message});
}

final class DoBookServiceLoading extends BookingServiceState {}

final class DoBookServiceSuccess extends BookingServiceState {
  final BookingServiceSlotModel model;

  const DoBookServiceSuccess({required this.model});
}

final class DoBookServiceFailure extends BookingServiceState {
  final String message;

  const DoBookServiceFailure({required this.message});
}
