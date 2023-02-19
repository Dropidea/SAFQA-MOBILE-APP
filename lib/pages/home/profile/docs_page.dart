import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:file_picker/file_picker.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/controller/docs_controller.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class DocsPage extends StatefulWidget {
  DocsPage({super.key});

  @override
  State<DocsPage> createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> {
  DocsController _docsController = Get.put(DocsController());
  @override
  void initState() {
    _docsController.getDocs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "docs".tr),
      body: GetBuilder<DocsController>(builder: (c) {
        return c.getDocsFlag
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.all(20),
                primary: false,
                children: [
                  DocWidget(
                    type: DocTypes.civilId,
                    fileName: c.profileDocumentToShow.civilId != null
                        ? c.profileDocumentToShow.civilId.toString().substring(c
                                .profileDocumentToShow.civilId
                                .toString()
                                .lastIndexOf("/") +
                            1)
                        : "",
                  ),
                  DocWidget(
                    type: DocTypes.civilIdBack,
                    fileName: c.profileDocumentToShow.civilIdBack != null
                        ? c.profileDocumentToShow.civilIdBack
                            .toString()
                            .substring(c.profileDocumentToShow.civilIdBack
                                    .toString()
                                    .lastIndexOf("/") +
                                1)
                        : "",
                  ),
                  DocWidget(
                    type: DocTypes.bankAccountLetter,
                    fileName: c.profileDocumentToShow.bankAccountLetter != null
                        ? c.profileDocumentToShow.bankAccountLetter
                            .toString()
                            .substring(c.profileDocumentToShow.bankAccountLetter
                                    .toString()
                                    .lastIndexOf("/") +
                                1)
                        : "",
                  ),
                  DocWidget(
                    type: DocTypes.other,
                    fileName: c.profileDocumentToShow.other != null
                        ? c.profileDocumentToShow.other.toString().substring(c
                                .profileDocumentToShow.other
                                .toString()
                                .lastIndexOf("/") +
                            1)
                        : "",
                  ),
                  SizedBox(height: 20),
                  c.saveFlag
                      ? WallpepredBTN(
                          width: w / 2,
                          text: "save".tr,
                          haveWallpaper: true,
                          height: 50,
                          onTap: () {
                            logSuccess(c.profileDocument.toJson());
                            c.postDocs(c.profileDocument);
                          },
                        )
                      : Container(),
                ],
              );
      }),
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
  DocWidget({
    Key? key,
    required this.type,
    this.fileName = "",
  }) : super(key: key);
  final DocTypes type;
  String fileName;
  @override
  State<DocWidget> createState() => _DocWidgetState();
}

class _DocWidgetState extends State<DocWidget> {
  DocsController _docsController = Get.find();

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
                type: FileType.image,
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                widget.fileName = result.files.single.path!.split("/").last;
                switch (widget.type) {
                  case DocTypes.civilId:
                    _docsController.profileDocument.civilId = file;
                    _docsController.profileDocumentToShow.civilId =
                        widget.fileName;
                    break;
                  case DocTypes.civilIdBack:
                    _docsController.profileDocument.civilIdBack = file;
                    _docsController.profileDocumentToShow.civilIdBack =
                        widget.fileName;
                    break;
                  case DocTypes.bankAccountLetter:
                    _docsController.profileDocument.bankAccountLetter = file;
                    _docsController.profileDocumentToShow.bankAccountLetter =
                        widget.fileName;
                    break;
                  case DocTypes.other:
                    _docsController.profileDocument.other = file;
                    _docsController.profileDocumentToShow.other =
                        widget.fileName;
                    break;
                }

