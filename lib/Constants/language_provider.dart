

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {

  static const List<Map<String, dynamic>> languages = [
    {
      'name': 'English',
      'locale': 'en',
    },
    {
      'name': 'Spanish',
      'locale': 'es',
    },
    {
      'name': 'Catalan',
      'locale': 'ca',
    }
  ];

  Locale selectedLocale = Locale('en');

  LanguageProvider() {
    _loadSavedLanguage();
  }

  void changeLanguage(String language) async {
    selectedLocale = Locale(language);
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLanguage', language);
  }

  void _loadSavedLanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedLanguage = prefs.getString('selectedLanguage');
    if (savedLanguage != null) {
      selectedLocale = Locale(savedLanguage);
      notifyListeners();
    }
  }
}
