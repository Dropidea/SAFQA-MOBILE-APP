import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/locals_controller.dart';
import '../../main.dart';
import 'intro_page.dart';

class SelectLanguagePage extends StatelessWidget {
  const SelectLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    LocalsController localsController = Get.find();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xff2F6782),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: w,
                  height: h / 3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/images/language_page_wallpaper.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            Container(
              width: w,
              height: h,
              padding: EdgeInsets.only(top: 0.05 * h),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 0.07 * h, bottom: 0.07 * h),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 0.07 * h),
                    child: Text(
                      "Please choose the language",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff5D5E60),
                        fontSize: 20.0.sp,
                      ),
                    ),
                  ),
                  Container(
                    width: 0.7 * w,
                    height: 45.0.sp,
                    decoration: BoxDecoration(
                      color: Color(0xff2F6782),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      onTap: () {
                        localsController.SetArabicLocale();
                        logError(Localizations.localeOf(context).languageCode);
                        Get.to(() => IntroPage(),
                            transition: Transition.rightToLeft);
                      },
                      child: Center(
                        child: Text(
                          "العربية",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0.sp,
                  ),
                  Container(
                    width: 0.7 * w,
                    height: 45.0.sp,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xffB1B1B1), width: 2),
                    ),
                    child: InkWell(
                      onTap: () {
                        localsController.SetEnglishLocale();
                        Get.to(() => IntroPage(),
                            transition: Transition.rightToLeft);
                      },
                      child: Center(
                        child: Text(
                          "English",
                          style: TextStyle(
                            color: Color(0xffB1B1B1),
                            fontSize: 18.0.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
