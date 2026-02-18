import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/core/models/api/data_state.dart';
import 'package:timoraa/app/modules/dashboard/model/home_data_model.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

import '../../../../utils/manager/get_it_manager.dart';
import '../../model/dashboard_repo_model.dart';

part 'search_event.dart';

part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<GetSearchRecord>(_getSearchRecord);
  }

  void _getSearchRecord(
    GetSearchRecord event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    final Map<String, dynamic> params = {};
    final response = await getIt<DashBoardRepo>().getSearchData(params);
    if (response is DataSuccess) {
      emit(SearchSuccess(response.data));
    } else if (response is DataFailure) {
      emit(SearchFailure(response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(SearchFailure(appState.localization.somethingWentWrong));
    }
  }
}
