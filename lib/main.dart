import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/locals.dart';
import 'package:safqa/pages/home.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

void logSuccess(String msg) {
  developer.log('\x1B[32m$msg\x1B[0m');
}

void logInfo(String msg) {
  developer.log('\x1B[34m$msg\x1B[0m');
}

void logWarning(String msg) {
  developer.log('\x1B[33m$msg\x1B[0m');
}

void logError(String msg) {
  developer.log('\x1B[31m$msg\x1B[0m');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    LocalsController localsController = Get.put(LocalsController());
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
              DeviceType deviceType) =>
          GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: localsController.currenetLocale,
        translations: LocaleString(),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          primaryColor: Color(0xff2F6782),
          canvasColor: Colors.white,
          fontFamily: "Tajawal",
        ),
        home: HomePage(),
      ),
    );
  }
}
