part of 'splash_init_bloc.dart';

sealed class SplashInitEvent extends Equatable {
  const SplashInitEvent();

  @override
  List<Object> get props => [];
}

final class UserSplashInit extends SplashInitEvent {
  const UserSplashInit();
}
