import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timoraa/app/modules/auth/model/register_model.dart';
import 'package:timoraa/app/modules/auth/model/repo/register_repo.dart';
import '../../../../core/models/api/data_state.dart';
import '../../../../utils/manager/get_it_manager.dart';
import '../../../../utils/services/app_state.dart';


part 'register_event.dart';

part 'register_state.dart';

final class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<CustomerRegister>(_customerRegister);
  }

  void _customerRegister(CustomerRegister event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    final headerData = {
      "customer_email": event.email,
      "customer_name":event.name,
      "customer_password": event.password,
      "customer_mobilenumber" : event.mobilenumber,
      "country_id":""
    };
    final Map<String, dynamic> params = {
      "headerData": jsonEncode(headerData)
    };

    final response =
    await getIt<RegisterRepo>().registerNativeCustomer(params);

    if (response is DataSuccess<RegisterModel>) {
      emit(RegisterSuccess(model: response.data));
    } 
    else if (response is DataFailure) {
      emit(RegisterFailure(message: response.error.description));
    } 
    else if (response is UnknownDataFailure) {
      emit(
        RegisterFailure(
          message: appState.localization.somethingWentWrong,
        ),
      );
    }
  }
}