part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final String msg;

  const LoginSuccess({required this.msg});
}

final class LoginFailure extends LoginState {
  final String msg;

  const LoginFailure(this.msg);
}
