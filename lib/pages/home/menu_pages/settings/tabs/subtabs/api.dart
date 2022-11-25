import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';
import 'package:sizer/sizer.dart';

class APITab extends StatelessWidget {
  const APITab({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Container(
          width: w,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Color(0xffE47E7B).withOpacity(0.07),
          ),
          child: Center(
            child: blackText(
              "When you create a new token, The old token will be expired",
              14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(height: 20),
        blueText("Token", 15),
        SizedBox(height: 10),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          readOnly: true,
          suffixIcon: Icon(EvaIcons.copy, color: Color(0xff2F6782), size: 30),
          initialValue: "z-xixfeVVExyN6yj1LoCg3wv1db5feBAis6-1",
          style: TextStyle(color: Color(0xff2F6782), fontSize: 12.5.sp),
        ),
        SizedBox(height: 30),
        WallpepredBTN(
          alignment: Alignment.centerLeft,
          haveWallpaper: false,
          text: "Create New",
          onTap: () {},
          width: w / 1.75,
          height: 55,
          icon: EvaIcons.plus,
        )
      ],
    );
  }
}
