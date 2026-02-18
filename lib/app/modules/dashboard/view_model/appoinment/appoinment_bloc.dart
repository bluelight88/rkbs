import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/core/models/api/data_state.dart';
import 'package:timoraa/app/utils/services/app_state.dart';
import 'package:timoraa/app/modules/dashboard/model/appoinment_data_model.dart';

import '../../../../utils/manager/get_it_manager.dart';
import '../../model/dashboard_repo_model.dart';

part 'appoinment_event.dart';

part 'appoinment_state.dart';

class AppoinmentBloc extends Bloc<AppoinmentEvent, AppoinmentState> {
  AppoinmentBloc() : super(AppoinmentInitial()) {
    on<GetAppoinmentRecord>(_getAppoinmentRecord);
  }

  void _getAppoinmentRecord(GetAppoinmentRecord event, Emitter<AppoinmentState> emit) async {
    emit(AppoinmentLoading());
    final Map<String, dynamic> params = {"customer_id":event.customerId};
    final response = await getIt<DashBoardRepo>().getAppoinmentData(params);
    if (response is DataSuccess) {
      emit(AppoinmentSuccess(response.data));
    } else if (response is DataFailure) {
      emit(AppoinmentFailure(response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(AppoinmentFailure(appState.localization.somethingWentWrong));
    }
  }
}
