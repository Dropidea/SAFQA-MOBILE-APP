import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/social%20media/controller/social_media_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/models/social_media_link.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateSocialMediaPage extends StatefulWidget {
  CreateSocialMediaPage({super.key, this.scialMediaToEdit});
  final SocialMedia? scialMediaToEdit;
  @override
  State<CreateSocialMediaPage> createState() => CreateSocialMediaPageState();
}

class CreateSocialMediaPageState extends State<CreateSocialMediaPage> {
  LocalsController _localsController = Get.put(LocalsController());
  SocialMediaController _socialMediaController = Get.find();
  SocialMedia socialMediaToCreate = SocialMedia();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.scialMediaToEdit != null) {}
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
              widget.scialMediaToEdit != null ? "edit".tr : "create".tr, 16),

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
                    if (widget.scialMediaToEdit != null) {
                      widget.scialMediaToEdit!.nameEn = s;
                    } else {
                      socialMediaToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.scialMediaToEdit != null
                      ? widget.scialMediaToEdit!.nameEn
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
                    if (widget.scialMediaToEdit != null) {
                      widget.scialMediaToEdit!.nameAr = s;
                    } else {
                      socialMediaToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.scialMediaToEdit != null
                      ? widget.scialMediaToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("icon".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.scialMediaToEdit != null) {
                      widget.scialMediaToEdit!.icon = s;
                    } else {
                      socialMediaToCreate.icon = s;
                    }
                  },
                  initialValue: widget.scialMediaToEdit != null
                      ? widget.scialMediaToEdit!.icon
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
                          widget.scialMediaToEdit != null
                              ? "edit".tr
                              : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.scialMediaToEdit != null) {
                              await _socialMediaController
                                  .editSocialMedia(widget.scialMediaToEdit!);
                            } else {
                              await _socialMediaController
                                  .createSocialMedia(socialMediaToCreate);
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
