part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

final class UserLogin extends LoginEvent {
  final String email, password;

  const UserLogin({required this.email, required this.password});
}

final class SocialLoginEvent extends LoginEvent {
  final String provider;
  final String idToken;

  const SocialLoginEvent({required this.provider, required this.idToken});
}
