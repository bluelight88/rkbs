import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/core/models/api/data_state.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/manager/get_it_manager.dart';
import '../../model/dashboard_repo_model.dart';
import '../../model/home_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<GetHomeRecord>(_getHomeRecord);
  }

  void _getHomeRecord(GetHomeRecord event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    final Map<String, dynamic> params = {};
    final response = await getIt<DashBoardRepo>().getHomeData(params);
    if (response is DataSuccess) {
      emit(HomeSuccess(response.data));
    } else if (response is DataFailure) {
      emit(HomeFailure(response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(HomeFailure(appState.localization.somethingWentWrong));
    }
  }
}
