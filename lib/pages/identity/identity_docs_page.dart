import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class IdentityConfirmDocsPage extends StatefulWidget {
  const IdentityConfirmDocsPage({super.key});

  @override
  State<IdentityConfirmDocsPage> createState() =>
      _IdentityConfirmDocsPageState();
}

class _IdentityConfirmDocsPageState extends State<IdentityConfirmDocsPage> {
  bool canSubmit = false;
  bool idFlag1 = false;
  bool idFlag2 = false;
  bool idFlag3 = false;
  ExpandableController controller1 =
      ExpandableController(initialExpanded: false);
  ExpandableController controller2 =
      ExpandableController(initialExpanded: false);
  ExpandableController controller3 =
      ExpandableController(initialExpanded: false);
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "Identity documentation"),
      body: ExpandableNotifier(
        child: ListView(
          padding: EdgeInsets.all(20),
          primary: false,
          children: [
            blackText(
                "Your identity can be verified through one of these methods",
                15),
            SizedBox(height: 30),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.all(10),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/id.png",
                        width: 35,
                      ),
                      SizedBox(width: 10),
                      blackText(
                        "Identity Documentation",
                        13,
                      ),
                    ],
                  ),
                ),
                controller: controller1,
                collapsed: Container(),
                expanded: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IdentityDocWidget(
                        title: " ID front side",
                        onTap: () => setState(() {
                          idFlag1 = true;
                          if (idFlag1 && idFlag2 && idFlag3) canSubmit = true;
                        }),
                      ),
                      IdentityDocWidget(
                          title: " ID back side",
                          onTap: () => setState(() {
                                idFlag2 = true;
                                if (idFlag1 && idFlag2 && idFlag3)
                                  canSubmit = true;
                              })),
                      IdentityDocWidget(
                          title: " Yor face beside ID",
                          onTap: () => setState(() {
                                idFlag3 = true;
                                if (idFlag1 && idFlag2 && idFlag3)
                                  canSubmit = true;
                              })),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.all(10),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/passport.png",
                        width: 35,
                      ),
                      SizedBox(width: 10),
                      blackText(
                        "Passport documentation",
                        13,
                      ),
                    ],
                  ),
                ),
                controller: controller2,
                collapsed: Container(),
                expanded: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IdentityDocWidget(
                        title: "Passport",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              padding: EdgeInsets.all(10),
              child: ExpandablePanel(
                header: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/license.png",
                        width: 35,
                      ),
                      SizedBox(width: 10),
                      blackText(
                        "Driving license Documentation",
                        13,
                      ),
                    ],
                  ),
                ),
                controller: controller3,
                collapsed: Container(),
                expanded: Container(
                  margin: EdgeInsets.only(top: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IdentityDocWidget(
                        title: "Driving license",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 40),
            WallpepredBTN(
              text: "save",
              haveWallpaper: false,
              width: w / 1.5,
              borderRadius: 15,
              color: canSubmit ? null : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class IdentityDocWidget extends StatefulWidget {
  const IdentityDocWidget({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String title;
  final void Function()? onTap;
  @override
  State<IdentityDocWidget> createState() => _IdentityDocWidgetState();
}

class _IdentityDocWidgetState extends State<IdentityDocWidget> {
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.any,
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                fileName = result.files.single.path!.split("/").last;
                if (widget.onTap != null) {
                  widget.onTap!();
                }
                setState(() {});
              } else {
                // User canceled the picker
              }
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  color: fileName != ""
                      ? Color(0xffE8E8E8)
                      : const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(5),
                  border: fileName != ""
                      ? null
                      : Border.all(color: Color(0xffA8A8A8))),
              child: Center(
                child: Icon(
                  fileName == "" ? EvaIcons.plus : EvaIcons.fileText,
                  color: fileName == "" ? Color(0xffA8A8A8) : Color(0xff66B4D2),
                  size: 30,
                ),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText(
                      widget.title,
                      13,
                      fontWeight: FontWeight.w500,
                    ),
                    fileName != ""
                        ? Row(
                            children: [
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xff66B4D2).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Icon(
                                    EvaIcons.eye,
                                    color: Color(0xff66B4D2),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  color:
                                      const Color(0xffE47E7B).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Icon(
                                    EvaIcons.trash2,
                                    color: Color(0xffE47E7B),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
                            ],
                          )
                        : Container()
                  ],
                ),
                // SizedBox(height: 10),
                fileName == ""
                    ? greyText("Upload", 12)
                    // ? GFProgressBar(
                    //     width: w / 2,
                    //     lineHeight: 10,
                    //     progressBarColor: Color(0xff66B4D2),
                    //   )
                    : greyText(fileName, 12, fontWeight: FontWeight.w300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
