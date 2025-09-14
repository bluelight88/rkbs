part of 'splash_init_bloc.dart';

sealed class SplashInitState extends Equatable {
  const SplashInitState();

  @override
  List<Object> get props => [];
}

final class SplashInitInitial extends SplashInitState {}

final class SplashInitLoading extends SplashInitState {}

final class SplashInitSuccess extends SplashInitState {
  final SplashResponseModel model;

  const SplashInitSuccess({required this.model});
}

final class SplashInitFailure extends SplashInitState {
  final String msg;

  const SplashInitFailure(this.msg);
}
