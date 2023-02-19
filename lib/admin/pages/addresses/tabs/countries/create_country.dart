import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateCountryPage extends StatefulWidget {
  CreateCountryPage({super.key, this.countryToEdit});
  final Country? countryToEdit;
  @override
  State<CreateCountryPage> createState() => CreateCountryPageState();
}

class CreateCountryPageState extends State<CreateCountryPage> {
  LocalsController _localsController = Get.put(LocalsController());
  GlobalDataController _globalDataController = Get.find();
  Country countryToCreate = Country();
  TextEditingController flagController = TextEditingController();
  int isActive = 0;
  var logo;
  String fileName = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.countryToEdit != null) {
      isActive = widget.countryToEdit!.countryActive!;
      flagController.text = widget.countryToEdit!.flag!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: blackText(
              widget.countryToEdit != null
                  ? "edit_country".tr
                  : "create_country".tr,
              16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText("name_en".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.nameEn = s;
                      } else {
                        countryToCreate.nameEn = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.nameEn
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("name_ar".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.nameAr = s;
                      } else {
                        countryToCreate.nameAr = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.nameAr
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("code".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    keyBoardType: TextInputType.number,
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.code = s;
                      } else {
                        countryToCreate.code = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.code.toString()
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("nationality_ar".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.nationalityAr = s;
                      } else {
                        countryToCreate.nationalityAr = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.nationalityAr.toString()
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("nationality_en".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.nationalityEn = s;
                      } else {
                        countryToCreate.nationalityEn = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.nationalityEn.toString()
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("currency".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.currency = s;
                      } else {
                        countryToCreate.currency = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.currency.toString()
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("short_currency".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.countryToEdit != null) {
                        widget.countryToEdit!.shortCurrency = s;
                      } else {
                        countryToCreate.shortCurrency = s;
                      }
                    },
                    initialValue: widget.countryToEdit != null
                        ? widget.countryToEdit!.shortCurrency.toString()
                        : null,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("flag".tr, 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SignUpTextField(
                        width: 2 * w / 3,
                        padding: EdgeInsets.all(0),
                        readOnly: true,
                        controller: flagController,
                        onchanged: (s) {
                          if (widget.countryToEdit != null) {
                            widget.countryToEdit!.flag = s;
                          } else {
                            countryToCreate.flag = s;
                          }
                        },
                        hintText: "No File Chosen",
                        validator: (s) {
                          if (s!.isEmpty) return "Can't be empty";
                        },
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                          onTap: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles();
                            if (result != null) {
                              File file = File(result.files.single.path!);
                              fileName =
                                  result.files.single.path!.split("/").last;
                              logo = file;
                              flagController.text = fileName;
                              setState(() {});
                            } else {
                              // User canceled the picker
                            }
                          },
                          child: Container(
                            width: 80,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Color(0xff2F6782),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                )),
                            child: Center(child: whiteText("choose".tr, 13)),
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  blackText("is_active".tr, 16),
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
                                radioColor: Color(0xff66B4D2),
                                inactiveIcon: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey.shade300,
                                ),
                                size: GFSize.SMALL,
                                value: 1,
                                groupValue: isActive,
                                onChanged: (value) => setState(() {
                                      isActive = value;
                                      if (widget.countryToEdit == null) {
                                        countryToCreate.countryActive = value;
                                      } else {
                                        widget.countryToEdit!.countryActive =
                                            value;
                                      }
                                    })),
                          ),
                          greyText("yes".tr, 16),
                        ],
                      ),
                      SizedBox(width: 30),
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
                                value: 0,
                                groupValue: isActive,
                                onChanged: (value) => setState(() {
                                      isActive = value;
                                      if (widget.countryToEdit == null) {
                                        countryToCreate.countryActive = value;
                                      } else {
                                        widget.countryToEdit!.countryActive =
                                            value;
                                      }
                                    })),
                          ),
                          greyText("no".tr, 16),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        blackText(
                            widget.countryToEdit != null
                                ? "edit_country".tr
                                : "create_country".tr,
                            16),
                        SizedBox(width: 10),
                        GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              if (widget.countryToEdit != null) {
                                await _globalDataController.editCountry(
                                    widget.countryToEdit!, logo);
                              } else {
                                await _globalDataController.createCountry(
                                    countryToCreate, logo);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            padding: EdgeInsets.all(20),
                            child: Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 22.0.sp,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
