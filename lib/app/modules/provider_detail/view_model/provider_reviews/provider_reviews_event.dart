part of 'provider_reviews_bloc.dart';

sealed class ProviderReviewsEvent extends Equatable {
  const ProviderReviewsEvent();

  @override
  List<Object?> get props => [];
}
class FetchProviderReview extends ProviderReviewsEvent {
  final int providerId;

  const FetchProviderReview({required this.providerId});
}

