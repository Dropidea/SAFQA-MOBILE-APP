import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class MultiFactorAuthMainPage extends StatefulWidget {
  MultiFactorAuthMainPage({super.key});

  @override
  State<MultiFactorAuthMainPage> createState() =>
      MultiFactorAuthMainPageState();
}

class MultiFactorAuthMainPageState extends State<MultiFactorAuthMainPage> {
  bool smsIsToggled = true;
  bool emailIsToggled = false;
  bool gToggled = false;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const ZeroAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
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
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22.0.sp,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    whiteText("Multi-factor Authentication", 15,
                        fontWeight: FontWeight.w600),
                    Opacity(
                      opacity: 0,
                      child: whiteText("text", 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                    width: w,
                    padding: EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: ListView(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      primary: false,
                      children: [
                        blackText("Multi-factor Authentication", 15,
                            fontWeight: FontWeight.bold),
                        SizedBox(height: 5),
                        greyText(
                          "Configure Multi-Factor Authentication to better protect your users, Select the factor that the user can use as an additional safety factor ",
                          12,
                        ),
                        SizedBox(height: 20),
                        blackText("Factors", 15, fontWeight: FontWeight.bold),
                        SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  EvaIcons.messageSquare,
                                  color: Color(0xff2F6782),
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 0.5 * w,
                                          child: blackText(
                                              "SMS Verification Code", 12)),
                                      FlutterSwitch(
                                        height: 25.0,
                                        width: 50.0,
                                        padding: 4.0,
                                        toggleSize: 25.0,
                                        borderRadius: 20.0,
                                        activeColor: Color(0xff1BAFB2),
                                        value: smsIsToggled,
                                        onToggle: (value) {
                                          setState(() {
                                            smsIsToggled = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  greyText(
                                      "Receive a phone message with a verification code",
                                      12)
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  EvaIcons.email,
                                  color: Color(0xff2F6782),
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 0.5 * w,
                                          child: blackText(
                                              "Email Verification Code", 12)),
                                      FlutterSwitch(
                                        height: 25.0,
                                        width: 50.0,
                                        padding: 4.0,
                                        toggleSize: 25.0,
                                        borderRadius: 20.0,
                                        activeColor: Color(0xff1BAFB2),
                                        value: emailIsToggled,
                                        onToggle: (value) {
                                          setState(() {
                                            emailIsToggled = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  greyText(
                                      "Receive an email with a verification code",
                                      12)
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 40),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Icon(
                                  EvaIcons.google,
                                  color: Color(0xff2F6782),
                                  size: 30,
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 0.5 * w,
                                          child: blackText(
                                              "Receive an email with a verification code",
                                              12)),
                                      FlutterSwitch(
                                        height: 25.0,
                                        width: 50.0,
                                        padding: 4.0,
                                        toggleSize: 25.0,
                                        borderRadius: 20.0,
                                        activeColor: Color(0xff1BAFB2),
                                        value: gToggled,
                                        onToggle: (value) {
                                          setState(() {
                                            gToggled = value;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  greyText(
                                      "When Google Authenticator is activated,\ you will see a QR code below, Scan this QR code with the Google Authenticator app on your mobile device, after that press \"Next\" to enter the verified code which is generated from the app.",
                                      12),
                                  gToggled ? SizedBox(height: 20) : Container(),
                                  gToggled
                                      ? Align(
                                          alignment: Alignment.centerLeft,
                                          child: Container(
                                            width: w / 2.5,
                                            height: w / 2.5,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/images/barcode.png"),
                                                  fit: BoxFit.cover),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Align(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff2F6782),
                              image: DecorationImage(
                                image: AssetImage(
                                    "assets/images/btn_wallpaper.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            width: 0.8 * w,
                            padding: EdgeInsets.all(15),
                            child: Center(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
