

import 'dart:convert';

import '../../../core/models/api/data_state.dart';
import '../../../core/models/api/exceptions.dart';
import '../../../utils/constants/apis.dart';
import '../../../utils/manager/api_controller.dart';
import '../../../utils/manager/get_it_manager.dart';
import 'booking_service_slot_model.dart';

final class BookingRepoModel {
  Future<DataState> getBooking(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.bookAppointment,
        APIMethod.get,
        param: params,
      );
      final bookingResponse = BookingServiceSlotModel.fromJson(
        response.data is String ? jsonDecode(response.data) : response.data,
      );
      return DataSuccess(bookingResponse);
    } on ErrorException catch (e) {
      return DataFailure(e.error);
    } catch (e) {
      return UnknownDataFailure(e);
    }
  }
}