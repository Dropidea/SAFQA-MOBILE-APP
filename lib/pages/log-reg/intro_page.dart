import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/log-reg/welcome_page.dart';
import 'package:sizer/sizer.dart';

import '../../widgets/page_indicator.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pageController = PageController(initialPage: 0, keepPage: false);
  bool flag = false;
  int i = 0;

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
      body: Stack(
        children: [
          i == 1
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Image(
                    image: AssetImage("assets/images/circle1.png"),
                  ),
                )
              : i == 4
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child: Image(
                        image: AssetImage("assets/images/circle2.png"),
                      ),
                    )
                  : Container(),
          Container(
            padding: EdgeInsets.all(20),
            width: w,
            height: h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                flag
                    ? Container()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: Color(0xff2F6782),
                              ),
                            )),
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                _pageController.jumpToPage(4);
                                i = 4;
                                flag = true;
                                setState(() {});
                              },
                              child: Text(
                                "skip".tr,
                                style: TextStyle(
                                  color: Color(0xff2F6782),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0.sp,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                Container(
                  width: w,
                  margin: EdgeInsets.only(top: 20),
                  height: 1.55 * h / 3,
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {
                      i = value;
                      setState(() {});
                    },
                    children: [
                      buildIntroPage(w, h, "assets/images/intro1.png",
                          "generate".tr, "generate_content".tr),
                      buildIntroPage(w, h, "assets/images/intro2.png",
                          "collect".tr, "collect_content".tr),
                      buildIntroPage(w, h, "assets/images/intro3.png",
                          "keep".tr, "keep_content".tr),
                      buildIntroPage(w, h, "assets/images/intro4.png",
                          "sell".tr, "sell_content".tr),
                      buildIntroPage(w, h, "assets/images/intro5.png",
                          "ship".tr, "ship_content".tr),
                    ],
                  ),
                ),
                // _buildCircleIndicator2(),
                PageIndicator(
                  currentValue: i,
                ),
                Visibility(
                  visible: i == 4,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const WelcomePage());
                    },
                    child: Container(
                      width: 0.7 * w,
                      height: 45.0.sp,
                      margin: EdgeInsets.symmetric(vertical: 0.08 * h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color(0xff183441),
                              Color(0xff2F6782),
                            ]),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'start'.tr,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: i != 4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.0.sp,
                        height: 50.0.sp,
                        margin:
                            EdgeInsets.only(left: 20, right: 20, top: 0.1 * h),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xff2F6782),
                                Color(0xff163646),
                              ]),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                            borderRadius: BorderRadius.circular(30.0),
                            onTap: () {
                              i++;
                              _pageController.jumpToPage(i);
                              if (i == 4) {
                                flag = true;
                                setState(() {});
                              }
                            },
                            child: Transform.scale(
                              scaleX:
                                  localsController.currenetLocale == 1 ? -1 : 1,
                              child: Container(
                                width: 15.0.sp,
                                height: 15.0.sp,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      "assets/images/double_forward_icon.png",
                                    ),
                                    scale: 2,
                                  ),
                                ),
                              ),
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildIntroPage(
      double w, double h, String image, String text1, String text2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(20),
          width: w,
          height: 0.3 * h,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          margin:
              EdgeInsets.only(top: 20.0.sp, bottom: 10, left: 20, right: 20),
          child: Text(
            text1,
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, right: 10),
          child: Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff2F6782),
            ),
          ),
        ),
      ],
    );
  }

  // _buildCircleIndicator2() {
  //   return CirclePageIndicator(
  //     size: 15.0,
  //     selectedSize: 18.0,
  //     dotColor: Color(0xffE2EBF5),
  //     selectedDotColor: Color(0xff2F6782),
  //     itemCount: 5,
  //     currentPageNotifier: i,
  //   );
  // }
}
