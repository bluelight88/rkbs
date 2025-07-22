import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_repo_model.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/services/app_state.dart';
import '../../model/provider_detail_model.dart';

part 'provider_detail_event.dart';

part 'provider_detail_state.dart';

class ProviderDetailBloc
    extends Bloc<ProviderDetailEvent, ProviderDetailState> {
  ProviderDetailBloc() : super(ProviderDetailInitial()) {
    on<FetchProviderDetail>(_fetchProviderDetail);
  }

  void _fetchProviderDetail(
    FetchProviderDetail event,
    Emitter<ProviderDetailState> emit,
  ) async {
    emit(ProviderDetailLoading());
    final Map<String, dynamic> params = {
      "provider_id": event.providerId,
      "memeber_id": 0,
    };
    final response = await getIt<ProviderRepo>().fetchProviderDetail(params);
    if (response is DataSuccess) {
      emit(ProviderDetailSuccess(providerDetailModel: response.data));
    } else if (response is DataFailure) {
      emit(ProviderDetailFailure(message: response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(
        ProviderDetailFailure(
          message: appState.localization.somethingWentWrong,
        ),
      );
    }
  }
}
