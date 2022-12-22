import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalsController extends GetxController {
  final _engLocal = const Locale('en', 'US');
  final _arLocal = const Locale('ar', 'SYR');
  Locale _currentLocale = Locale('en', 'US');
  // Locale get currenetLocale => _currentLocale;
  int get currenetLocale => _currentLocale == _engLocal ? 0 : 1;
  Future<void> SetEnglishLocale() async {
    _currentLocale = _engLocal;
    await Get.updateLocale(_currentLocale);
    await saveLocale(false);
  }

  Future<void> SetArabicLocale() async {
    _currentLocale = _arLocal;
    await Get.updateLocale(_currentLocale);
    await saveLocale(true);
  }

  Future saveLocale(bool lang) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("lang", lang);
  }

  Future getLocale() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("lang") != null) {
      _currentLocale = prefs.getBool("lang")! ? _arLocal : _engLocal;
    } else {
      return _engLocal;
    }
    // return prefs.getBool("lang") ?? false;
  }
}
