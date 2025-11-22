part of 'provider_reviews_bloc.dart';

sealed class ProviderReviewsState extends Equatable {
  const ProviderReviewsState();

  @override
  List<Object> get props => [];
}

final class ProviderReviewsInitial extends ProviderReviewsState {}

final class ProviderReviewLoading extends ProviderReviewsState {}

final class ProviderReviewSuccess extends ProviderReviewsState {
  final ProviderReviewData providerReviewmodel;

  const ProviderReviewSuccess({required this.providerReviewmodel});
}

final class  ProviderReviewFailure extends ProviderReviewsState {
  final String message;

  const ProviderReviewFailure({required this.message});
}
