import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safqa/themes/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'controllers/first_time_using_app.dart';
import 'controllers/locals_controller.dart';
import 'locals.dart';
import 'pages/log-reg/splash_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool lang = prefs.getBool('lang') ?? false;
  HttpOverrides.global = new MyHttpOverrides();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
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
  // This widget is the rooasdt of your application.aa شسيشس
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
        darkTheme: Themes().darkTheme,
        themeMode: ThemeMode.light,
        locale: lang! ? Locale('ar', 'SYR') : Locale('en', 'US'),
        translations: LocaleString(),
        title: 'Flutter Demo',
        theme: Themes().lightTheme,
        home: SplashPage(),
      ),
    );
  }
}
