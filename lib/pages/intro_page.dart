import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:page_view_indicators/circle_page_indicator.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/welcome_page.dart';
import 'package:safqa/widgets/page_indicator.dart';
import 'package:sizer/sizer.dart';

class IntroPage extends StatefulWidget {
  IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final _pageController = PageController();
  bool flag = false;

  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xff2F6782),
      ),
      body: Stack(
        children: [
          _currentPageNotifier.value == 1
              ? Positioned(
                  top: 0,
                  left: 0,
                  child: Image(
                    image: AssetImage("assets/images/circle1.png"),
                  ),
                )
              : _currentPageNotifier.value == 4
                  ? Positioned(
                      right: 0,
                      top: 0,
                      child:
                          Image(image: AssetImage("assets/images/circle2.png")))
                  : Container(),
          Container(
            padding: EdgeInsets.all(12),
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
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                this._pageController.jumpToPage(4);
                                _currentPageNotifier.value = 4;
                                flag = true;
                                setState(() {});
                              },
                              child: Text(
                                "skip".tr,
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Color(0xff2F6782),
                                  fontSize: 22.0.sp,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                Container(
                  width: w,
                  height: 1.7 * h / 3,
                  child: PageView(
                    controller: _pageController,
                    physics: NeverScrollableScrollPhysics(),
                    onPageChanged: (value) {},
                    children: [
                      buildIntroPage(w, h, "assets/images/intro1.png",
                          "Generate", "Invoices & Payment Links"),
                      buildIntroPage(w, h, "assets/images/intro2.png",
                          "Collect", "Money on the go"),
                      buildIntroPage(w, h, "assets/images/intro3.png", "Keep",
                          "Record of your business activites"),
                      buildIntroPage(w, h, "assets/images/intro4.png", "Sell",
                          "Online with ease"),
                      buildIntroPage(w, h, "assets/images/intro5.png", "Ship",
                          "Products with DHL & Aramex"),
                    ],
                  ),
                ),
                // _buildCircleIndicator2(),
                PageIndicator(
                  currentValue: _currentPageNotifier.value,
                ),
                flag
                    ? GestureDetector(
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
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 50.0.sp,
                            height: 50.0.sp,
                            margin: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 0.08 * h),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xff2F6782),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () {
                                _currentPageNotifier.value += 1;
                                if (_currentPageNotifier.value == 4)
                                  flag = true;
                                setState(() {});
                                logSuccess(
                                    _currentPageNotifier.value.toString());
                                _pageController
                                    .jumpToPage(_currentPageNotifier.value);
                              },
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
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
              EdgeInsets.only(top: 30.0.sp, bottom: 10, left: 20, right: 20),
          child: Text(
            text1,
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Text(
            text2,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xff2F6782),
            ),
          ),
        ),
      ],
    );
  }

  _buildCircleIndicator2() {
    return CirclePageIndicator(
      size: 15.0,
      selectedSize: 18.0,
      dotColor: Color(0xff5D5E60),
      selectedDotColor: Color(0xff2F6782),
      itemCount: 5,
      currentPageNotifier: _currentPageNotifier,
    );
  }
}
