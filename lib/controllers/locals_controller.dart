import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LocalsController extends GetxController {
  List<Locale> _locales = [Locale('ar', 'SYR'), Locale('en', 'US')];
  Locale _currentLocale = Locale('en', 'US');
  Locale get currenetLocale => _currentLocale;
  void SetEnglishLocale() {
    _currentLocale = Locale('en', 'US');
    Get.updateLocale(_currentLocale);
    update();
  }

  void SetArabicLocale() {
    _currentLocale = Locale('ar', 'SYR');
    Get.updateLocale(_currentLocale);

    update();
  }
}
