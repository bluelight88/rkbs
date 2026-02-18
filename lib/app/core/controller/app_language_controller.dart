import 'package:flutter/material.dart';

import '../../utils/constants/app_constants.dart';
import '../../utils/manager/get_it_manager.dart';
import '../../utils/manager/storage_manager.dart';

final class AppLanguageController extends ChangeNotifier {
  Locale _appLocale = const Locale(AppConstants.localeAr);

  Locale get appLocal => _appLocale;

  AppLanguageController() {
    fetchLocale();
  }

  Future<void> fetchLocale() async {
    String? locale = await getIt<StorageManager>().getData(
      AppConstants.languageCode,
    );
    _appLocale = Locale(locale ?? AppConstants.localeAr);
    notifyListeners();
  }

  Future<void> changeLanguage(String locale) async {
    _appLocale = Locale(locale);
    await getIt<StorageManager>().saveData(AppConstants.languageCode, locale);
    await getIt<StorageManager>().saveData(AppConstants.countryCode, '');
    notifyListeners();
  }
}
