import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../core/models/api/exceptions.dart';
import '../../../../utils/constants/apis.dart';
import '../../../../utils/manager/api_controller.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../login_model.dart';
import '../splash_response_model.dart';

final class AuthRepo {
  Future<DataState> login(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.loginAPI,
        APIMethod.post,
        param: params,
      );
      final LoginModel loginModel =
          await compute<Map<String, dynamic>, LoginModel>(
            LoginModel.fromJson,
            response.data,
          );
      return DataSuccess(loginModel);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> initApp(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.initApp,
        APIMethod.post,
        param: params,
      );
      final SplashResponseModel splashResponseModel =
          await compute<Map<String, dynamic>, SplashResponseModel>(
            SplashResponseModel.fromJson,
            response.data,
          );
      return DataSuccess(splashResponseModel);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> socialLogin({
    required String provider,
    required String idToken,
    required String deviceToken,
    required String deviceUniqueId,
  }) async {
    try {
      final prepareData = jsonEncode({
        "social_provider": provider,
        "social_id_token": idToken,
      });

      final devicePreparedData = jsonEncode({
        "device_id": deviceToken,
        "device_type": Platform.isAndroid ? "android" : "ios",
        "device_unique_id": deviceUniqueId,
      });

      final Map<String, dynamic> params = {
        "headerData": prepareData,
        "deviceInfo": devicePreparedData,
      };

      final response = await getIt<APIController>().request(
        APIS.socialLogin,
        APIMethod.post,
        param: params,
      );

      final LoginModel loginModel =
          await compute<Map<String, dynamic>, LoginModel>(
            LoginModel.fromJson,
            response.data,
          );
          
      return DataSuccess(loginModel);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}
