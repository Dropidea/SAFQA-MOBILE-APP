import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/pages/log-reg/forget%20password/reset_password.dart';

class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key, required this.phoneEmailFlag});
  final bool phoneEmailFlag;
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WhiteAppBar(title: ""),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => ResetPasswordWithEmailPage(),
                  transition: Transition.rightToLeft);
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
              phoneEmailFlag ? "Check Your phone messages" : "Check Your Email",
              18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Center(
            child: SizedBox(
              width: 0.75 * w,
              child: greyText(
                  phoneEmailFlag
                      ? "Messages will be sent to your phone please check the message"
                      : "Messages will be sent to your email please check the message",
                  14,
                  textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}
