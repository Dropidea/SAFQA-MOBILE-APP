import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/invoices/customer_info_page.dart';
import 'package:safqa/pages/invoices/invoice_items_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';
import 'package:textfield_datepicker/textfield_timePicker.dart';

class InvoiceTab extends StatefulWidget {
  const InvoiceTab({super.key});

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> {
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
                onchanged: addInvoiceController.selectCurrencyDrop);
          },
        ),
        const SizedBox(height: 20),
        blackText("Discount Available", 16),
        CustomDropdown(
            items: addInvoiceController.discountDrops,
            selectedItem: addInvoiceController.selectedDiscountDrop,
            width: w,
            onchanged: addInvoiceController.selectDiscountDrop),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("Expiry date", 16),
                Container(
                  width: 0.5 * w,
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextfieldDatePicker(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      textfieldDatePickerController: textEditingController1,
                      materialDatePickerFirstDate: DateTime(2000),
                      materialDatePickerLastDate: DateTime(2050),
                      materialDatePickerInitialDate:
                          DateTime(DateTime.now().year),
                      preferredDateFormat: DateFormat('dd/MM/yyyy'),
                      cupertinoDatePickerMaximumDate: DateTime(2050),
                      cupertinoDatePickerMinimumDate: DateTime(2000),
                      cupertinoDatePickerBackgroundColor:
                          Theme.of(context).primaryColor,
                      cupertinoDatePickerMaximumYear: 2050,
                      cupertinoDateInitialDateTime:
                          DateTime(DateTime.now().year),
                    ),
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("Time", 16),
                Container(
                  width: 0.3 * w,
                  height: 50,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextfieldTimePicker(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      cupertinoDateInitialDateTime: DateTime.now(),
                      cupertinoDatePickerBackgroundColor:
                          Theme.of(context).primaryColor,
                      materialInitialTime: TimeOfDay.now(),
                      textfieldDateAndTimePickerController:
                          textEditingController2,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            blackText("Remind after", 16),
            SizedBox(width: 10),
            greyText("(optional)", 13)
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 0.5 * w,
              child: SignUpTextField(
                padding: EdgeInsets.all(0),
                keyBoardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                hintText: "0",
              ),
            ),
            SizedBox(width: 10),
            greyText("Days", 15)
          ],
        ),
        SizedBox(
          width: w,
          child: Text(
            "You can create the invoice without sending it directly.The system can remind you to send the invoice at anothertime that you have to specify",
            softWrap: true,
            style: TextStyle(color: Color(0xff2F6782), fontSize: 11.0.sp),
          ),
        ),
        const SizedBox(height: 20),
        blackText("Recurring Interval", 16),
        CustomDropdown(
            items: addInvoiceController.recurringInterval,
            selectedItem: addInvoiceController.selectedRecurringInterval,
            width: w,
            onchanged: addInvoiceController.selectRecurringInterval),
        SizedBox(
          width: w,
          child: Text(
            "If you have a fixed invoice, Instead of writing the same invoice again, you can repeat the invoice by activating the \"Recurring Interval\"",
            softWrap: true,
            style: TextStyle(color: Color(0xff2F6782), fontSize: 11.0.sp),
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
        Row(
          children: [
            blackText("Attach File", 16),
            SizedBox(width: 10),
            greyText("(optional)", 13)
          ],
        ),
        GestureDetector(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result != null) {
              File file = File(result.files.single.path);
              filePath = result.files.single.path.split("/").last;
              setState(() {});
            } else {
              // User canceled the picker
            }
          },
          child: DottedBorder(
            customPath: (size) {
              return Path()
                ..moveTo(10, 0)
                ..lineTo(size.width - 10, 0)
                ..arcToPoint(Offset(size.width, 10),
                    radius: Radius.circular(10))
                ..lineTo(size.width, size.height - 10)
                ..arcToPoint(Offset(size.width - 10, size.height),
                    radius: Radius.circular(10))
                ..lineTo(10, size.height)
                ..arcToPoint(Offset(0, size.height - 10),
                    radius: Radius.circular(10))
                ..lineTo(0, 10)
                ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
            },
            color: Color(0xff00A7B3),
            strokeWidth: 1,
            dashPattern: [10, 5],
            child: Container(
              width: w,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: filePath == ""
                      ? Icon(
                          Icons.add_rounded,
                          color: Color(0xff00A7B3),
                          size: 22.0.sp,
                        )
                      : Text(
                          filePath,
                          style: TextStyle(
                            color: Color(0xff00A7B3),
                            fontSize: 15.0.sp,
                          ),
                        )),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            blackText("Comments File", 16),
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
        const SizedBox(height: 10),
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
              blackText("Invoice Items", 16),
              GestureDetector(
                onTap: () => Get.to(() => InvoiceItemsPage(),
                    transition: Transition.rightToLeft),
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(15)),
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText("Total", 14),
                  const SizedBox(height: 5),
                  greyText("\$ 350.00", 12),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText("Tax", 14),
                  const SizedBox(height: 5),
                  greyText("\$ 0", 12),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
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
