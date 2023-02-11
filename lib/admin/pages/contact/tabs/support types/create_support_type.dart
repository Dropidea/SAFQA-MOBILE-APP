import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/contact/model/support_type.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateSupportTypePage extends StatefulWidget {
  CreateSupportTypePage({super.key, this.SupportTypeToEdit});
  final SupportType? SupportTypeToEdit;
  @override
  State<CreateSupportTypePage> createState() => CreateSupportTypePageState();
}

class CreateSupportTypePageState extends State<CreateSupportTypePage> {
  LocalsController _localsController = Get.put(LocalsController());
  ContactController _contactController = Get.find();
  SupportType supportTypeToCreate = SupportType();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.SupportTypeToEdit != null) {}
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
              widget.SupportTypeToEdit != null ? "edit".tr : "create".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("name".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.SupportTypeToEdit != null) {
                      widget.SupportTypeToEdit!.name = s;
                    } else {
                      supportTypeToCreate.name = s;
                    }
                  },
                  initialValue: widget.SupportTypeToEdit != null
                      ? widget.SupportTypeToEdit!.name
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
                          widget.SupportTypeToEdit != null
                              ? "edit".tr
                              : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.SupportTypeToEdit != null) {
                              await _contactController
                                  .editSupportType(widget.SupportTypeToEdit!);
                            } else {
                              await _contactController
                                  .createSupportType(supportTypeToCreate);
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
