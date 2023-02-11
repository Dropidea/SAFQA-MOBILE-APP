import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateBankPage extends StatefulWidget {
  CreateBankPage({super.key, this.bankToEdit});
  final Bank? bankToEdit;
  @override
  State<CreateBankPage> createState() => _CreateBankPageState();
}

class _CreateBankPageState extends State<CreateBankPage> {
  TextEditingController bankNameController = TextEditingController();
  GlobalDataController _globalDataController = Get.find();
  LocalsController _localsController = Get.put(LocalsController());
  BankController _bankController = Get.find();
  Bank bankToCreate = Bank(isActive: 0);

  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    if (widget.bankToEdit != null) {
      isActive = widget.bankToEdit!.isActive!;
    }
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
          title: blackText("create_bank".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("bank_name".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    if (widget.bankToEdit != null) {
                      widget.bankToEdit!.name = s;
                    } else {
                      bankToCreate.name = s;
                    }
                  },
                  initialValue: widget.bankToEdit != null
                      ? widget.bankToEdit!.name
                      : null,
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("country".tr, 16),
                CustomDropdownV2(
                    validator: (p0) {
                      if (p0 == null) return "Can't be empty";
                    },
                    hint: "choose".tr,
                    width: w,
                    selectedItem: widget.bankToEdit != null
                        ? _localsController.currenetLocale == 0
                            ? _globalDataController.countries
                                .firstWhere((element) =>
                                    element.id == widget.bankToEdit!.countryId)
                                .nameEn
                            : _globalDataController.countries
                                .firstWhere((element) =>
                                    element.id == widget.bankToEdit!.countryId)
                                .nameAr
                        : null,
                    items: _globalDataController.countries
                        .map((e) => _localsController.currenetLocale == 0
                            ? e.nameEn!
                            : e.nameAr!)
                        .toList(),
                    onchanged: (v) {
                      if (widget.bankToEdit != null) {
                        widget.bankToEdit!.countryId = _globalDataController
                            .countries
                            .firstWhere((element) =>
                                element.nameAr == v || element.nameEn == v)
                            .id!;
                      } else {
                        bankToCreate.countryId = _globalDataController.countries
                            .firstWhere((element) =>
                                element.nameAr == v || element.nameEn == v)
                            .id!;
                      }
                    }),
                SizedBox(height: 20),
                blackText("is_active".tr, 16),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              inactiveBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              value: 1,
                              groupValue: isActive,
                              onChanged: (value) => setState(() {
                                    isActive = value;
                                    if (widget.bankToEdit != null) {
                                      widget.bankToEdit!.isActive = isActive;
                                    } else {
                                      bankToCreate.isActive = isActive;
                                    }
                                  })),
                        ),
                        greyText("yes".tr, 16),
                      ],
                    ),
                    SizedBox(width: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              inactiveBorderColor: Colors.transparent,
                              value: 0,
                              groupValue: isActive,
                              onChanged: (value) => setState(() {
                                    isActive = value;
                                    if (widget.bankToEdit != null) {
                                      widget.bankToEdit!.isActive = isActive;
                                    } else {
                                      bankToCreate.isActive = isActive;
                                    }
                                  })),
                        ),
                        greyText("no".tr, 16),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText(
                          widget.bankToEdit != null
                              ? "edit_bank".tr
                              : "create_bank".tr,
                          16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            if (widget.bankToEdit != null) {
                              await _bankController
                                  .editBank(widget.bankToEdit!);
                            } else {
                              await _bankController.createBank(bankToCreate);
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
