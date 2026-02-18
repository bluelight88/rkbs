import 'package:timoraa/app/core/models/api/data_state.dart';
import 'package:timoraa/app/core/models/api/exceptions.dart';
import 'package:timoraa/app/modules/auth/model/register_model.dart';
import 'package:timoraa/app/utils/constants/apis.dart';
import 'package:timoraa/app/utils/manager/api_controller.dart';
import 'package:timoraa/app/utils/manager/get_it_manager.dart';

final class RegisterRepo {
  Future<DataState> registerNativeCustomer(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.registerNativeCustomer,
        APIMethod.post,
        param: params,
      );
      var data = response.data;
      final model = RegisterModel(
        customerId: data ?? 0,
      );
      return DataSuccess(model);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}