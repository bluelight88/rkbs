import 'package:flutter/foundation.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../core/models/api/exceptions.dart';
import '../../../../utils/constants/apis.dart';
import '../../../../utils/manager/api_controller.dart';
import '../../../../utils/manager/get_it_manager.dart';
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
      return DataSuccess(loginModel);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}
