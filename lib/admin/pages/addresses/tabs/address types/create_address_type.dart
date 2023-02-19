import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/Address_type.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateAddressTypePage extends StatefulWidget {
  CreateAddressTypePage({super.key, this.addressTypeToEdit});
  final AddressType? addressTypeToEdit;
  @override
  State<CreateAddressTypePage> createState() => CreateAddressTypePageState();
}

class CreateAddressTypePageState extends State<CreateAddressTypePage> {
  LocalsController _localsController = Get.put(LocalsController());

  AddressType addressTypeToCreate = AddressType();
  GlobalDataController _globalDataController = Get.find();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.addressTypeToEdit != null) {}
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
              widget.addressTypeToEdit != null ? "edit".tr : "create".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("name_ar".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.addressTypeToEdit != null) {
                      widget.addressTypeToEdit!.nameAr = s;
                    } else {
                      addressTypeToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.addressTypeToEdit != null
                      ? widget.addressTypeToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("name_en".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.addressTypeToEdit != null) {
                      widget.addressTypeToEdit!.nameEn = s;
                    } else {
                      addressTypeToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.addressTypeToEdit != null
                      ? widget.addressTypeToEdit!.nameEn
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
                          widget.addressTypeToEdit != null
                              ? "edit".tr
                              : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.addressTypeToEdit != null) {
                              await _globalDataController
                                  .editAddressType(widget.addressTypeToEdit!);
                            } else {
                              await _globalDataController
                                  .createAddressType(addressTypeToCreate);
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
