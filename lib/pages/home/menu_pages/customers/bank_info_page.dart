import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class BankInfoPage extends StatelessWidget {
  BankInfoPage({super.key});
  TextEditingController bankNameControler = TextEditingController();
  TextEditingController bankAccountControler = TextEditingController();
  TextEditingController ibanControler = TextEditingController();

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
          "Bank Info",
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: w,
        height: h,
        padding: const EdgeInsets.all(20),
        child: ListView(
          primary: false,
          children: [
            const SizedBox(height: 20),
            blackText("Bank Name", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: bankNameControler,
            ),
            //TODO:Bank dropdown need to be fixed
            const SizedBox(height: 20),
            blackText("Bank Account", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: bankAccountControler,
            ),
            const SizedBox(height: 20),
            blackText("Iban", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: ibanControler,
              textInputAction: TextInputAction.done,
              keyBoardType: TextInputType.number,
            ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
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
                            Get.back();
                            Get.back();
                          },
                          child: Container(
                            width: w / 2,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xff2D5571),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(child: whiteText("Next", 17)),
                          ),
                        )
                      ],
                    ),
                  );
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
            )
          ],
        ),
      ),
    );
  }
}
