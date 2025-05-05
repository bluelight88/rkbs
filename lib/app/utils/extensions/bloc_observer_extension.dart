import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

final class BlocObserverExtension extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log("Bloc => ${bloc.runtimeType}, Event => $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log(transition.toString());
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log("Bloc => $bloc, Error => $error");
  }
}
