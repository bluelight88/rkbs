part of 'appoinment_bloc.dart';

sealed class AppoinmentEvent extends Equatable {
  const AppoinmentEvent();

  @override
  List<Object?> get props => [];
}

class GetAppoinmentRecord extends AppoinmentEvent {
  final int customerId;
  const GetAppoinmentRecord({required this.customerId});
}
