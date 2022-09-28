import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/select_language_page.dart';
import 'package:sizer/sizer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(() => SelectLanguagePage(),
          duration: Duration(milliseconds: 1200));
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
