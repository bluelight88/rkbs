import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:timoraa/app/core/models/cart_service_model.dart';

import '../constants/app_config.dart';
import '../constants/app_constants.dart';
import '../extensions/app_extension.dart';
import '../localization/ar_localization.dart';
import '../localization/localization.dart';
import '../manager/get_it_manager.dart';
import '../manager/storage_manager.dart';
import 'package_services.dart';

final AppState appState = AppState();

final class AppState {
  static final AppState instance = AppState._();

  factory AppState() => instance;

  AppState._();

  final Completer<void> appInitializationCompleter = Completer<void>();

  Localization localization = ArLocalization();

  late Size _screenSize;
  final String _appName = "نهتم";
  String _timeZone = "",
      _sessionId = "",
      _deviceId = "",
      _fcmToken = "",
      _apnsToken = "",
      _userId = "",
      _userName = "-",
      _userImage = "-",
      _userMail = "-",
      _appVersion = "";

  // Getter
  String get appName => _appName;

  String get timeZone => _timeZone;

  String get userId => _userId;

  String get userName => _userName;

  String get userImage => _userImage;

  String get userMail => _userMail;

  String get sessionId => _sessionId;

  String get deviceId => _deviceId;

  String get fcmToken => _fcmToken;

  String get apnsToken => _apnsToken;

  String get appVersion => _appVersion;

  double getScreenHeight({double percent = 1}) => _screenSize.height * percent;

  double getScreenWidth({double percent = 1}) => _screenSize.width * percent;

  // Setter
  set setScreenSize(BuildContext context) =>
      _screenSize = MediaQuery.sizeOf(context);

  set setSessionId(String sessionId) => _sessionId = sessionId;

  set setUserId(String userId) => _userId = userId;

  set setUserName(String userName) => _userName = userName;

  set setUserImage(String userImage) => _userImage = userImage;

  set setUserMail(String userMail) => _userMail = userMail;

  ValueNotifier<String> countryCode = ValueNotifier<String>("UK");
  ValueNotifier<String> ipAddress = ValueNotifier<String>("");
  ValueNotifier<int> appPageIndex = ValueNotifier<int>(0);
  ValueNotifier<double> totalPrice = ValueNotifier<double>(0.0);
  ValueNotifier<String> selectedTimeSlot = ValueNotifier<String>('');
  ValueNotifier<String> loginUserName = ValueNotifier<String>('');
  ValueNotifier<String> selectedSlotInfo = ValueNotifier<String>("");
  ValueNotifier<String> selectedSaloon = ValueNotifier<String>("");
  ValueNotifier<String> selectedSaloonAddress = ValueNotifier<String>("");
  List<CartServiceModel> cartItems = [];

  /// Method to set initial Values
  Future<void> setInitialValues() async {
    _timeZone = await FlutterTimezone.getLocalTimezone();
    _sessionId =
        (await getIt<StorageManager>().getData(AppConstants.sessionId) ?? '');
    debugPrint(
      'Current Env is "${AppConfig.instance.currentEnv.name.capitalize()}"',
    );
    await _setDeviceId();
    await _setPackageInfo();
    // await _setAPNSToken();
    // await _setFCMToken();
  }

  void _clearValues() {
    _sessionId = "";
    _fcmToken = "";
    _apnsToken = "";
    _userId = "";
    _userName = "-";
    _userImage = "-";
    _userMail = "-";
  }

  Future<void> clearAllValues() async {
    _clearValues();
    final storageManager = getIt<StorageManager>();
    try {
      await FirebaseMessaging.instance.deleteToken();
    } catch (e) {
      debugPrint("Error found in FirebaseMessaging.instance.deleteToken => $e");
    }
    await storageManager.clearData();
    await Future.wait([]);
  }

  /// Set Device Id
  Future<void> _setDeviceId() async {
    if (_deviceId.isNotEmpty) return debugPrint("Device Id already assigned.");
    _deviceId = await getIt<PackageServices>().getDeviceId();
    debugPrint("Device Id is => $_deviceId");
  }

  /// Set FCM Token
  // Future<void> _setFCMToken() async {
  //   if (_fcmToken.isNotEmpty) return debugPrint("FCM Token already assigned.");
  //   try {
  //     _fcmToken = (await FirebaseMessaging.instance.getToken() ?? '');
  //     debugPrint("FCM Token is => $_fcmToken");
  //   } catch (e) {
  //     debugPrint("Error found in _setFCMToken => $e");
  //     await _setFCMToken();
  //   }
  // }

  /// Set APNS Token
  // Future<void> _setAPNSToken() async {
  //   if (_apnsToken.isNotEmpty) {
  //     return debugPrint("APNS Token already assigned.");
  //   }
  //   try {
  //     _apnsToken = (await FirebaseMessaging.instance.getAPNSToken() ?? "");
  //     debugPrint("APNS Token is => $_apnsToken");
  //   } catch (e) {
  //     debugPrint("Error found in _setAPNSToken => $e");
  //     await Future.delayed(
  //       const Duration(seconds: 2),
  //       () async => await _setAPNSToken(),
  //     );
  //   }
  // }

  /// Set Package info
  Future<void> _setPackageInfo() async {
    if (_appVersion.isNotEmpty) {
      return debugPrint("App Version is already assigned.");
    }
    try {
      _appVersion = (await PackageInfo.fromPlatform()).version;
      debugPrint("App Version is => $_appVersion");
    } catch (e) {
      debugPrint("Error found in _setPackageInfo => $e");
    }
  }
}
