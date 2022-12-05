import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class MyDialogs {
  static void showDeleteDialoge(
      {required void Function()? onProceed,
      void Function()? onCancel,
      required String message}) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              "assets/images/trash.svg",
              width: 70,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 60.0.w,
              child: blackText(message, 15, textAlign: TextAlign.center),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onCancel ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    width: 28.0.w,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffBBBBBB),
                      ),
                    ),
                    child: Center(
                      child: greyText("Cancel", 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onProceed,
                  child: Container(
                    width: 28.0.w,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE47E7B),
                    ),
                    child: Center(
                      child: whiteText("Delete", 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static void showWarningDialoge({
    required void Function()? onProceed,
    void Function()? onCancel,
    required String message,
    required String yesBTN,
  }) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              image: AssetImage("assets/images/warning.png"),
              width: 70,
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 60.0.w,
              child: blackText(message, 15, textAlign: TextAlign.center),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onCancel ??
                      () {
                        Get.back();
                      },
                  child: Container(
                    width: 28.0.w,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        width: 1,
                        color: Color(0xffBBBBBB),
                      ),
                    ),
                    child: Center(
                      child: greyText("Cancel", 14),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onProceed,
                  child: Container(
                    width: 28.0.w,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Color(0xffE47E7B),
                    ),
                    child: Center(
                      child: whiteText(yesBTN, 14),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static void showSavedSuccessfullyDialoge(
      {required String title, required String btnTXT, void Function()? onTap}) {
    Get.defaultDialog(
      title: "",
      content: Column(
        children: [
          Image(
            image: AssetImage("assets/images/tick.png"),
            // width: 70,

            height: 100,
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: blackText(
              title,
              title.length > 30 ? 14 : 16,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 10),
          InkWell(
            onTap: onTap ??
                () {
                  Future(() => Get.back());
                },
            child: Container(
              width: 50.0.w,
              padding: EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Color(0xff2D5571),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(child: whiteText(btnTXT, 17)),
            ),
          )
        ],
      ),
    );
  }
}
