import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/models/api/data_state.dart';
import '../../../utils/manager/get_it_manager.dart';
import '../../../utils/services/app_state.dart';
import '../model/booking_repo_model.dart';
import '../model/booking_service_slot_model.dart';

part 'booking_service_event.dart';

part 'booking_service_state.dart';

class BookingServiceBloc
    extends Bloc<BookingServiceEvent, BookingServiceState> {
  BookingServiceBloc() : super(BookingServiceInitial()) {
    on<BookingServiceList>(_getBookingServiceRecord);
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
}
