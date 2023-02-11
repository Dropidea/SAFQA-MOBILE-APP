import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/payment%20methods/controller/payment_methods_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/commisions/models/payment_metods.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreatePaymentMethodPage extends StatefulWidget {
  CreatePaymentMethodPage({super.key, this.paymentMethodToEdit});
  final PaymentMethod? paymentMethodToEdit;
  @override
  State<CreatePaymentMethodPage> createState() =>
      CreatePaymentMethodPageState();
}

class CreatePaymentMethodPageState extends State<CreatePaymentMethodPage> {
  LocalsController _localsController = Get.put(LocalsController());
  paymentMethodsController _paymentMethodsController = Get.find();
  PaymentMethod paymentMethodToCreate = PaymentMethod();
  TextEditingController logoController = TextEditingController();
  int isActive = 0;
  var logo;
  String fileName = "";
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.paymentMethodToEdit != null) {}
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
              widget.paymentMethodToEdit != null
                  ? "edit_payment_method".tr
                  : "create_payment_method".tr,
              16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("name_en".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.paymentMethodToEdit != null) {
                      widget.paymentMethodToEdit!.nameEn = s;
                    } else {
                      paymentMethodToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.paymentMethodToEdit != null
                      ? widget.paymentMethodToEdit!.nameEn
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
                    if (widget.paymentMethodToEdit != null) {
                      widget.paymentMethodToEdit!.nameAr = s;
                    } else {
                      paymentMethodToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.paymentMethodToEdit != null
                      ? widget.paymentMethodToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("Commission Safqa".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  keyBoardType: TextInputType.number,
                  onchanged: (s) {
                    if (widget.paymentMethodToEdit != null) {
                      widget.paymentMethodToEdit!.commissionSafqa =
                          int.parse(s!);
                    } else {
                      paymentMethodToCreate.commissionSafqa = int.parse(s!);
                    }
                  },
                  initialValue: widget.paymentMethodToEdit != null
                      ? widget.paymentMethodToEdit!.commissionSafqa.toString()
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("Commission Bank".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  keyBoardType: TextInputType.number,
                  onchanged: (s) {
                    if (widget.paymentMethodToEdit != null) {
                      widget.paymentMethodToEdit!.commissionBank =
                          int.parse(s!);
                    } else {
                      paymentMethodToCreate.commissionBank = int.parse(s!);
                    }
                  },
                  initialValue: widget.paymentMethodToEdit != null
                      ? widget.paymentMethodToEdit!.commissionBank.toString()
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("logo".tr, 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SignUpTextField(
                      width: 2 * w / 3,
                      padding: EdgeInsets.all(0),
                      readOnly: true,
                      controller: logoController,
                      onchanged: (s) {
                        if (widget.paymentMethodToEdit != null) {
                          widget.paymentMethodToEdit!.logo = s;
                        } else {
                          paymentMethodToCreate.logo = s;
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
                            logoController.text = fileName;
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
                                    paymentMethodToCreate.isActive = value;
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
                                    paymentMethodToCreate.isActive = value;
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
                          widget.paymentMethodToEdit != null
                              ? "edit_payment_method".tr
                              : "create_payment_method".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            logSuccess(paymentMethodToCreate.toJson());
                            if (widget.paymentMethodToEdit != null) {
                              // await _langController
                              //     .editlang(widget.paymentMethodToEdit!);
                            } else {
                              await _paymentMethodsController
                                  .createPaymentMethod(
                                      paymentMethodToCreate, logo);
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
        ));
  }
}
