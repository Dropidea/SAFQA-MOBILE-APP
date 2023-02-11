import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/contacts.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateContactPhonesPage extends StatefulWidget {
  CreateContactPhonesPage({super.key, this.contactPhoneToEdit});
  final ContactPhones? contactPhoneToEdit;
  @override
  State<CreateContactPhonesPage> createState() =>
      CreateContactPhonesPageState();
}

class CreateContactPhonesPageState extends State<CreateContactPhonesPage> {
  LocalsController _localsController = Get.put(LocalsController());
  ContactController _contactController = Get.find();
  ContactPhones contactPhoneToCreate = ContactPhones();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.contactPhoneToEdit != null) {}
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
              widget.contactPhoneToEdit != null ? "edit".tr : "create".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("type".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.contactPhoneToEdit != null) {
                      widget.contactPhoneToEdit!.type = s;
                    } else {
                      contactPhoneToCreate.type = s;
                    }
                  },
                  initialValue: widget.contactPhoneToEdit != null
                      ? widget.contactPhoneToEdit!.type
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("number".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  keyBoardType: TextInputType.number,
                  onchanged: (s) {
                    if (widget.contactPhoneToEdit != null) {
                      widget.contactPhoneToEdit!.number = s;
                    } else {
                      contactPhoneToCreate.number = s;
                    }
                  },
                  initialValue: widget.contactPhoneToEdit != null
                      ? widget.contactPhoneToEdit!.number
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
                          widget.contactPhoneToEdit != null
                              ? "edit".tr
                              : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.contactPhoneToEdit != null) {
                              await _contactController
                                  .editContactPhone(widget.contactPhoneToEdit!);
                            } else {
                              await _contactController
                                  .createContactPhone(contactPhoneToCreate);
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
