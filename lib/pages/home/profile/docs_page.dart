import 'dart:io';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:getwidget/components/progress_bar/gf_progress_bar.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';

class DocsPage extends StatelessWidget {
  const DocsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "docs".tr),
      body: ListView(
        padding: EdgeInsets.all(20),
        primary: false,
        children: [
          DocWidget(type: DocTypes.civilId),
          DocWidget(type: DocTypes.civilIdBack),
          DocWidget(type: DocTypes.bankAccountLetter),
          DocWidget(type: DocTypes.other),
        ],
      ),
    );
  }
}

enum DocTypes {
  other,
  civilId,
  civilIdBack,
  bankAccountLetter,
}

class DocWidget extends StatefulWidget {
  const DocWidget({
    Key? key,
    required this.type,
  }) : super(key: key);
  final DocTypes type;
  @override
  State<DocWidget> createState() => _DocWidgetState();
}

class _DocWidgetState extends State<DocWidget> {
  String fileName = "";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.any,
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                fileName = result.files.single.path!.split("/").last;

                setState(() {});
              } else {
                // User canceled the picker
              }
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  color: const Color(0xffF9F9F9),
                  borderRadius: BorderRadius.circular(10)),
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
                  children: [
                    greyText(
                      widget.type == DocTypes.other
                          ? "other".tr
                          : widget.type == DocTypes.civilId
                              ? "cv_id".tr
                              : widget.type == DocTypes.civilIdBack
                                  ? "cv_id_back".tr
                                  : "bank_account_letter".tr,
                      16,
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
                                      const Color(0xff58D241).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Center(
                                  child: Icon(
                                    EvaIcons.download,
                                    color: Color(0xff58D241),
                                  ),
                                ),
                              ),
                              SizedBox(width: 5),
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
                SizedBox(height: 10),
                fileName == ""
                    ? GFProgressBar(
                        width: w / 2,
                        lineHeight: 10,
                        progressBarColor: Color(0xff66B4D2),
                      )
                    : greyText(fileName, 14, fontWeight: FontWeight.w300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
