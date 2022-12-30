// ignore_for_file: body_might_complete_normally_nullable

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/bank_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class AddCustomerPage extends StatefulWidget {
  AddCustomerPage({super.key, this.customer});
  final Customer? customer;
  @override
  State<AddCustomerPage> createState() => _AddCustomerPageState();
}

class _AddCustomerPageState extends State<AddCustomerPage> {
  TextEditingController fullNameController = TextEditingController();

  TextEditingController customerPhoneNumberController = TextEditingController();

  TextEditingController customerRefrenceController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  CustomersController _customersController = Get.find();

  SignUpController _signUpController = Get.find();

  final formKey = GlobalKey<FormState>();

  String customerMobileCodeID = "1";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.customer != null) {
      logSuccess(widget.customer!.toJson());
      fullNameController.text = widget.customer!.fullName!;
      customerMobileCodeID = widget.customer!.phoneNumberCodeId ?? "1";
      customerPhoneNumberController.text = widget.customer!.phoneNumber!;
      customerRefrenceController.text =
          widget.customer!.customerReference ?? "";
      emailController.text = widget.customer!.email!;
      if (widget.customer!.bank != null) {
        _customersController.customerToEdit.bank =
            Bank.fromJson(widget.customer!.bank!.toJson());
      } else {
        _customersController.customerToEdit.bank = Bank();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          widget.customer != null ? "edit_customer".tr : "create_customer".tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: formKey,
        child: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.all(20),
          child: ListView(
            primary: false,
            children: [
              blackText("full_name".tr, 16),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                controller: fullNameController,
                validator: (s) {
                  if (s!.isEmpty) return "required";
                  return null;
                },
              ),
              const SizedBox(height: 10),
              blackText("mobile_number".tr, 16),
              Obx(() {
                List countries = _signUpController.globalData['country'];
                List<String> ids = countries
                    .map<String>(
                      (e) => e['id'].toString(),
                    )
                    .toSet()
                    .toList();
                List<String> countriesCodes = countries
                    .map<String>(
                      (e) => e['code'].toString(),
                    )
                    .toSet()
                    .toList();
                _signUpController
                    .selectPhoneNumberManagerCodeDrop(countriesCodes[0]);
                return SignUpTextField(
                  controller: customerPhoneNumberController,
                  padding: EdgeInsets.all(0),
                  keyBoardType: TextInputType.number,
                  prefixIcon: SizedBox(
                    width: 60,
                    child: DropdownButtonFormField<String>(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      isExpanded: true,
                      items: countriesCodes
                          .map((e) => DropdownMenuItem<String>(
                                child: Center(child: Text(e)),
                                value: e,
                              ))
                          .toList(),
                      value:
                          _signUpController.selectedPhoneNumberManagerCodeDrop,
                      onChanged: (value) {
                        customerMobileCodeID =
                            ids[countriesCodes.indexOf(value!)];
                      },
                    ),
                  ),
                  onchanged: (s) {
                    _signUpController.dataToRegister['phone_number_manager'] =
                        s!;
                    _signUpController.errors = {};
                  },
                  validator: (s) {
                    if (_signUpController.errors == null) return null;
                    return _signUpController.errors
                            .containsKey("phone_number_manager")
                        ? _signUpController.errors['phone_number_manager'][0]
                            .toString()
                        : null;
                  },
                  hintText: 'Manager Mobile Number',
                );
              }),
              // IntlPhoneField(
              //   validator: (s) {
              //     if (s!.number.isEmpty) return "required";
              //     return null;
              //   },
              //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
              //   dropdownIconPosition: IconPosition.trailing,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     fillColor: Color(0xffF8F8F8),
              //     filled: true,
              //     border: OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10.0),
              //         borderSide: BorderSide.none),
              //   ),
              //   initialCountryCode: 'IN',
              //   onChanged: (phone) {
              //     logSuccess(customerPhoneNumberController.text);
              //   },
              //   onCountryChanged: (value) =>
              //       customerMobileCode = "+${value.dialCode}",
              //   controller: customerPhoneNumberController,
              // ),
              const SizedBox(height: 10),
              blackText("email".tr, 16),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                controller: emailController,
                keyBoardType: TextInputType.emailAddress,
                validator: (s) {
                  if (s!.isEmpty) {
                    return "required";
                  } else if (!EmailValidator.validate(s)) {
                    return "please enter a valid email!";
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  blackText("customer_refrence".tr, 16),
                  SizedBox(width: 10),
                  greyText("(${"optional".tr})", 13)
                ],
              ),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                controller: customerRefrenceController,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 15),
              Container(
                width: w,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade100, width: 2),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        blackText("bank_info".tr, 16),
                        SizedBox(width: 10),
                        greyText("(${"optional".tr})", 14)
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (widget.customer != null) {
                          Get.to(() => BankInfoPage(customer: widget.customer!),
                              transition: Transition.rightToLeft);
                        } else {
                          Get.to(() => BankInfoPage(),
                              transition: Transition.rightToLeft);
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 30),
              CircularGoBTN(
                text: widget.customer != null
                    ? "edit_customer".tr
                    : "create_customer".tr,
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    if (widget.customer == null) {
                      _customersController.customerToCreate.fullName =
                          fullNameController.text;
                      _customersController.customerToCreate.email =
                          emailController.text;
                      _customersController.customerToCreate.phoneNumber =
                          customerPhoneNumberController.text;
                      _customersController.customerToCreate.phoneNumberCodeId =
                          customerMobileCodeID;
                      _customersController.customerToCreate.customerReference =
                          customerRefrenceController.text;
                      // logSuccess(_customersController.customerToCreate.toJson());
                      await _customersController.createCustomer();
                    } else {
                      _customersController.customerToEdit.fullName =
                          fullNameController.text;
                      _customersController.customerToEdit.id =
                          widget.customer!.id!;
                      _customersController.customerToEdit.email =
                          emailController.text;
                      _customersController.customerToEdit.phoneNumber =
                          customerPhoneNumberController.text;
                      _customersController.customerToEdit.phoneNumberCodeId =
                          customerMobileCodeID;
                      _customersController.customerToEdit.customerReference =
                          customerRefrenceController.text;
                      // logSuccess(_customersController.customerToCreate.toJson());
                      await _customersController.editCustomer();
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
