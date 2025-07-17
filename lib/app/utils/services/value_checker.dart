import 'dart:convert';
import 'dart:ui' as ui;

import 'package:http/http.dart' as http;

import '../../modules/auth/model/repo/country_info_model.dart';
import 'app_state.dart';

final class ValueChecker {
  static final ValueChecker instance = ValueChecker._();

  factory ValueChecker() => instance;

  ValueChecker._();

  String? emailValidator(String? value) {
    final RegExp regExp = RegExp(r'^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+$');
    if (value!.isEmpty) {
      return appState.localization.enterValidEmail;
    } else {
      if (!regExp.hasMatch(value)) {
        return appState.localization.enterValidEmail;
      } else {
        return null;
      }
    }
  }

  String? mobileNumberValidator(String? value) {
    final RegExp regExp = RegExp(
      r'^((?:[+?0?0?966]+)(?:\s?\d{2})(?:\s?\d{7}))$',
    );
    if (value!.isEmpty || value.length != 10) {
      return appState.localization.enterValidMobileNumber;
    } else {
      if (!regExp.hasMatch(value)) {
        return appState.localization.enterValidMobileNumber;
      } else {
        return null;
      }
    }
  }

  String? numericValidator(String? value) {
    final RegExp regExp = RegExp(r'^[0-9]*$');
    if (value!.isEmpty) {
      return appState.localization.enterValidValue;
    } else {
      if (!regExp.hasMatch(value)) {
        return appState.localization.enterValidValue;
      } else {
        return null;
      }
    }
  }

  String? passwordValidator(String? value, {String passwordText = ''}) {
    RegExp regExp = RegExp(
      r'^(?=.*?[A-Z])(?=.*[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    );
    if (value!.isEmpty) {
      return passwordText.isNotEmpty
          ? passwordText
          : appState.localization.passwordCantBeEmpty;
    } else {
      if (!regExp.hasMatch(value)) {
        return appState.localization.passwordValidation;
      }
    }
    return null;
  }

  String getCountryCodeFromDeviceLocale() {
    final locale = ui.PlatformDispatcher.instance.locale;
    return locale.countryCode ?? 'US';
  }

  Future<CountryInfo> getUserLocationInfo() async {
    try {
      final response = await http.get(Uri.parse('https://ipinfo.io/json'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return CountryInfo.fromJson(data);
      } else {
        return CountryInfo(
          countryCode: getCountryCodeFromDeviceLocale(),
          ipAddress: '0.0.0.0',
        );
      }
    } catch (e) {
      return CountryInfo(
        countryCode: getCountryCodeFromDeviceLocale(),
        ipAddress: '0.0.0.0',
      );
    }
  }
}
