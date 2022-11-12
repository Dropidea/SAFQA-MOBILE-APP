import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/bank_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class AddCustomerPage extends StatelessWidget {
  AddCustomerPage({super.key});
  TextEditingController fullNameControler = TextEditingController();
  TextEditingController customerPhoneNumberControler = TextEditingController();
  TextEditingController customerRefrenceControler = TextEditingController();
  TextEditingController emailControler = TextEditingController();
  String customerMobileCode = "+20";

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
          "Add Customer",
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
            blackText("Full Name", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: fullNameControler,
            ),
            const SizedBox(height: 10),
            blackText("Mobile number", 16),
            IntlPhoneField(
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
              initialCountryCode: 'IN',
              onChanged: (phone) {
                logSuccess(customerPhoneNumberControler.text);
              },
              onCountryChanged: (value) =>
                  customerMobileCode = "+${value.dialCode}",
              controller: customerPhoneNumberControler,
            ),
            const SizedBox(height: 10),
            blackText("Email", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: emailControler,
              keyBoardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                blackText("Customer Reference", 16),
                SizedBox(width: 10),
                greyText("(optional)", 13)
              ],
            ),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerRefrenceControler,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 15),
            Container(
              width: w,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade100, width: 2),
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      blackText("Bank Info", 16),
                      SizedBox(width: 10),
                      greyText("(Optional)", 14)
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      Get.to(() => BankInfoPage(),
                          transition: Transition.rightToLeft);
                    },
                    child: Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        Icons.arrow_forward,
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  blackText("Add the customer", 16),
                  SizedBox(width: 10),
                  InkWell(
                    customBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    onTap: () async {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(40),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 22.0.sp,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
