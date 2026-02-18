part of 'register_bloc.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

final class CustomerRegister extends RegisterEvent {
  final String email,name,mobilenumber, password;

  const CustomerRegister({required this.email,required this.name,required this.mobilenumber, required this.password});
}