import 'dart:convert';

import 'package:timoraa/app/core/models/api/data_state.dart';
import 'package:timoraa/app/core/models/api/exceptions.dart';
import 'package:timoraa/app/modules/dashboard/model/appoinment_data_model.dart';
import 'package:timoraa/app/utils/constants/apis.dart';
import 'package:timoraa/app/utils/manager/api_controller.dart';
import 'package:timoraa/app/utils/manager/get_it_manager.dart';

import 'home_data_model.dart';

final class DashBoardRepo {
  Future<DataState> getHomeData(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.home,
        APIMethod.get,
        param: params,
      );
      final homeResponse = HomeObj.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
      );
      return DataSuccess(homeResponse);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> getSearchData(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.home,
        APIMethod.get,
        param: params,
      );
      final homeResponse = HomeObj.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
      );
      return DataSuccess(homeResponse);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> getAppoinmentData(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.appoinment,
        APIMethod.get,
        param: params,
      );
      final List<dynamic> lstdata = response.data;
      final appoinmentObj = AppoinmentObj.fromJson({
        'obj': lstdata, 
      });
      return DataSuccess(appoinmentObj.lstappointment);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}
