// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';

class CustomerInfoPage extends StatelessWidget {
  CustomerInfoPage({super.key});
  TextEditingController customerNameControler = TextEditingController();
  TextEditingController customerPhoneNumberControler = TextEditingController();
  TextEditingController customerEmailControler = TextEditingController();
  TextEditingController customerRefrenceControler = TextEditingController();
  CustomersController _customersController = Get.find();
  AddInvoiceController _addInvoiceController = Get.find();
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
          "Customer Info",
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
            // SignUpTextField(
            //   padding: EdgeInsets.all(0),
            // ),
            SearchField<Customer>(
              itemHeight: 40,

              searchInputDecoration: InputDecoration(
                fillColor: Color(0xffF8F8F8),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
              searchStyle: TextStyle(fontSize: 13.0.sp),
              suggestionStyle: TextStyle(fontSize: 13.0.sp),
              // onSubmit: (p0) => logSuccess(p0),

              suggestionItemDecoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),

              onSuggestionTap: (p0) {
                FocusScope.of(context).unfocus();

                customerPhoneNumberControler.text = p0.item!.phoneNumber!;
                customerEmailControler.text = p0.item!.email!;
                customerRefrenceControler.text = p0.item!.customerReference!;
              },
              controller: customerNameControler,
              suggestions: _customersController.customers
                  .map(
                    (e) => SearchFieldListItem<Customer>(e.fullName!,
                        item: e,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: greyText(e.fullName!, 15),
                        )),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            blackText("Send invoice By", 16),
            CustomDropdown(
              items: _addInvoiceController.sendByItems,
              selectedItem: _addInvoiceController.selectedSendBy,
              width: 2,
              onchanged: (s) {
                _addInvoiceController.selectSendBy(s);
              },
            ),
            const SizedBox(height: 20),
            blackText("Customer phone number", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerPhoneNumberControler,
              keyBoardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            blackText("Customer email", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerEmailControler,
              keyBoardType: TextInputType.number,
            ),
            // IntlPhoneField(
            //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
            //   dropdownIconPosition: IconPosition.trailing,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     fillColor: Color(0xffF8F8F8),
            //     filled: true,
            //     border: OutlineInputBorder(
            //         borderRadius: new BorderRadius.circular(10.0),
            //         borderSide: BorderSide.none),
            //   ),
            //   initialCountryCode: 'AE',
            //   onChanged: (phone) {
            //     logSuccess(customerPhoneNumberControler.text);
            //   },
            //   onCountryChanged: (value) =>
            //       customerMobileCode = "+${value.dialCode}",
            //   controller: customerPhoneNumberControler,
            // ),
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
                  _addInvoiceController.saveCustomerInfo(
                    customerNameControler.text,
                    _addInvoiceController.sendByItems
                            .indexOf(_addInvoiceController.selectedSendBy) +
                        1,
                    customerEmailControler.text,
                    customerPhoneNumberControler.text,
                    customerMobileCode,
                    customerRefrenceControler.text,
                  );

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

Text blueText(String text, double size,
    {bool underline = false,
    FontWeight? fontWeight,
    double? decorationThickness}) {
  return Text(
    text,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: decorationThickness ?? 6,
        color: Color(0xff2F6782),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text blackText(String text, double size,
    {bool underline = false, FontWeight? fontWeight, TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text prblackText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Color(0xff484848),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text whiteText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greyText(String text, double size,
    {bool underline = false, FontWeight? fontWeight, TextAlign? textAlign}) {
  return Text(
    text,
    softWrap: true,
    textAlign: textAlign,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff8B8B8B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greyARText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    textAlign: TextAlign.end,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff8B8B8B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greenText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff58D241),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text redText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xffE47E7B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}
