import 'package:chips_choice/chips_choice.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class CommisionsMainPage extends StatefulWidget {
  CommisionsMainPage({super.key});

  @override
  State<CommisionsMainPage> createState() => CommisionsMainPageState();
}

class CommisionsMainPageState extends State<CommisionsMainPage> {
  List<String> tags = [];
  bool isToggled = false;
  List<String> options = [
    'VISA/MasterCard  ',
    'KNET',
    'Debit/Credit Cards',
    'AMEX',
    'Apple Pay',
    'USA & Canada Cards'
  ];
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
                    whiteText("Commissions", 17, fontWeight: FontWeight.w600),
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
                    child: ExpandableNotifier(
                      child: ListView(
                        padding: EdgeInsets.all(20),
                        primary: false,
                        children: [
                          ExpandablePanel(
                            controller:
                                ExpandableController(initialExpanded: true),
                            collapsed: Container(),
                            theme: ExpandableThemeData(hasIcon: false),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 20),
                                blackText("Choose API Payment Mode", 13),
                                ChipsChoice<String>.multiple(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  value: tags,
                                  choiceStyle: C2ChipStyle.filled(
                                    foregroundColor: Color(0xff2F6782),
                                    borderWidth: 1,
                                    borderStyle: BorderStyle.solid,
                                    backgroundOpacity: 0.05,
                                    color: Color(0xff2F6782),
                                    selectedStyle: C2ChipStyle.toned(
                                      // color: Color(0xff2F6782),
                                      foregroundColor: Color(0xff2F6782),
                                      borderColor: Color(0xff2F6782),
                                      borderWidth: 1,
                                      borderStyle: BorderStyle.solid,
                                      backgroundColor: Color(0xff2F6782),
                                      backgroundOpacity: 0.1,
                                      height: 40,

                                      padding: EdgeInsets.symmetric(
                                          vertical: 5, horizontal: 20),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    height: 40,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 20),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  onChanged: (val) =>
                                      setState(() => tags = val),
                                  choiceItems:
                                      C2Choice.listFrom<String, String>(
                                    source: options,
                                    value: (i, v) => v,
                                    label: (i, v) => v,
                                    tooltip: (i, v) => v,
                                  ),

                                  // choiceCheckmark: true,
                                  wrapped: true,
                                ),
                              ],
                            ),
                            header: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                              child: blackText("API Details", 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 20),
                          ExpandablePanel(
                            controller:
                                ExpandableController(initialExpanded: true),
                            collapsed: Container(),
                            theme: ExpandableThemeData(hasIcon: false),
                            expanded: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ExpandablePanel(
                                    controller: ExpandableController(
                                        initialExpanded: true),
                                    collapsed: Container(),
                                    theme: ExpandableThemeData(
                                      hasIcon: false,
                                    ),
                                    expanded: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          greyText(
                                              "Consequat aliqua sunt dolor pariatur reprehenderit et dolor cillum occaecat culpa mollit cillum aliquip in.",
                                              12),
                                          SizedBox(height: 30),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              greyText("Commission From:", 14),
                                              CustomDropdown(
                                                borderColor: Color(0xffA8A8A8),
                                                width: w,
                                                height: 50,
                                                hint: "Choose",
                                                items: ["1", "2", "3"],
                                                onchanged: (s) {},
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    header: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            greyText("Knet", 15,
                                                fontWeight: FontWeight.bold),
                                            Row(
                                              children: [
                                                Text(
                                                  isToggled
                                                      ? "Active"
                                                      : "Inactive",
                                                  style: TextStyle(
                                                    color: isToggled
                                                        ? Color(0xff1BAFB2)
                                                        : Colors.grey,
                                                    fontSize: 13.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                FlutterSwitch(
                                                  height: 25.0,
                                                  width: 60.0,
                                                  padding: 4.0,
                                                  toggleSize: 25.0,
                                                  borderRadius: 20.0,
                                                  activeColor:
                                                      Color(0xff1BAFB2),
                                                  value: isToggled,
                                                  onToggle: (value) {
                                                    logSuccess(value);
                                                    setState(() {
                                                      isToggled = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ExpandablePanel(
                                    controller: ExpandableController(
                                        initialExpanded: true),
                                    collapsed: Container(),
                                    theme: ExpandableThemeData(
                                      hasIcon: false,
                                    ),
                                    expanded: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          greyText(
                                              "Consequat aliqua sunt dolor pariatur reprehenderit et dolor cillum occaecat culpa mollit cillum aliquip in.",
                                              12),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              greyText("Commission From", 12),
                                              CustomDropdown(
                                                borderColor: Color(0xffA8A8A8),
                                                width: 0.4 * w,
                                                hint: "Choose",
                                                items: ["1", "2", "3"],
                                                onchanged: (s) {},
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    header: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            greyText("Visa/MasterCard", 15,
                                                fontWeight: FontWeight.bold),
                                            Row(
                                              children: [
                                                Text(
                                                  isToggled
                                                      ? "Active"
                                                      : "Inactive",
                                                  style: TextStyle(
                                                    color: isToggled
                                                        ? Color(0xff1BAFB2)
                                                        : Colors.grey,
                                                    fontSize: 13.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                FlutterSwitch(
                                                  height: 25.0,
                                                  width: 60.0,
                                                  padding: 4.0,
                                                  toggleSize: 25.0,
                                                  borderRadius: 20.0,
                                                  activeColor:
                                                      Color(0xff1BAFB2),
                                                  value: isToggled,
                                                  onToggle: (value) {
                                                    logSuccess(value);
                                                    setState(() {
                                                      isToggled = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey, width: 0.5),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          greyText("Visa/MasterCard", 15,
                                              fontWeight: FontWeight.bold),
                                          redText("Disabled By Admin!", 11),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20),
                                Container(
                                  margin: EdgeInsets.only(top: 20),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: ExpandablePanel(
                                    controller: ExpandableController(
                                        initialExpanded: true),
                                    collapsed: Container(),
                                    theme: ExpandableThemeData(
                                      hasIcon: false,
                                    ),
                                    expanded: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          greyText(
                                              "Consequat aliqua sunt dolor pariatur reprehenderit et dolor cillum occaecat culpa mollit cillum aliquip in.",
                                              12),
                                          SizedBox(height: 10),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              greyText("Commission From", 12),
                                              CustomDropdown(
                                                borderColor: Color(0xffA8A8A8),
                                                width: 0.4 * w,
                                                hint: "Choose",
                                                items: ["1", "2", "3"],
                                                onchanged: (s) {},
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    header: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey, width: 0.5),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            greyText("Amex", 15,
                                                fontWeight: FontWeight.bold),
                                            Row(
                                              children: [
                                                Text(
                                                  isToggled
                                                      ? "Active"
                                                      : "Inactive",
                                                  style: TextStyle(
                                                    color: isToggled
                                                        ? Color(0xff1BAFB2)
                                                        : Colors.grey,
                                                    fontSize: 13.0.sp,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                SizedBox(width: 10),
                                                FlutterSwitch(
                                                  height: 25.0,
                                                  width: 60.0,
                                                  padding: 4.0,
                                                  toggleSize: 25.0,
                                                  borderRadius: 20.0,
                                                  activeColor:
                                                      Color(0xff1BAFB2),
                                                  value: isToggled,
                                                  onToggle: (value) {
                                                    logSuccess(value);
                                                    setState(() {
                                                      isToggled = value;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            header: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                              child: blackText("Payment Methods", 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 40),
                          Align(
                            child: Container(
                              width: 0.7 * w,
                              height: 40.0.sp,
                              decoration: BoxDecoration(
                                color: Color(0xff2F6782),
                                image: DecorationImage(
                                  image: AssetImage(
                                      "assets/images/btn_wallpaper.png"),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: InkWell(
                                onTap: () async {
                                  // Get.to(() => HomePage());
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Center(
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
