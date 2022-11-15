import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class BusinessDetailsPage extends StatefulWidget {
  BusinessDetailsPage({super.key});

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  TextEditingController workPhoneController =
      TextEditingController(text: "0987765123");

  bool readOnly = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: WhiteAppBar(title: "Business Details"),
      body: Container(
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            readOnly
                ? MyButton(
                    color: Color(0xffDDF5D8),
                    borderRadius: 10,
                    text: "Edit",
                    textSize: 15,
                    heigt: 50,
                    width: w - 50,
                    func: () {
                      setState(() {
                        readOnly = !readOnly;
                      });
                    },
                    textColor: Color(0xff58D241),
                    icon: Icon(
                      EvaIcons.edit,
                      color: Color(0xff58D241),
                    ),
                    border: Border.all(
                      color: Color(0xff58D241).withOpacity(0.4),
                    ),
                  )
                : MyButton(
                    color: Color.fromARGB(255, 216, 225, 245),
                    borderRadius: 10,
                    text: "Save",
                    textSize: 15,
                    heigt: 50,
                    width: w - 50,
                    func: () {
                      setState(() {
                        readOnly = !readOnly;
                      });
                    },
                    textColor: Color(0xff66B4D2),
                    icon: Icon(
                      EvaIcons.checkmarkCircle,
                      color: Color(0xff66B4D2),
                    ),
                    border: Border.all(
                      color: Color(0xff66B4D2).withOpacity(0.4),
                    ),
                  ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(20),
              primary: false,
              children: [
                blackText("Company Name", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "Tm L.L.C (تم ذ.م.م)",
                ),
                const SizedBox(height: 20),
                blackText("Category", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "Cosmetics",
                ),
                const SizedBox(height: 20),
                blackText("User Name", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "lafi s h m almutairi",
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("Work Email", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "info@tm-ae.com",
                  suffixIcon: Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Color(0xff58D241),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("Work Phone", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                Stack(
                  children: [
                    IntlPhoneField(
                      flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
                      dropdownIconPosition: IconPosition.trailing,
                      keyboardType: TextInputType.number,
                      readOnly: readOnly,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8F8F8),
                        filled: readOnly,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      initialCountryCode: 'IN',
                      onChanged: (phone) {},
                      onCountryChanged: (value) {},
                      controller: workPhoneController,
                    ),
                    PositionedDirectional(
                      end: 10,
                      top: 15,
                      child: Icon(
                        EvaIcons.checkmarkCircle2,
                        color: Color(0xff58D241),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    blackText("Website URl", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "tm-ae.com",
                ),
                const SizedBox(height: 20),
                blackText("Default Language", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "English",
                ),
                const SizedBox(height: 20),
                blackText("Invoice Expiry After", 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SignUpTextField(
                      width: 0.42 * w,
                      readOnly: readOnly,
                      padding: EdgeInsets.zero,
                      initialValue: "0",
                    ),
                    SignUpTextField(
                      width: 0.42 * w,
                      readOnly: readOnly,
                      padding: EdgeInsets.zero,
                      initialValue: "Day",
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                blackText("Products Delivery Fees", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "0.00",
                ),
                const SizedBox(height: 20),
                blackText("Promo Code", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "MI",
                ),
                const SizedBox(height: 20),
                blackText("Deposit Terms", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "Weekly",
                ),
                const SizedBox(height: 20),
                blackText("Approval Status", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: "Yes",
                  suffixIcon: Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Color(0xff58D241),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("Custom SMS AR", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("Custom SMS EN", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("Terms And Conditions", 14),
                    const SizedBox(width: 10),
                    greyText("(Optional)", 13)
                  ],
                ),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                blackText("Add a brief introduction", 14),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
