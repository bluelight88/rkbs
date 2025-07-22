part of 'provider_detail_bloc.dart';

sealed class ProviderDetailState extends Equatable {
  const ProviderDetailState();

  @override
  List<Object> get props => [];
}

final class ProviderDetailInitial extends ProviderDetailState {}

final class ProviderDetailLoading extends ProviderDetailState {}

final class ProviderDetailSuccess extends ProviderDetailState {
  final ProviderDetailModel providerDetailModel;

  const ProviderDetailSuccess({required this.providerDetailModel});
}

final class ProviderDetailFailure extends ProviderDetailState {
  final String message;

  const ProviderDetailFailure({required this.message});
}
