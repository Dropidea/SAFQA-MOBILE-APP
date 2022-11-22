import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WhiteAppBar(title: "Reset Password"),
      body: Form(
        key: formKey,
        child: ListView(
          primary: false,
          padding: EdgeInsets.all(20),
          children: [
            blackText("New password", 15),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 20),
            blackText("Confirm New Password", 15),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              autovalidateMode: AutovalidateMode.onUserInteraction,
            ),
            SizedBox(height: 50),
            WallpepredBTN(
              text: "Save",
              haveWallpaper: false,
              width: 0.75 * w,
              onTap: () {
                if (formKey.currentState!.validate()) {}
              },
            )
          ],
        ),
      ),
    );
  }
}
