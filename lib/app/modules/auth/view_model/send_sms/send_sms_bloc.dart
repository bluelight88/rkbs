import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../../model/repo/auth_repo.dart';

part 'send_sms_event.dart';
part 'send_sms_state.dart';

class SendSmsBloc extends Bloc<SendSmsEvent, SendSmsState> {
  SendSmsBloc() : super(SendSmsInitial()) {
    on<SendSMS>(_sendSms);
  }

  void _sendSms(SendSMS event, Emitter<SendSmsState> emit) async {
    emit(SendSmsLoading());
    final Map<String, dynamic> params = {"mobileNumber": event.mobileNumber};
    final response = await getIt<AuthRepo>().sendOtpSms(params);
    if (response is DataSuccess) {
      emit(SendSmsSuccess(message: "Send Success"));
    } else if (response is DataFailure) {
      emit(SendSmsFailure(message: response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(SendSmsFailure(message: appState.localization.somethingWentWrong));
    }
  }
}
