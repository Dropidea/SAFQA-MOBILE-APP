import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/about/controller/about_controller.dart';
import 'package:safqa/admin/pages/about/model/about.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class CreateAboutPage extends StatefulWidget {
  CreateAboutPage({super.key, this.aboutToEdit});
  final About? aboutToEdit;
  @override
  State<CreateAboutPage> createState() => CreateAboutPageState();
}

class CreateAboutPageState extends State<CreateAboutPage> {
  LocalsController _localsController = Get.put(LocalsController());
  AboutController _aboutController = Get.find();
  About aboutToCreate = About();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.aboutToEdit != null) {}
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
              widget.aboutToEdit != null ? "edit".tr : "create".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("about".tr, 16),
                TextFormField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      fillColor: Color(0xffF8F8F8),
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(10.0),
                          borderSide: BorderSide.none),
                    ),
                    initialValue: widget.aboutToEdit != null
                        ? widget.aboutToEdit!.about
                        : null,
                    onChanged: (s) {
                      if (widget.aboutToEdit != null) {
                        widget.aboutToEdit!.about = s;
                      } else {
                        aboutToCreate.about = s;
                      }
                    },
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                    }),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText(
                          widget.aboutToEdit != null ? "edit".tr : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.aboutToEdit != null) {
                              await _aboutController
                                  .editAbout(widget.aboutToEdit!);
                            } else {
                              await _aboutController.createAbout(aboutToCreate);
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
