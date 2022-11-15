import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class PasswordChangePage extends StatelessWidget {
  PasswordChangePage({super.key});
  TextEditingController oldPassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("Change password", 16),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.disabled,
        child: ListView(
          primary: false,
          padding: EdgeInsets.all(20),
          children: [
            blackText("Current Password", 15),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: oldPassController,
              validator: (s) {
                if (s!.isEmpty) {
                  return "cant be empty";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            blackText("New Password", 15),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: newPassController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (s) {
                if (s!.length < 6) {
                  return "password should be at least 6";
                } else if (s == oldPassController.text) {
                  return "can't be the old password";
                } else {
                  return null;
                }
              },
            ),
            SizedBox(height: 20),
            blackText("Confirm Password", 15),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: confirmPassController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (s) {
                if (s != newPassController.text) {
                  return "passwords are not match!";
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.done,
            ),
            SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    Get.dialog(AlertDialog(
                      title: Text(
                        "Change Password",
                        style: TextStyle(
                            color: Colors.red.shade700,
                            fontWeight: FontWeight.w500,
                            fontSize: 22),
                      ),
                      content: Text("Are You Sure?"),
                      actions: <Widget>[
                        TextButton(
                          child: Text("YES"),
                          onPressed: () {
                            Get.defaultDialog(
                              title: "",
                              content: Column(
                                children: [
                                  Image(
                                    image: AssetImage("assets/images/tick.png"),
                                    height: 100,
                                  ),
                                  SizedBox(height: 10),
                                  blackText("Saved successfully", 16),
                                  SizedBox(height: 10),
                                  InkWell(
                                    onTap: () {
                                      Future(() => Get.back());
                                      Future(() => Get.back());
                                      Future(() => Get.back());
                                    },
                                    child: Container(
                                      width: w / 2,
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      decoration: BoxDecoration(
                                        color: Color(0xff2D5571),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child:
                                          Center(child: whiteText("Next", 17)),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        TextButton(
                          child: Text("NO"),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff2F6782),
                    image: DecorationImage(
                      image: AssetImage("assets/images/btn_wallpaper.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 0.7 * w,
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
