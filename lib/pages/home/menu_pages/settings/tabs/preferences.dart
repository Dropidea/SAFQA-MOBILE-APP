import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:restart_app/restart_app.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/utils.dart';
import 'package:sizer/sizer.dart';

class PreferencesTab extends StatefulWidget {
  const PreferencesTab({super.key});

  @override
  State<PreferencesTab> createState() => _PreferencesTabState();
}

class _PreferencesTabState extends State<PreferencesTab> {
  int languageVal = 0;
  bool sv = false;

  LocalsController localsController = Get.put(LocalsController());
  @override
  void initState() {
    languageVal = localsController.currenetLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return ExpandableNotifier(
        child: ListView(
      primary: false,
      // padding: EdgeInsets.all(20),
      children: [
        SizedBox(height: 60),
        Container(
          padding: EdgeInsets.all(20),
          width: w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffF8F8F8)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Icon(
                      EvaIcons.globe,
                      color: Color(0xff2F6782),
                    ),
                  ),
                  SizedBox(width: 10),
                  blueText(
                    "Language",
                    15,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: GFRadio(
                            activeBorderColor: Colors.transparent,
                            inactiveBorderColor: Colors.transparent,
                            activeBgColor: Color(0xffF8F8F8),
                            inactiveBgColor: Color(0xffF8F8F8),
                            radioColor: Color(0xff66B4D2),
                            inactiveIcon: Icon(
                              Icons.circle_outlined,
                              color: Colors.grey.shade300,
                            ),
                            size: GFSize.SMALL,
                            value: 0,
                            groupValue: languageVal,
                            onChanged: (value) async {
                              setState(() {
                                languageVal = value;
                              });
                              await localsController.SetEnglishLocale();
                              await Restart.restartApp();
                            }),
                      ),
                      greyText("English", 16),
                    ],
                  ),
                  SizedBox(width: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: GFRadio(
                            activeBorderColor: Colors.transparent,
                            radioColor: Color(0xff66B4D2),
                            inactiveIcon: Icon(
                              Icons.circle_outlined,
                              color: Colors.grey.shade300,
                            ),
                            size: GFSize.SMALL,
                            inactiveBorderColor: Colors.transparent,
                            activeBgColor: Color(0xffF8F8F8),
                            inactiveBgColor: Color(0xffF8F8F8),
                            value: 1,
                            groupValue: languageVal,
                            onChanged: (value) async {
                              setState(() async {
                                logSuccess("ar");
                                languageVal = value;
                              });
                              await localsController.SetArabicLocale();
                              await Restart.restartApp();
                            }),
                      ),
                      greyText("العربية", 16),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(20),
          width: w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xffF8F8F8)),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7),
                    child: Icon(
                      EvaIcons.colorPalette,
                      color: Color(0xff2F6782),
                    ),
                  ),
                  SizedBox(width: 10),
                  blueText(
                    "Theme",
                    15,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
              Divider(
                thickness: 2,
                // color: Colors.black,
              ),
              Row(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Icon(
                          EvaIcons.sunOutline,
                          size: 30,
                          color: Color(0xff00A7B3),
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Light",
                        style: TextStyle(
                            color: Color(0xff00A7B3),
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(width: 10),
                  FlutterSwitch(
                    width: 60,
                    height: 30,
                    toggleSize: 25,
                    activeToggleColor: Color(0xff20495D),
                    inactiveToggleColor: Color(0xff00A7B3),
                    activeColor: Color(0xffD6D6D6),
                    inactiveColor: Color(0xffD6D6D6),
                    value: sv,
                    onToggle: (value) {
                      setState(() {
                        sv = value;
                      });
                      Utils.showSnackBar(context, "Coming Soon!!");
                    },
                  ),
                  SizedBox(width: 10),
                  Row(
                    children: [
                      Text(
                        "Dark",
                        style: TextStyle(
                            color: Color(0xff20495D),
                            fontSize: 14.0.sp,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: Icon(
                          EvaIcons.moonOutline,
                          size: 30,
                          color: Color(0xff20495D),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ));
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            width: 55.0.sp,
            height: 70.0.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/logo/logo.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 25,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
