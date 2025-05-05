import 'package:flutter/material.dart';

abstract class Localization {
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  String get appName;

  String get comingSoon;

  String get enterValidEmail;

  String get enterValidMobileNumber;

  String get enterValidValue;

  String get error;

  String get fromSettings;

  String get ok;

  String get no;

  String get pageNotFound;

  String get passwordCantBeEmpty;

  String get passwordValidation;

  String get permissions;

  String get permissionNotGranted;

  String get pleaseGrant;

  String get refresh;

  String get serverTimeout;

  String get somethingWentWrong;

  String get yes;

  String get yourSessionExpired;

  String get underDevelopment;
}
