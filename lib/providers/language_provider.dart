import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class LanguageProvider with ChangeNotifier {
  Locale _locale = const Locale('en'); // Default to English

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (_locale != locale) {
      _locale = locale;
      notifyListeners();
    }
  }

  void setLanguageCode(String languageCode) {
    setLocale(Locale(languageCode));
  }
}


