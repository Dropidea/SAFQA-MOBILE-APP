import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/complete_signup.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: ZeroAppBar(),
        body: ListView(primary: false, children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h,
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 5, bottom: 20),
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 22.0.sp,
                        ),
                        onPressed: () {
                          if (_pageController.page == 0)
                            Get.back();
                          else
                            _pageController.jumpToPage(
                                (_pageController.page! - 1).toInt());
                        },
                      ),
                    )
                  ],
                ),
                Expanded(
                    child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "SignUp",
                              style: TextStyle(
                                  color: Color(0xff2F6782),
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.0.sp,
                      ),
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          physics: NeverScrollableScrollPhysics(),
                          children: [
                            _signUpPage1(w, h),
                            _signUpPage2(w, h),
                          ],
                        ),
                      )
                    ],
                  ),
                ))
              ],
            ),
          ),
        ]));
  }

  Widget _signUpPage1(double w, double h) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Your Country",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0.sp,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0.sp,
        ),
        GestureDetector(
          onTap: () => _pageController.jumpToPage(1),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: 0.5 * w,
              height: 0.25 * h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/uae.png"),
                  ),
                  Text(
                    "UAE",
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0.sp,
        ),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 0.5 * w,
            height: 0.25 * h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/Kuwait.png"),
                ),
                Text(
                  "Kuwait",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Column _signUpPage2(double w, double h) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Your Business Type",
                style: TextStyle(
                  fontSize: 16.0.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20.0.sp,
        ),
        GestureDetector(
          onTap: () => Get.to(() => CompleteSignUpPage()),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              width: 0.5 * w,
              height: 0.25 * h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage("assets/images/licomp.png"),
                  ),
                  SizedBox(
                    height: 5.0.sp,
                  ),
                  Text(
                    "Licensed Company",
                    style: TextStyle(
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.0.sp,
        ),
        Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            width: 0.5 * w,
            height: 0.25 * h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage("assets/images/home_business.png"),
                ),
                SizedBox(
                  height: 5.0.sp,
                ),
                Text(
                  "Home Business",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0.sp,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
