import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/first_time_using_app.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/locals.dart';
import 'package:safqa/pages/splash_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool lang = prefs.getBool('lang') ?? false;
  runApp(MyApp(
    lang: lang,
  ));
}

void logSuccess(Object msg) {
  developer.log('\x1B[32m${msg.toString()}\x1B[0m');
}

void logInfo(Object msg) {
  developer.log('\x1B[34m${msg.toString()}\x1B[0m');
}

void logWarning(Object msg) {
  developer.log('\x1B[33m${msg.toString()}\x1B[0m');
}

void logError(Object msg) {
  developer.log('\x1B[31m${msg.toString()}\x1B[0m');
}

class MyApp extends StatelessWidget {
  MyApp({super.key, this.lang});
  final bool? lang;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirstTimeUsingAppController _firstTimeController =
        Get.put(FirstTimeUsingAppController());
    LocalsController localsController = Get.put(LocalsController());

    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: lang! ? Locale('ar', 'SYR') : Locale('en', 'US'),
        translations: LocaleString(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Color(0xff2F6782),
          canvasColor: Colors.white,
          fontFamily: "Tajawal",
        ),
        home: SplashPage(),
      ),
    );
  }
}