                _docsController.setToTrue();
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
                  widget.fileName == "" ? EvaIcons.plus : EvaIcons.fileText,
                  color: widget.fileName == ""
                      ? Color(0xffA8A8A8)
                      : Color(0xff66B4D2),
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
                    SizedBox(
                      width: w / 2.3,
                      child: greyText(
                        widget.type == DocTypes.other
                            ? "other".tr
                            : widget.type == DocTypes.civilId
                                ? "cv_id".tr
                                : widget.type == DocTypes.civilIdBack
                                    ? "cv_id_back".tr
                                    : "bank_account_letter".tr,
                        14,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    widget.fileName != ""
                        ? Row(
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  Directory? dir =
                                      await getExternalStorageDirectory();
                                  late PermissionStatus status;
                                  late PermissionStatus status2;

                                  try {
                                    status = await Permission.storage.status;
                                    if (!status.isGranted) {
                                      await Permission.storage.request();
                                    }
                                    status2 = await Permission
                                        .manageExternalStorage.status;
                                    if (!status2.isGranted) {
                                      await Permission.manageExternalStorage
                                          .request();
                                    }
                                    String tmp =
                                        dir!.parent.parent.parent.parent.path +
                                            "/Safqa/Documents";
                                    Directory newDir = await Directory(tmp)
                                        .create(recursive: true);
                                    logSuccess(newDir.path);
                                    switch (widget.type) {
                                      case DocTypes.civilId:
                                        if (!_docsController
                                            .profileDocumentToShow.civilId
                                            .toString()
                                            .endsWith("documents")) {
                                          Get.dialog(const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                          await Dio().download(
                                              _docsController
                                                  .profileDocumentToShow
                                                  .civilId,
                                              newDir.path +
                                                  "/" +
                                                  _docsController
                                                      .profileDocumentToShow
                                                      .civilId
                                                      .toString()
                                                      .substring(_docsController
                                                              .profileDocumentToShow
                                                              .civilId
                                                              .toString()
                                                              .lastIndexOf(
                                                                  "/") +
                                                          1));
                                          Get.back();
                                          Utils.showSnackBar(context,
                                              "Saved To Safqa/Documents");
                                        }
                                        break;
                                      case DocTypes.civilIdBack:
                                        if (!_docsController
                                            .profileDocumentToShow.civilIdBack
                                            .toString()
                                            .endsWith("documents")) {
                                          Get.dialog(const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                          await Dio().download(
                                              _docsController
                                                  .profileDocumentToShow
                                                  .civilIdBack,
                                              newDir.path +
                                                  "/" +
                                                  _docsController
                                                      .profileDocumentToShow
                                                      .civilIdBack
                                                      .toString()
                                                      .substring(_docsController
                                                              .profileDocumentToShow
                                                              .civilIdBack
                                                              .toString()
                                                              .lastIndexOf(
                                                                  "/") +
                                                          1));
                                          Get.back();
                                          Utils.showSnackBar(context,
                                              "Saved To Safqa/Documents");
                                        }
                                        break;
                                      case DocTypes.bankAccountLetter:
                                        if (!_docsController
                                            .profileDocumentToShow
                                            .bankAccountLetter
                                            .toString()
                                            .endsWith("documents")) {
                                          Get.dialog(const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                          await Dio().download(
                                              _docsController
                                                  .profileDocumentToShow
                                                  .bankAccountLetter,
                                              newDir.path +
                                                  "/" +
                                                  _docsController
                                                      .profileDocumentToShow
                                                      .bankAccountLetter
                                                      .toString()
                                                      .substring(_docsController
                                                              .profileDocumentToShow
                                                              .bankAccountLetter
                                                              .toString()
                                                              .lastIndexOf(
                                                                  "/") +
                                                          1));
                                          Get.back();
                                          Utils.showSnackBar(context,
                                              "Saved To Safqa/Documents");
                                        }
                                        break;
                                      case DocTypes.other:
                                        if (!_docsController
                                            .profileDocumentToShow.other
                                            .toString()
                                            .endsWith("documents")) {
                                          Get.dialog(const Center(
                                            child: CircularProgressIndicator(),
                                          ));
                                          await Dio().download(
                                              _docsController
                                                  .profileDocumentToShow.other,
                                              newDir.path +
                                                  "/" +
                                                  _docsController
                                                      .profileDocumentToShow
                                                      .other
                                                      .toString()
                                                      .substring(_docsController
                                                              .profileDocumentToShow
                                                              .other
                                                              .toString()
                                                              .lastIndexOf(
                                                                  "/") +
                                                          1));
                                          Get.back();
                                          Utils.showSnackBar(context,
                                              "Saved To Safqa/Documents");
                                        }
                                        break;
                                    }
                                  } catch (e) {
                                    logError(e.toString());
                                  }
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff58D241)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      EvaIcons.download,
                                      color: Color(0xff58D241),
                                    ),
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
                              GestureDetector(
                                onTap: () {
                                  switch (widget.type) {
                                    case DocTypes.civilId:
                                      _docsController.profileDocument.civilId =
                                          null;
                                      _docsController
                                          .profileDocumentToShow.civilId = null;
                                      break;
                                    case DocTypes.civilIdBack:
                                      _docsController
                                          .profileDocument.civilIdBack = null;
                                      _docsController.profileDocumentToShow
                                          .civilIdBack = null;
                                      break;
                                    case DocTypes.bankAccountLetter:
                                      _docsController.profileDocument
                                          .bankAccountLetter = null;
                                      _docsController.profileDocumentToShow
                                          .bankAccountLetter = null;
                                      break;
                                    case DocTypes.other:
                                      _docsController.profileDocument.other =
                                          null;
                                      _docsController
                                          .profileDocumentToShow.other = null;
                                      break;
                                  }
                                  _docsController.setToTrue();
                                  widget.fileName = "";
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: const Color(0xffE47E7B)
                                        .withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: Icon(
                                      EvaIcons.trash2,
                                      color: Color(0xffE47E7B),
                                    ),
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
                widget.fileName == ""
                    ? greyText("Upload", 14, fontWeight: FontWeight.w300)
                    : greyText(widget.fileName, 14,
                        fontWeight: FontWeight.w300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
