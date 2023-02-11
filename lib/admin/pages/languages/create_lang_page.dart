import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/languages/controller/language_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateLanguagePage extends StatefulWidget {
  CreateLanguagePage({super.key, this.languageToEdit});
  final Language? languageToEdit;
  @override
  State<CreateLanguagePage> createState() => _CreateLanguagePageState();
}

class _CreateLanguagePageState extends State<CreateLanguagePage> {
  LocalsController _localsController = Get.put(LocalsController());
  LanguageController _languageController = Get.find();
  Language languageToCreate = Language();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.languageToEdit != null) {}
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
          title: blackText("create_lang".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("language".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.languageToEdit != null) {
                      widget.languageToEdit!.name = s;
                    } else {
                      languageToCreate.name = s;
                    }
                  },
                  initialValue: widget.languageToEdit != null
                      ? widget.languageToEdit!.name
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("short_name".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.languageToEdit != null) {
                      widget.languageToEdit!.shortName = s;
                    } else {
                      languageToCreate.shortName = s;
                    }
                  },
                  initialValue: widget.languageToEdit != null
                      ? widget.languageToEdit!.shortName
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("slug".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.languageToEdit != null) {
                      widget.languageToEdit!.slug = s;
                    } else {
                      languageToCreate.slug = s;
                    }
                  },
                  initialValue: widget.languageToEdit != null
                      ? widget.languageToEdit!.slug
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
                          widget.languageToEdit != null
                              ? "edit_lang".tr
                              : "create_lang".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            logSuccess(languageToCreate.toJson());
                            if (widget.languageToEdit != null) {
                              // await _langController
                              //     .editlang(widget.languageToEdit!);
                            } else {
                              await _languageController
                                  .createLanguage(languageToCreate);
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
