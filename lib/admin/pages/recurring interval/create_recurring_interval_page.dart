import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/recurring%20interval/controller/recurring_interval_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/recurring_interval.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateRecurringIntervalPage extends StatefulWidget {
  CreateRecurringIntervalPage({super.key, this.recurringIntervalToEdit});
  final RecurringInterval? recurringIntervalToEdit;
  @override
  State<CreateRecurringIntervalPage> createState() =>
      CreateRecurringIntervalPageState();
}

class CreateRecurringIntervalPageState
    extends State<CreateRecurringIntervalPage> {
  LocalsController _localsController = Get.put(LocalsController());
  RecurringIntervalController _recurringIntervalController = Get.find();
  RecurringInterval recurringIntervalToCreate = RecurringInterval();

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.recurringIntervalToEdit != null) {}
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
              widget.recurringIntervalToEdit != null ? "edit".tr : "create".tr,
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
                    if (widget.recurringIntervalToEdit != null) {
                      widget.recurringIntervalToEdit!.nameEn = s;
                    } else {
                      recurringIntervalToCreate.nameEn = s;
                    }
                  },
                  initialValue: widget.recurringIntervalToEdit != null
                      ? widget.recurringIntervalToEdit!.nameEn
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
                    if (widget.recurringIntervalToEdit != null) {
                      widget.recurringIntervalToEdit!.nameAr = s;
                    } else {
                      recurringIntervalToCreate.nameAr = s;
                    }
                  },
                  initialValue: widget.recurringIntervalToEdit != null
                      ? widget.recurringIntervalToEdit!.nameAr
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
                          widget.recurringIntervalToEdit != null
                              ? "edit".tr
                              : "create".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.recurringIntervalToEdit != null) {
                              await _recurringIntervalController
                                  .editRecurringInterval(
                                      widget.recurringIntervalToEdit!);
                            } else {
                              await _recurringIntervalController
                                  .createRecurringInterval(
                                      recurringIntervalToCreate);
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
