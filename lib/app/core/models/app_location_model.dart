import 'package:equatable/equatable.dart';

class AppLocationModel extends Equatable {
  final String postalCode, address;
  final double latitude, longitude;

  const AppLocationModel({
    required this.latitude,
    required this.longitude,
    this.postalCode = "",
    this.address = "",
  });

  @override
  List<Object?> get props => [latitude, longitude];
}
