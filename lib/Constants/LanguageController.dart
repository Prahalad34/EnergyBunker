

import 'dart:ui';

import 'package:get/get.dart';

class LanguageController extends GetxController{
  var selectedLocale = Locale('en', 'US').obs;

  void updateLanguage(Locale locale) {
    selectedLocale.value = locale;
    Get.updateLocale(locale);
  }

}