import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/signup_controller.dart';
import '../../widgets/zero_app_bar.dart';
import 'complete_signup.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  PageController _pageController = PageController();
  SignUpController _signUpController = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h,
          ),
          Column(
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
                          _pageController
                              .jumpToPage((_pageController.page! - 1).toInt());
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 10),
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
                        height: 5.0.sp,
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
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _signUpPage1(double w, double h) {
    return FutureBuilder(
        future: _signUpController.getGlobalData(),
        builder: (context, snp) {
          if (snp.connectionState == ConnectionState.done) {
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
                Expanded(
                  child: ListView(
                    primary: false,
                    children: [
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            _signUpController.dataToRegister['country_id'] = 8;
                            _pageController.jumpToPage(1);
                          },
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
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        child: GestureDetector(
                          onTap: () {
                            _signUpController.dataToRegister['country_id'] = 2;
                            _pageController.jumpToPage(1);
                          },
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
                                    image:
                                        AssetImage("assets/images/Kuwait.png"),
                                  ),
                                  Text(
                                    "Kuwait",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.grey.shade500,
                                      fontSize: 16.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });

    // FutureBuilder(
    //     future: _signUpController.getGlobalData(),
    //     builder: (context, snp) {
    //       if (!snp.hasData)
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //       if (snp.connectionState == ConnectionState.done) {
    //         var countries = snp.data['country'];
    //         return
    // Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Padding(
    //           padding: const EdgeInsets.all(8.0),
    //           child: Text(
    //             "Select Your Country",
    //             style: TextStyle(
    //               color: Colors.black,
    //               fontSize: 18.0.sp,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     SizedBox(
    //       height: 20.0.sp,
    //     ),
    //     Expanded(
    //       child: ListView.separated(
    //         itemBuilder: (context, index) {
    //           return Align(
    //             child: Container(
    //               margin: EdgeInsets.only(
    //                   bottom: index == countries.length - 1 ? 20 : 0),
    //               child: GestureDetector(
    //                 onTap: () {
    //                   _signUpController.dataToRegister['country_id'] =
    //                       index + 1;
    //                   logSuccess(countries[index]["name_en"]);
    //                   _pageController.jumpToPage(1);
    //                 },
    //                 child: Card(
    //                   elevation: 10,
    //                   shape: RoundedRectangleBorder(
    //                     borderRadius: BorderRadius.circular(15.0),
    //                   ),
    //                   child: Container(
    //                     width: 0.5 * w,
    //                     height: 0.25 * h,
    //                     child: Column(
    //                       mainAxisAlignment: MainAxisAlignment.center,
    //                       children: [
    //                         Image(
    //                           image:
    //                               AssetImage("assets/images/uae.png"),
    //                         ),
    //                         Text(
    //                           countries[index]['name_en'],
    //                           textAlign: TextAlign.center,
    //                           style: TextStyle(
    //                             fontSize: 16.0.sp,
    //                             fontWeight: FontWeight.w500,
    //                           ),
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //         itemCount: countries.length,
    //         separatorBuilder: (BuildContext context, int index) {
    //           return SizedBox(
    //             height: 10,
    //           );
    //         },
    //       ),
    // )
    // SizedBox(
    //   height: 10.0.sp,
    // ),
    // Card(
    //   elevation: 10,
    //   shape: RoundedRectangleBorder(
    //     borderRadius: BorderRadius.circular(15.0),
    //   ),
    //   child: Container(
    //     width: 0.5 * w,
    //     height: 0.25 * h,
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Image(
    //           image: AssetImage("assets/images/Kuwait.png"),
    //         ),
    //         Text(
    //           "Kuwait",
    //           style: TextStyle(
    //             fontSize: 16.0.sp,
    //             fontWeight: FontWeight.w500,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // )
    // ],
    // );
    //   } else
    //     return Center(child: CircularProgressIndicator());
    // });
  }

  Widget _signUpPage2(double w, double h) {
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
        Expanded(
          child: ListView(
            primary: false,
            children: [
              Align(
                child: GestureDetector(
                  onTap: () {
                    _signUpController.dataToRegister['business_type_id'] = 2;
                    Get.to(() => CompleteSignUpPage());
                  },
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: SizedBox(
                      width: 0.5 * w,
                      height: 0.25 * h,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            image: AssetImage("assets/images/licomp.png"),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Licensed Company",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                child: GestureDetector(
                  onTap: () {
                    _signUpController.dataToRegister['business_type_id'] = 1;

                    Get.to(() => CompleteSignUpPage());
                  },
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
                            image:
                                AssetImage("assets/images/home_business.png"),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Personal Business",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 16.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );

    // FutureBuilder(
    //     future: _signUpController.getGlobalData(),
    //     builder: (context, snp) {
    //       if (snp.connectionState == ConnectionState.done) {
    //         var businessTypes = snp.data['business_type'];
    //         return Column(
    //           children: [
    //             Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Padding(
    //                   padding: const EdgeInsets.all(8.0),
    //                   child: Text(
    //                     "Select Your Business Type",
    //                     style: TextStyle(
    //                       fontSize: 16.0.sp,
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //             SizedBox(
    //               height: 20.0.sp,
    //             ),
    //             Expanded(
    //               child: ListView.separated(
    //                 itemBuilder: (context, index) => Align(
    //                   child: GestureDetector(
    //                     onTap: () {
    //                       _signUpController.dataToRegister['business_type_id'] =
    //                           index + 1;
    //                       logSuccess(index + 1);
    //                       Get.to(() => CompleteSignUpPage());
    //                     },
    //                     child: Card(
    //                       elevation: 10,
    //                       shape: RoundedRectangleBorder(
    //                         borderRadius: BorderRadius.circular(15.0),
    //                       ),
    //                       child: Container(
    //                         width: 0.5 * w,
    //                         height: 0.25 * h,
    //                         child: Column(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             Image(
    //                               image: AssetImage("assets/images/licomp.png"),
    //                             ),
    //                             SizedBox(
    //                               height: 5.0.sp,
    //                             ),
    //                             Text(
    //                               businessTypes[index]['name_en'],
    //                               textAlign: TextAlign.center,
    //                               style: TextStyle(
    //                                 fontSize: 16.0.sp,
    //                                 fontWeight: FontWeight.w500,
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 itemCount: 2,
    //                 separatorBuilder: (context, index) => SizedBox(
    //                   height: 10.0.sp,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         );
    //       } else
    //         return Center(
    //           child: CircularProgressIndicator(),
    //         );
    //     });
  }
}
