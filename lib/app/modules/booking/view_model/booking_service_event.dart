part of 'booking_service_bloc.dart';

sealed class BookingServiceEvent extends Equatable {
  const BookingServiceEvent();

  @override
  List<Object?> get props => [];
}

class BookingServiceList extends BookingServiceEvent {
  final int providerId;
  final int serviceId;
  final int staffId;
  final String date;

  const BookingServiceList({
    required this.providerId,
    required this.serviceId,
    required this.staffId,
    required this.date,
  });
}
