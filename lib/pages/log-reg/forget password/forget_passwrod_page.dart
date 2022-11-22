import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/pages/log-reg/forget%20password/check_email.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class ForgetPasswordPage extends StatelessWidget {
  ForgetPasswordPage({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WhiteAppBar(title: "Reset Password"),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          blackText("Write Your Email", 15),
          Form(
            key: formKey,
            child: SignUpTextField(
              padding: EdgeInsets.all(0),
              keyBoardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.onUserInteraction,
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
            text: "Next",
            haveWallpaper: false,
            width: 0.75 * w,
            onTap: () {
              if (formKey.currentState!.validate()) {
                Get.to(() => CheckEmailPage(),
                    transition: Transition.rightToLeft);
              }
            },
          )
        ],
      ),
    );
  }
}
