import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/invoices/customer_info_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class PaymentLinkTab extends StatefulWidget {
  const PaymentLinkTab({super.key});

  @override
  State<PaymentLinkTab> createState() => _PaymentLinkTabState();
}

class _PaymentLinkTabState extends State<PaymentLinkTab> {
  int invoicesLangValue = 0;
  int termsAndConditions = 0;
  int paymentActive = 0;
  String filePath = "";
  @override
  Widget build(BuildContext context) {
    AddInvoiceController addInvoiceController = Get.find();
    SignUpController _signUpController = Get.find();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    TextEditingController textEditingController1 =
        TextEditingController(text: 'dd/MM/yyyy');
    TextEditingController textEditingController2 =
        TextEditingController(text: '00:00');
    return ListView(
      children: [
        blackText("Invoice Date", 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomDropdown(
              items: addInvoiceController.days,
              selectedItem: addInvoiceController.selectedDay,
              width: 0.25 * w,
              onchanged: addInvoiceController.setDay,
            ),
            CustomDropdown(
              items: addInvoiceController.monthes,
              selectedItem: addInvoiceController.selectedMonth,
              width: 0.25 * w,
              onchanged: addInvoiceController.setMonth,
            ),
            CustomDropdown(
              items: addInvoiceController.years,
              selectedItem: addInvoiceController.selectedYear,
              width: 0.35 * w,
              onchanged: addInvoiceController.setYear,
            ),
          ],
        ),
        const SizedBox(height: 20),
        blackText("Payment Url Title", 16),
        SignUpTextField(
          padding: EdgeInsets.all(0),
        ),
        const SizedBox(height: 20),
        blackText("Is the payment link active?", 16),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    inactiveBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    value: 0,
                    groupValue: paymentActive,
                    onChanged: (value) => setState(() {
                          paymentActive = value;
                        })),
                greyText("Yes", 16),
              ],
            ),
            SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    inactiveBorderColor: Colors.transparent,
                    value: 1,
                    groupValue: paymentActive,
                    onChanged: (value) => setState(() {
                          paymentActive = value;
                        })),
                greyText("No", 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        blackText("Fixed Price", 16),
        CustomDropdown(
          width: w,
          items: ["yes", "No"],
          onchanged: (String? v) {
            //TODO:fixed Price Function
          },
          hint: "Fixed Price",
        ),
        const SizedBox(height: 20),
        blackText("Currency", 16),
        Obx(
          () {
            List countries = _signUpController.globalData['country'];
            List<String> ids = countries
                .map<String>(
                  (e) => e['id'].toString(),
                )
                .toList();
            List<String> countriesCurrencies = countries
                .map<String>(
                  (e) => e['currency'].toString(),
                )
                .toList();
            addInvoiceController.selectCurrencyDrop(countriesCurrencies[0]);

            return CustomDropdown(
              items: countriesCurrencies,
              selectedItem: addInvoiceController.selectedCurrencyDrop,
              width: w,
              onchanged: addInvoiceController.selectCurrencyDrop,
            );
          },
        ),
        const SizedBox(height: 20),
        blackText("Payment Value", 16),
        SignUpTextField(
          padding: EdgeInsets.all(0),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            blackText("Comments", 16),
            SizedBox(width: 10),
            greyText("(optional)", 13)
          ],
        ),
        Container(
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            maxLines: 3,
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ),
        const SizedBox(height: 20),
        blackText("Language of the invoice", 16),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    inactiveBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    value: 0,
                    groupValue: invoicesLangValue,
                    onChanged: (value) => setState(() {
                          invoicesLangValue = value;
                        })),
                greyText("English", 16),
              ],
            ),
            SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    inactiveBorderColor: Colors.transparent,
                    value: 1,
                    groupValue: invoicesLangValue,
                    onChanged: (value) => setState(() {
                          invoicesLangValue = value;
                        })),
                greyText("Arabic", 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        blackText("Terms & Conditions", 16),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    inactiveBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    value: 0,
                    groupValue: termsAndConditions,
                    onChanged: (value) => setState(() {
                          termsAndConditions = value;
                        })),
                greyText("Disable", 16),
              ],
            ),
            SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GFRadio(
                    activeBorderColor: Colors.transparent,
                    radioColor: Color(0xff66B4D2),
                    inactiveIcon: Icon(
                      Icons.circle,
                      color: Colors.grey.shade200,
                    ),
                    size: GFSize.SMALL,
                    inactiveBorderColor: Colors.transparent,
                    value: 1,
                    groupValue: termsAndConditions,
                    onChanged: (value) => setState(() {
                          termsAndConditions = value;
                        })),
                greyText("Enable", 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              blackText("Create The Link", 16),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: EdgeInsets.all(20),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 22.0.sp,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
