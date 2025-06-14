part of 'send_sms_bloc.dart';

sealed class SendSmsEvent extends Equatable {
  const SendSmsEvent();

  @override
  List<Object?> get props => [];
}

class SendSMS extends SendSmsEvent {
  final String mobileNumber;

  const SendSMS({required this.mobileNumber});
}
