import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/city.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateCityPage extends StatefulWidget {
  CreateCityPage({super.key, this.cityToEdit});
  final City? cityToEdit;
  @override
  State<CreateCityPage> createState() => CreateCityState();
}

class CreateCityState extends State<CreateCityPage> {
  LocalsController _localsController = Get.put(LocalsController());
  GlobalDataController _globalDataController = Get.find();
  City cityToCreate = City();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.cityToEdit != null) {}
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
              widget.cityToEdit != null ? "edit".tr : "create".tr, 16),

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
                    if (widget.cityToEdit != null) {
                      widget.cityToEdit!.nameEn = s;
                    } else {
                      cityToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.cityToEdit != null
                      ? widget.cityToEdit!.nameEn
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
                    if (widget.cityToEdit != null) {
                      widget.cityToEdit!.nameAr = s;
                    } else {
                      cityToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.cityToEdit != null
                      ? widget.cityToEdit!.nameAr
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("country".tr, 16),
                CustomDropdownV2(
                    width: w,
                    items: _globalDataController.countries
                        .map((e) => _localsController.currenetLocale == 0
                            ? e.nameEn!
                            : e.nameAr!)
                        .toSet()
                        .toList(),
                    hint: "choose".tr,
                    onchanged: (s) {}),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText(
                          widget.cityToEdit != null ? "edit".tr : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.cityToEdit != null) {
                              // await _globalDataController
                              //     .editContactPhone(widget.cityToEdit!);
                            } else {
                              // await _globalDataController
                              //     .createContactPhone(cityToCreate);
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
