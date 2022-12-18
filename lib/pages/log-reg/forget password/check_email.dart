import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/pages/log-reg/login.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key, required this.phoneEmailFlag});
  final bool phoneEmailFlag;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: MyAppBar(title: ""),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              Get.offAll(() => LoginPage());
            },
            child: Center(
              child: Lottie.asset(
                  phoneEmailFlag ? "assets/message.zip" : "assets/email.zip",
                  width: w - 50,
                  fit: BoxFit.cover

                  // image: AssetImage("assets/images/email_check.gif"),
                  // fit: BoxFit.cover,
                  ),
            ),
          ),
          Center(
            child: blackText(
              phoneEmailFlag
                  ? "check_your_phone_messages".tr
                  : "check_your_email".tr,
              18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 0.75 * w,
              child: greyText(phoneEmailFlag ? "phone_c".tr : "email_c".tr, 14,
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
