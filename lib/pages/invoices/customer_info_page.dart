import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/pages/invoices/create_invoice_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CustomerInfoPage extends StatelessWidget {
  const CustomerInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    AddInvoiceController addInvoiceController = Get.find();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Create a New Invoice",
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
            blueText("Customer Info.", 15),
            Divider(thickness: 1.5),
            const SizedBox(height: 20),
            blackText("Customer Name", 16),
            SignUpTextField(),
            const SizedBox(height: 20),
            blackText("Send invoice By", 16),
            customDropdown(
              addInvoiceController.sendByItems,
              addInvoiceController.selectedSendBy,
              2,
              addInvoiceController.selectSendBy,
            ),
            const SizedBox(height: 20),
            blackText("Customer phonne number", 16),
            Container(
              width: w,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 15, right: 15),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: IntlPhoneField(
                dropdownIconPosition: IconPosition.trailing,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                initialCountryCode: 'IN',
                onChanged: (phone) {},
              ),
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                blackText("Customer Reference", 16),
                SizedBox(width: 10),
                greyText("(optional)", 13)
              ],
            ),
            SignUpTextField(),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff326C88),
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

Text blueText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
        color: Color(0xff2F6782),
        fontWeight: FontWeight.w500,
        fontSize: size.sp),
  );
}

Text blackText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: size.sp),
  );
}

Text greyText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
        color: const Color(0xff8B8B8B),
        fontWeight: FontWeight.w500,
        fontSize: size.sp),
  );
}
