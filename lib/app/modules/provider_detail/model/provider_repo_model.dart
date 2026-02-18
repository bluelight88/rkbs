import 'dart:convert';
import 'package:timoraa/app/modules/provider_detail/model/provider_detail_model.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_review_model.dart';

import '../../../core/models/api/data_state.dart';
import '../../../core/models/api/exceptions.dart';
import '../../../utils/constants/apis.dart';
import '../../../utils/manager/api_controller.dart';
import '../../../utils/manager/get_it_manager.dart';

final class ProviderRepo {
  Future<DataState> fetchProviderDetail(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.providerDetail,
        APIMethod.get,
        param: params,
      );
      final provideDetail = ProviderDetailModel.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
      );
      return DataSuccess(provideDetail);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }

  Future<DataState> fetchProviderReviews(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.providerreview,
        APIMethod.get,
        param: params,
      );
      final rawData = response.data is String
        ? jsonDecode(response.data)
        : response.data;
      final reviewData = ProviderReviewData.fromJson(rawData);
      return DataSuccess<ProviderReviewData>(reviewData);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}
