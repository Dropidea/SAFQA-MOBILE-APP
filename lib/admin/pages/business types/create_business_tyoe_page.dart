import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/business%20types/controller/business_types_controller.dart';
import 'package:safqa/admin/pages/business%20types/models/business_type.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateBusinessTypePage extends StatefulWidget {
  CreateBusinessTypePage({super.key, this.businessTypeToEdit});
  final BusinessType? businessTypeToEdit;
  @override
  State<CreateBusinessTypePage> createState() => CreateBusinessTypePageState();
}

class CreateBusinessTypePageState extends State<CreateBusinessTypePage> {
  LocalsController _localsController = Get.put(LocalsController());
  BusinessTypesController _businessTypesController = Get.find();
  BusinessType businessTypeToCreate = BusinessType();
  TextEditingController logoController = TextEditingController();
  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.businessTypeToEdit != null) {}
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
          title: blackText("create_business_type".tr, 16),

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
                    if (widget.businessTypeToEdit != null) {
                      widget.businessTypeToEdit!.nameEn = s;
                    } else {
                      businessTypeToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.businessTypeToEdit != null
                      ? widget.businessTypeToEdit!.nameEn
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
                    if (widget.businessTypeToEdit != null) {
                      widget.businessTypeToEdit!.nameAr = s;
                    } else {
                      businessTypeToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.businessTypeToEdit != null
                      ? widget.businessTypeToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("business_logo".tr, 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SignUpTextField(
                      width: 2 * w / 3,
                      padding: EdgeInsets.all(0),
                      readOnly: true,
                      controller: logoController,
                      onchanged: (s) {
                        if (widget.businessTypeToEdit != null) {
                          widget.businessTypeToEdit!.nameAr = s;
                        } else {
                          businessTypeToCreate.nameAr = s;
                        }
                      },
                      hintText: "No File Chosen",
                      validator: (s) {
                        if (s!.isEmpty) return "Can't be empty";
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                        onTap: () {},
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText(
                          widget.businessTypeToEdit != null
                              ? "edit_business_type".tr
                              : "create_business_type".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            logSuccess(businessTypeToCreate.toJson());
                            if (widget.businessTypeToEdit != null) {
                              // await _langController
                              //     .editlang(widget.businessTypeToEdit!);
                            } else {
                              // await _businessTypeController
                              //     .createBusinessType(
                              //         businessTypeToCreate);
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
