import 'package:flutter/material.dart';

import '../services/app_state.dart';
import 'ar_localization.dart';
import 'en_localization.dart';
import 'localization.dart';

final class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static Localization? of(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<Localization> delegate =
      _AppLocalizationsDelegate();

  Future<Localization> load() async {
    debugPrint('load method: ${locale.languageCode}');
    appState.localization = switch (locale.languageCode) {
      'en' => EnLocalization(),
      'ar' => ArLocalization(),
      _ => ArLocalization(),
    };
    return appState.localization;
  }

  // This method will be called from every widget which needs a localized text
  // String translate(String key) => _localizedStrings[key] ?? '';
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
final class _AppLocalizationsDelegate
    extends LocalizationsDelegate<Localization> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'ar'].contains(locale.languageCode);
  }

  @override
  Future<Localization> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    appState.localization = switch (locale.languageCode) {
      'en' => EnLocalization(),
      'ar' => ArLocalization(),
      _ => ArLocalization(),
    };
    // await localizations.load();
    return appState.localization;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
