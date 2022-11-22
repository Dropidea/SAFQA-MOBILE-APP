import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class ContactPage extends StatefulWidget {
  ContactPage({super.key});

  @override
  State<ContactPage> createState() => ContactPageState();
}

class ContactPageState extends State<ContactPage> {
  String fileName = "";
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
                    whiteText("Contact", 15, fontWeight: FontWeight.w600),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        primary: false,
                        children: [
                          ExpandablePanel(
                            header: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                              child: blackText("Contact", 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            controller:
                                ExpandableController(initialExpanded: true),
                            collapsed: Container(),
                            theme: ExpandableThemeData(hasIcon: false),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                blackText("Address:", 15,
                                    fontWeight: FontWeight.normal),
                                const SizedBox(height: 5),
                                greyText(
                                    "The One Tower, Dubai Internet City Metro,\nSheikh Zayed Road,\nDubai, U.A.E.",
                                    13),
                                const SizedBox(height: 20),
                                blackText("Email:", 15,
                                    fontWeight: FontWeight.normal),
                                const SizedBox(height: 5),
                                greyText("supportuae@safqa.com", 13),
                                const SizedBox(height: 20),
                                blackText("Sales Contact Details:", 15,
                                    fontWeight: FontWeight.normal),
                                const SizedBox(height: 5),
                                greyText("+971 54 586 0633 (Support)", 13),
                                const SizedBox(height: 5),
                                greyText("+971 54 586 0633 (Support)", 13),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          ExpandablePanel(
                            header: Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey, width: 0.5),
                                ),
                              ),
                              child: blackText("Leave A Message", 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            controller:
                                ExpandableController(initialExpanded: true),
                            collapsed: Container(),
                            theme: ExpandableThemeData(hasIcon: false),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                blackText("Support Type", 15,
                                    fontWeight: FontWeight.normal),
                                CustomDropdown(
                                  width: w,
                                  items: ["item1", "item2"],
                                  onchanged: (s) {},
                                  hint: "Choose",
                                ),
                                const SizedBox(height: 20),
                                blackText("Attach File", 16),
                                GestureDetector(
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'xlsx'],
                                    );
                                    if (result != null) {
                                      File file =
                                          File(result.files.single.path);
                                      fileName = result.files.single.path
                                          .split("/")
                                          .last;

                                      setState(() {});
                                    } else {
                                      // User canceled the picker
                                    }
                                  },
                                  child: DottedBorder(
                                    padding: EdgeInsets.all(0),
                                    customPath: (size) {
                                      return Path()
                                        ..moveTo(10, 0)
                                        ..lineTo(size.width - 10, 0)
                                        ..arcToPoint(Offset(size.width, 10),
                                            radius: Radius.circular(10))
                                        ..lineTo(size.width, size.height - 10)
                                        ..arcToPoint(
                                            Offset(
                                                size.width - 10, size.height),
                                            radius: Radius.circular(10))
                                        ..lineTo(10, size.height)
                                        ..arcToPoint(
                                            Offset(0, size.height - 10),
                                            radius: Radius.circular(10))
                                        ..lineTo(0, 10)
                                        ..arcToPoint(Offset(10, 0),
                                            radius: Radius.circular(10));
                                    },
                                    color: Color(0xff2F6782).withOpacity(0.4),
                                    strokeWidth: 1,
                                    dashPattern: [10, 5],
                                    child: Container(
                                      width: w,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color:
                                            Color(0xff2F6782).withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                          child: fileName == ""
                                              ? Icon(
                                                  Icons.add_rounded,
                                                  color: Color(0xff00A7B3),
                                                  size: 22.0.sp,
                                                )
                                              : Text(
                                                  fileName,
                                                  style: TextStyle(
                                                    color: Color(0xff00A7B3),
                                                    fontSize: 15.0.sp,
                                                  ),
                                                )),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                blackText("Message", 16),
                                Container(
                                  width: w,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.only(
                                      left: 15, right: 15, top: 5),
                                  decoration: BoxDecoration(
                                    color: Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: TextField(
                                    onChanged: (value) {},
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: GestureDetector(
                              onTap: () {},
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
                                width: 0.7 * w,
                                padding: EdgeInsets.all(15),
                                child: Center(
                                  child: Text(
                                    "Submit",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17.0.sp,
                                        fontWeight: FontWeight.w500),
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
