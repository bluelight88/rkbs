import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../../model/login_model.dart';
import '../../model/repo/auth_repo.dart';

part 'login_event.dart';
part 'login_state.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLogin>(_userLogin);
  }

  void _userLogin(UserLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final Map<String, dynamic> params = {
      "login": event.email,
      "password": event.password,
      "fcm_token": event.fcmToken,
      "voip_token": event.voipToken,
      "device_id": event.deviceId,
    };
    final response = await getIt<AuthRepo>().login(params);
    if (response is DataSuccess) {
      emit(LoginSuccess(
        msg: "Login Success",
      ));
    } else if (response is DataFailure) {
      emit(LoginFailure(response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(LoginFailure(appState.localization.somethingWentWrong));
    }
  }
}
