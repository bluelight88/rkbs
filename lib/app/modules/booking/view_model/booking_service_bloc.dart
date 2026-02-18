import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/api/data_state.dart';
import '../../../utils/manager/get_it_manager.dart';
import '../../../utils/services/app_state.dart';
import '../model/booked_service_model.dart';
import '../model/booking_repo_model.dart';
import '../model/booking_service_slot_model.dart';

part 'booking_service_event.dart';

part 'booking_service_state.dart';

class BookingServiceBloc
    extends Bloc<BookingServiceEvent, BookingServiceState> {
  BookingServiceBloc() : super(BookingServiceInitial()) {
    on<BookingServiceList>(_getBookingServiceRecord);
    on<BookService>(_doBook);
  }

  void _getBookingServiceRecord(
    BookingServiceList event,
    Emitter<BookingServiceState> emit,
  ) async {
    emit(BookingServiceLoading());
    final Map<String, dynamic> params = {
      'provider_id': event.providerId,
      'service_id': event.serviceId,
      'staff_id': event.staffId,
      'dt': event.date,
    };
    final response = await getIt<BookingRepoModel>().getBooking(params);
    if (response is DataSuccess) {
      emit(BookingServiceSuccess(model: response.data));
    } else if (response is DataFailure) {
      emit(BookingServiceFailure(message: response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(
        BookingServiceFailure(
          message: appState.localization.somethingWentWrong,
        ),
      );
    }
  }

  void _doBook(BookService event, Emitter<BookingServiceState> emit) async {
    emit(DoBookServiceLoading());

    final headerData = appState.cartItems;
    final customerData = int.parse(appState.userId);
    final paymentData = [];

    final Map<String, dynamic> params = {
      "booking_details": jsonEncode(headerData),
      "customer_id": jsonEncode(customerData),
      "payment_details": jsonEncode(paymentData),
    };
    final response = await getIt<BookingRepoModel>().doBooking(params);
    if (response is DataSuccess) {
      if (response.data.status.toLowerCase() == "success") {
        emit(DoBookServiceSuccess(model: response.data));
      } else {
        emit(
          DoBookServiceFailure(
            message:
                response.data.msg.isNotEmpty
                    ? response.data.msg
                    : "Booking failed",
          ),
        );
      }
    } else if (response is DataFailure) {
      emit(DoBookServiceFailure(message: response.error.description));
    } else if (response is UnknownDataFailure) {
      emit(
        DoBookServiceFailure(message: appState.localization.somethingWentWrong),
      );
    }
  }
}
