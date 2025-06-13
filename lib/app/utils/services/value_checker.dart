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
}
