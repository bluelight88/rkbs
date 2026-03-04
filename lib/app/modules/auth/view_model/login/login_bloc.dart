import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/manager/storage_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../../model/repo/auth_repo.dart';

part 'login_event.dart';

part 'login_state.dart';

final class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<UserLogin>(_userLogin);
    on<SocialLoginEvent>(_onSocialLogin);
  }

  void _userLogin(UserLogin event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final deviceInfo = await _getDeviceInfo();
    final headerData = {
      "customer_email": event.email,
      "customer_password": event.password,
    };

    final deviceData = {
      "device_id": deviceInfo["device_id"],
      "device_type": deviceInfo["device_type"],
      "device_unique_id": deviceInfo["device_unique_id"],
    };

    final Map<String, dynamic> params = {
      "headerData": jsonEncode(headerData),
      "deviceInfo": jsonEncode(deviceData),
    };

    final response = await getIt<AuthRepo>().login(params);
    if (response is DataSuccess) {
      await _handleLoginResponse(response, emit);
    } else if (response is DataFailure) {
      emit(LoginFailure(response.error.description));
    } else if (response is UnknownDataFailure) {
      emit(LoginFailure(appState.localization.somethingWentWrong));
    }
  }

  void _onSocialLogin(SocialLoginEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoading());
    final deviceInfo = await _getDeviceInfo();

    final response = await getIt<AuthRepo>().socialLogin(
      provider: event.provider,
      idToken: event.idToken,
      deviceToken: deviceInfo["device_id"] ?? "",
      deviceUniqueId: deviceInfo["device_unique_id"] ?? "",
    );

    if (response is DataSuccess) {
      await _handleLoginResponse(response, emit);
    } else if (response is DataFailure) {
      emit(LoginFailure(response.error.description));
    } else if (response is UnknownDataFailure) {
      emit(LoginFailure(appState.localization.somethingWentWrong));
    }
  }

  Future<void> _handleLoginResponse(
    DataSuccess response,
    Emitter<LoginState> emit,
  ) async {
    if (response.data.customerId == 0) {
      String errorMessage = response.data.loginMessage;
      if (errorMessage == "PasswordDoesNotMatch") {
        errorMessage = "Invalid email or password";
      } else if (errorMessage.isEmpty) {
        errorMessage = "Invalid credentials";
      }

      emit(LoginFailure(errorMessage));
      return;
    }

    appState.setUserId = "${response.data.customerId}";
    appState.setUserName = response.data.customerName;
    appState.loginUserName.value = response.data.customerName;
    appState.setSessionId = response.data.sessionId;
    appState.setUserImage = response.data.customerImg;
    await getIt<StorageManager>().saveIntData(
      AppConstants.userId,
      response.data.customerId,
    );
    await getIt<StorageManager>().saveData(
      AppConstants.name,
      response.data.customerName,
    );
    await getIt<StorageManager>().saveData(
      AppConstants.sessionId,
      response.data.sessionId,
    );
    await getIt<StorageManager>().saveData(
      AppConstants.userImage,
      response.data.customerImg,
    );

    emit(const LoginSuccess(msg: "Login Success"));
  }

  Future<Map<String, dynamic>> _getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfoPlugin.androidInfo;
      return {
        "device_id": androidInfo.id,
        "device_type": "android",
        "device_unique_id": androidInfo.id,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfoPlugin.iosInfo;
      return {
        "device_id": iosInfo.identifierForVendor,
        "device_type": "ios",
        "device_unique_id": iosInfo.identifierForVendor,
      };
    }

    return {
      "device_id": "unknown",
      "device_type": "unknown",
      "device_unique_id": "unknown",
    };
  }
}
