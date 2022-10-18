import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CustomerInfoPage extends StatelessWidget {
  CustomerInfoPage({super.key});
  TextEditingController customerNameControler = TextEditingController();
  TextEditingController customerPhoneNumberControler = TextEditingController();
  TextEditingController customerRefrenceControler = TextEditingController();
  String customerMobileCode = "+20";

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
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerNameControler,
            ),
            const SizedBox(height: 20),
            blackText("Send invoice By", 16),
            CustomDropdown(
              items: addInvoiceController.sendByItems,
              selectedItem: addInvoiceController.selectedSendBy,
              width: 2,
              onchanged: (s) {
                addInvoiceController.selectSendBy(s);
                addInvoiceController.dataToCreateInvoice.customerSendBy =
                    (addInvoiceController.sendByItems.indexOf(s!) + 1);
              },
            ),
            const SizedBox(height: 20),
            blackText("Customer phone number", 16),
            IntlPhoneField(
              flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
              dropdownIconPosition: IconPosition.trailing,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                fillColor: Colors.grey.shade200,
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
            ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
                  addInvoiceController.saveCustomerInfo(
                      customerNameControler.text,
                      addInvoiceController.sendByItems
                              .indexOf(addInvoiceController.selectedSendBy) +
                          1,
                      customerPhoneNumberControler.text,
                      customerMobileCode,
                      customerRefrenceControler.text);

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
    softWrap: true,
    style: TextStyle(
        color: Colors.black, fontWeight: FontWeight.w500, fontSize: size.sp),
  );
}

Text whiteText(String text, double size) {
  return Text(
    text,
    style: TextStyle(
        color: Colors.white, fontWeight: FontWeight.w500, fontSize: size.sp),
  );
}

Text greyText(String text, double size) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        color: const Color(0xff8B8B8B),
        fontWeight: FontWeight.w500,
        fontSize: size.sp),
  );
}
