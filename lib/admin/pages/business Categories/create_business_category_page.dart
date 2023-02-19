import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/business%20Categories/controller/business_categories_controller.dart';
import 'package:safqa/admin/pages/business%20Categories/model/business_category.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateBusinessCategoryPage extends StatefulWidget {
  CreateBusinessCategoryPage({super.key, this.businessCategoryToEdit});
  final BusinessCategory? businessCategoryToEdit;
  @override
  State<CreateBusinessCategoryPage> createState() =>
      CreateBusinessCategoryPageState();
}

class CreateBusinessCategoryPageState
    extends State<CreateBusinessCategoryPage> {
  LocalsController _localsController = Get.put(LocalsController());
  BusinessCategoryController _businessCategoryController = Get.find();
  BusinessCategory businessCategoryToCreate = BusinessCategory();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.businessCategoryToEdit != null) {}
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
              widget.businessCategoryToEdit != null
                  ? "edit_business_category".tr
                  : "create_business_category".tr,
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
                blackText("category_name_en".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.businessCategoryToEdit != null) {
                      widget.businessCategoryToEdit!.nameEn = s;
                    } else {
                      businessCategoryToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.businessCategoryToEdit != null
                      ? widget.businessCategoryToEdit!.nameEn
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("category_name_ar".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.businessCategoryToEdit != null) {
                      widget.businessCategoryToEdit!.nameAr = s;
                    } else {
                      businessCategoryToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.businessCategoryToEdit != null
                      ? widget.businessCategoryToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText(
                          widget.businessCategoryToEdit != null
                              ? "edit_category".tr
                              : "create_category".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.businessCategoryToEdit != null) {
                              await _businessCategoryController
                                  .editBusinessCategory(
                                      widget.businessCategoryToEdit!);
                            } else {
                              await _businessCategoryController
                                  .createBusinessCategory(
                                      businessCategoryToCreate);
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
