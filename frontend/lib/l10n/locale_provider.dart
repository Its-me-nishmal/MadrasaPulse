import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('en'));

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('ar'),
    Locale('ml'),
    Locale('ur'),
  ];

  static const Locale fallbackLocale = Locale('en');

  void setLocale(Locale locale) {
    if (supportedLocales.contains(locale)) {
      state = locale;
    }
  }

  void toggleLanguage() {
    state = state.languageCode == 'en' ? const Locale('ar') : const Locale('en');
  }

  String get currentLanguageCode => state.languageCode;
}
