part of 'send_sms_bloc.dart';

sealed class SendSmsState extends Equatable {
  const SendSmsState();

  @override
  List<Object> get props => [];
}

final class SendSmsInitial extends SendSmsState {}

final class SendSmsSuccess extends SendSmsState {
  final String message;

  const SendSmsSuccess({required this.message});
}

final class SendSmsFailure extends SendSmsState {
  final String message;

  const SendSmsFailure({required this.message});
}

final class SendSmsLoading extends SendSmsState {}
