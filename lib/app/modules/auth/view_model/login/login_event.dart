part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class UserLogin extends LoginEvent {
  final String email, password, fcmToken, deviceId, voipToken;

  const UserLogin({
    required this.email,
    required this.password,
    required this.fcmToken,
    required this.deviceId,
    required this.voipToken,
  });
}
