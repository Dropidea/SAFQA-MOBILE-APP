import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/pages/log-reg/forget%20password/check_email.dart';
import 'package:safqa/pages/log-reg/forget%20password/controller/password_controller.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class ForgetPasswordPage extends StatefulWidget {
  ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  bool phoneEmailFlag = false;
  String mobileCode = "";
  PasswordController _passwordController = Get.put(PasswordController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(title: "reset_password".tr),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          blackText(
              phoneEmailFlag ? "write_your_ph_num".tr : "write_your_email".tr,
              15),
          Form(
            key: formKey,
            child: phoneEmailFlag
                ? Directionality(
                    textDirection: TextDirection.ltr,
                    child: IntlPhoneField(
                      flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
                      dropdownIconPosition: IconPosition.trailing,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      initialCountryCode: 'AE',
                      onChanged: (phone) {},
                      onCountryChanged: (value) =>
                          mobileCode = "+${value.dialCode}",
                      controller: phoneController,
                      validator: (p0) {
                        if (p0!.number.isEmpty) {
                          return "can't be empty";
                        }
                        return null;
                      },
                    ),
                  )
                : SignUpTextField(
                    padding: EdgeInsets.all(0),
                    keyBoardType: TextInputType.emailAddress,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    textDirection: TextDirection.ltr,
                    validator: (s) {
                      if (!EmailValidator.validate(s!)) {
                        return "please_enter_a_valid_email".tr;
                      } else if (s.isEmpty) {
                        return "can't be empty";
                      } else {
                        return null;
                      }
                    },
                  ),
          ),
          SizedBox(height: 20),
          WallpepredBTN(
            text: "next".tr,
            haveWallpaper: false,
            width: 0.75 * w,
            onTap: () async {
              if (formKey.currentState!.validate()) {
                if (!phoneEmailFlag) {
                  bool res = await _passwordController
                      .forgetPassWordEmail(emailController.text);
                  if (res) {
                    Get.to(() => CheckEmailPage(phoneEmailFlag: phoneEmailFlag),
                        transition: Transition.rightToLeft);
                  } else {
                    MyDialogs.showWarningDialoge2(
                        onProceed: () {
                          Get.back();
                        },
                        message: "Your Email is Invalid",
                        yesBTN: "close");
                  }
                } else {
                  Get.to(() => CheckEmailPage(phoneEmailFlag: phoneEmailFlag),
                      transition: Transition.rightToLeft);
                }
              }
            },
          ),
          SizedBox(height: 20),
          Align(
            child: GestureDetector(
              onTap: () {
                phoneEmailFlag = !phoneEmailFlag;
                setState(() {});
              },
              child: Container(
                decoration: const BoxDecoration(
                    border: Border(
                  bottom: BorderSide(
                    width: 2,
                    color: Color(0xff2F6782),
                  ),
                )),
                child: blueText(
                  phoneEmailFlag ? "try_email".tr : "try_ph_num".tr,
                  14,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
