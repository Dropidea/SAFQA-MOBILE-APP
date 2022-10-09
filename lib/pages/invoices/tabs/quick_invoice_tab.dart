import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/invoices/create_invoice_page.dart';
import 'package:safqa/pages/invoices/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class QuickInvoiceTab extends StatefulWidget {
  const QuickInvoiceTab({super.key});

  @override
  State<QuickInvoiceTab> createState() => _QuickInvoiceTabState();
}

class _QuickInvoiceTabState extends State<QuickInvoiceTab> {
  int invoicesLangValue = 0;
  int termsAndConditions = 0;
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
            customDropdown(
              addInvoiceController.days,
              addInvoiceController.selectedDay,
              0.25 * w,
              addInvoiceController.setDay,
            ),
            customDropdown(
              addInvoiceController.monthes,
              addInvoiceController.selectedMonth,
              0.25 * w,
              addInvoiceController.setMonth,
            ),
            customDropdown(
              addInvoiceController.years,
              addInvoiceController.selectedYear,
              0.35 * w,
              addInvoiceController.setYear,
            ),
          ],
        ),
        const SizedBox(height: 30),
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

            return customDropdown(
                countriesCurrencies,
                addInvoiceController.selectedCurrencyDrop,
                w,
                addInvoiceController.selectCurrencyDrop);
          },
        ),
        const SizedBox(height: 30),
        blackText("Invoice value", 16),
        SignUpTextField(
          hintText: "0 LE",
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 30),
        blackText("Invoice Local Currency Value", 16),
        SignUpTextField(
          hintText: "0 AED",
          keyBoardType: TextInputType.number,
        ),
        const SizedBox(height: 30),
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
                    size: GFSize.MEDIUM,
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
                    size: GFSize.MEDIUM,
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
        const SizedBox(height: 30),
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
              blackText("Customer Info", 16),
              GestureDetector(
                onTap: () {
                  Get.to(() => CustomerInfoPage(),
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
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              blackText("Create The Invoice", 16),
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
