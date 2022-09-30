import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalsController extends GetxController {
  Locale _currentLocale = Locale('en', 'US');
  Locale get currenetLocale => _currentLocale;
  void SetEnglishLocale() {
    _currentLocale = Locale('en', 'US');
    Get.updateLocale(_currentLocale);
    saveLocale(false);
    update();
  }

  void SetArabicLocale() {
    _currentLocale = Locale('ar', 'SYR');
    Get.updateLocale(_currentLocale);
    saveLocale(true);

    update();
  }

  Future saveLocale(bool lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("lang", lang);
  }

  Future<bool> getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("lang") ?? false;
  }
}
