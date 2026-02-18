part of 'provider_detail_bloc.dart';

sealed class ProviderDetailEvent extends Equatable {
  const ProviderDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchProviderDetail extends ProviderDetailEvent {
  final int providerId;

  const FetchProviderDetail({required this.providerId});
}
