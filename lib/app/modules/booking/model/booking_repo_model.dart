import 'dart:convert';

import '../../../core/models/api/data_state.dart';
import '../../../core/models/api/exceptions.dart';
import '../../../utils/constants/apis.dart';
import '../../../utils/manager/api_controller.dart';
import '../../../utils/manager/get_it_manager.dart';
import 'booked_service_model.dart';
import 'booking_service_slot_model.dart';

final class BookingRepoModel {
  Future<DataState> getBooking(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.bookAppointmentDetails,
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

  Future<DataState> doBooking(Map<String, dynamic> params) async {
    try {
      final response = await getIt<APIController>().request(
        APIS.bookAppointment,
        APIMethod.post,
        param: params,
      );
      final bookingResponse = BookingObj.fromJson(
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
