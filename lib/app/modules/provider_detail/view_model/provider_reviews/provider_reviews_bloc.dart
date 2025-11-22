import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/modules/provider_detail/model/provider_repo_model.dart';

import '../../../../core/models/api/data_state.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/services/app_state.dart';

import '../../model/provider_review_model.dart';

part 'provider_reviews_event.dart';

part 'provider_reviews_state.dart';

class ProviderReviewsBloc
    extends Bloc<ProviderReviewsEvent, ProviderReviewsState> {
  ProviderReviewsBloc() : super(ProviderReviewsInitial()) {
    on<FetchProviderReview>(_getfetchProviderReviews);
  }

  void _getfetchProviderReviews(FetchProviderReview event, Emitter<ProviderReviewsState> emit) async {
    emit(ProviderReviewLoading());
    final Map<String, dynamic> params = {"provider_id":event.providerId};
    final response = await getIt<ProviderRepo>().fetchProviderReviews(params);
    if (response is DataSuccess) {
      emit(ProviderReviewSuccess(providerReviewmodel: response.data));
    } else if (response is DataFailure) {
      emit(ProviderReviewFailure(message:response.error.description));
    }
    if (response is UnknownDataFailure) {
      emit(ProviderReviewFailure(message:appState.localization.somethingWentWrong));
    }
  }
}

