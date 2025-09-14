import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/modules/auth/model/splash_response_model.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/manager/storage_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../../model/repo/auth_repo.dart';

part 'splash_init_event.dart';

part 'splash_init_state.dart';

final class SplashInitBloc extends Bloc<SplashInitEvent, SplashInitState> {
  SplashInitBloc() : super(SplashInitInitial()) {
    on<UserSplashInit>(_userSplashInit);
  }

  void _userSplashInit(
    UserSplashInit event,
    Emitter<SplashInitState> emit,
  ) async {
    emit(SplashInitLoading());
    final deviceInfo = await _getDeviceInfo();
    final deviceData = {
      "device_id": deviceInfo["device_id"],
      "device_type": deviceInfo["device_type"],
      "device_unique_id": deviceInfo["device_unique_id"],
      "ip_address": appState.ipAddress.value,
      "country_code": appState.countryCode.value,
    };
    final Map<String, dynamic> params = {"deviceInfo": jsonEncode(deviceData)};

    final response = await getIt<AuthRepo>().initApp(params);
    if (response is DataSuccess) {
      await getIt<StorageManager>().saveData(
        AppConstants.accessToken,
        response.data.accessToken,
      );
      appState.setAccessToken = response.data.accessToken;
      appState.currencyId.value = response.data.currencyId;
      appState.countryId.value = response.data.countryId;
      emit(SplashInitSuccess(model: response.data));
    } else if (response is DataFailure) {
      emit(SplashInitFailure(response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(SplashInitFailure(appState.localization.somethingWentWrong));
    }
  }
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
      "device_type": iosInfo.systemName,
      "device_unique_id": iosInfo.identifierForVendor,
    };
  }

  return {
    "device_id": "unknown",
    "device_type": "unknown",
    "device_unique_id": "unknown",
  };
}
