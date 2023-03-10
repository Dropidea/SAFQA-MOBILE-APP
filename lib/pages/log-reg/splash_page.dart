import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/controller/admin_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/home/home_page.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/first_time_using_app.dart';
import 'select_language_page.dart';
import 'welcome_page.dart';

class SplashPage extends StatelessWidget {
  SplashPage({super.key});

  LoginController loginController = Get.put(LoginController());
  FirstTimeUsingAppController _firstTimeController = Get.find();
  LocalsController localsController = Get.put(LocalsController());
  AdminController _adminController = Get.put(AdminController());
  GlobalDataController _globalDataController = Get.put(GlobalDataController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await localsController.getLocale();
      await Future.delayed(const Duration(seconds: 1));
      await _firstTimeController.setFirstTimeUsing();
      if (await _firstTimeController.checkIfFirstTimeUsingApp()) {
        Get.offAll(
          () => SelectLanguagePage(),
          duration: Duration(milliseconds: 1200),
        );
      } else {
        var email = await AuthService().loadEmail();
        var password = await AuthService().loadPassword();
        var rem = await AuthService().loadRememberMe();
        if (email != "" && password != "") {
          try {
            await AuthService().login(email, password, rem);
            await _globalDataController.getMe();

            if (_globalDataController.me.isSuperAdmin != null)
              _adminController.setIsAdmin(true);
            else
              _adminController.setIsAdmin(false);

            Get.offAll(
              () => HomePage(),
            );
          } on DioError catch (e) {
            logError(e.message);
            Get.offAll(
              () => WelcomePage(),
            );
          }
        } else {
          Get.offAll(
            () => WelcomePage(),
            duration: Duration(milliseconds: 1200),
          );
        }
      }
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xff2F6782),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [
              0.1,
              0.49,
              0.51,
              0.9,
            ],
            colors: [
              Color(0xff2F6782),
              Colors.white.withAlpha(250),
              Colors.white.withAlpha(250),
              Color(0xff2F6782),
            ],
          )),
          width: double.maxFinite,
          height: double.maxFinite,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Get.to(
                  () => SelectLanguagePage(),
                  transition: Transition.fade,
                  duration: Duration(seconds: 1),
                );
              },
              child: Hero(
                tag: "logo",
                child: Image(
                  image: AssetImage(
                    "assets/images/logo/logo.png",
                  ),
                  width: 100.0.sp,
                  height: 120.0.sp,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
