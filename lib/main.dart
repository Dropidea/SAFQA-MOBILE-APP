import 'dart:developer' as developer;
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  // This widget is the root of your application.aa
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
          // primarySwatch: Colors.,
          // colorScheme: Colors.red,
          primaryColor: Color(0xff2F6782),
          canvasColor: Colors.white,
          fontFamily: "Tajawal",
        ),
        home: SplashPage(),
      ),
    );
  }
}
