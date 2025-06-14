import 'package:flutter/foundation.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../core/models/api/exceptions.dart';
import '../../../../utils/constants/apis.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/manager/api_controller.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/manager/storage_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../login_model.dart';

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
      appState.setUserId = "${loginModel.uid}";
      appState.setUserName = loginModel.name;
      final StorageManager storageManager = getIt<StorageManager>();
      await storageManager.saveIntData(AppConstants.userId, loginModel.uid);
      await storageManager.saveData(AppConstants.name, loginModel.name);
      return DataSuccess(loginModel);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> sendOtpSms(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.sendOtp,
        APIMethod.post,
        param: params,
      );
      return DataSuccess(response.data);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}
