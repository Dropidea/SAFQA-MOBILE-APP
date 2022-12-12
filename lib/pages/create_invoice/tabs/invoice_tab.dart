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
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/create_invoice/invoice_items_page.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';
import 'package:textfield_datepicker/textfield_timePicker.dart';

class CreateInvoiceTab extends StatefulWidget {
  const CreateInvoiceTab({super.key});

  @override
  State<CreateInvoiceTab> createState() => _CreateInvoiceTabState();
}

class _CreateInvoiceTabState extends State<CreateInvoiceTab> {
  int invoicesLangValue = 1;
  int termsAndConditions = 1;
  String fileName = "";
  bool recurringIntervalFlag = false;
  bool discountAvailableFlag = false;
  bool discountTypeFlag = true;
  bool termsConditionsFlag = false;
  TextEditingController expiryDateController =
      TextEditingController(text: 'yyyy-MM-dd');
  TextEditingController remindAfterController = TextEditingController();
  TextEditingController discountValueController = TextEditingController();
  TextEditingController commentsController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  TextEditingController startDateController =
      TextEditingController(text: 'dd/MM/yyyy');
  TextEditingController endDateController =
      TextEditingController(text: 'dd/MM/yyyy');
  TextEditingController expiryTimeController =
      TextEditingController(text: '00:00');
  AddInvoiceController addInvoiceController = Get.find();
  SignUpController _signUpController = Get.find();
  LoginController _loginController = Get.put(LoginController());
  GlobalDataController globalDataController = Get.find();

  @override
  void initState() {
    if (addInvoiceController.dataToEditInvoice != null) {
      if (addInvoiceController.dataToEditInvoice!.discountValue != 0) {
        discountAvailableFlag = true;
        startDateController.text =
            addInvoiceController.dataToEditInvoice!.recurringStartDate ??
                "Start Date";
        endDateController.text =
            addInvoiceController.dataToEditInvoice!.recurringEndDate ??
                "End Date";
      }

      invoicesLangValue = addInvoiceController.dataToEditInvoice!.languageId!;
      if (addInvoiceController.dataToEditInvoice!.recurringIntervalId != 0) {
        recurringIntervalFlag = true;
      }
      if (addInvoiceController.dataToEditInvoice!.attachFile != null) {
        fileName = addInvoiceController.dataToEditInvoice!.attachFile.substring(
            addInvoiceController.dataToEditInvoice!.attachFile
                    .lastIndexOf("/") +
                1);
      }

      if (addInvoiceController.dataToEditInvoice!.comments != null) {
        commentsController.text =
            addInvoiceController.dataToEditInvoice!.comments!;
      }
      if (addInvoiceController.dataToEditInvoice!.termsAndConditions != null) {
        termsController.text =
            addInvoiceController.dataToEditInvoice!.termsAndConditions!;
        termsConditionsFlag = true;
        termsAndConditions = 2;
      }
      expiryDateController.text =
          addInvoiceController.dataToEditInvoice!.expiryDate!.split(" ")[0];
      expiryTimeController.text = addInvoiceController
          .dataToEditInvoice!.expiryDate!
          .split(" ")[1]
          .substring(
              0,
              addInvoiceController.dataToEditInvoice!.expiryDate!
                  .split(" ")[1]
                  .lastIndexOf(":"));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return ListView(
      children: [
        //    blackText("Invoice Date", 16),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     CustomDropdown(
        //       items: addInvoiceController.days,
        //       selectedItem: addInvoiceController.selectedDay,
        //       width: 0.25 * w,
        //       onchanged: addInvoiceController.setDay,
        //     ),
        //     CustomDropdown(
        //       items: addInvoiceController.monthes,
        //       selectedItem: addInvoiceController.selectedMonth,
        //       width: 0.25 * w,
        //       onchanged: addInvoiceController.setMonth,
        //     ),
        //     CustomDropdown(
        //       items: addInvoiceController.years,
        //       selectedItem: addInvoiceController.selectedYear,
        //       width: 0.35 * w,
        //       onchanged: addInvoiceController.setYear,
        //     ),
        //   ],
        // ),
        // const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("Invoice ID", 14),
                const SizedBox(height: 5),
                greyText(
                    addInvoiceController.dataToEditInvoice != null
                        ? addInvoiceController.dataToEditInvoice!.id!.toString()
                        : "2659986 / 2022000048",
                    12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("Invoice Date", 14),
                const SizedBox(height: 5),
                greyText(DateFormat('dd-MMM-y').format(DateTime.now()), 12),
              ],
            )
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
                .toSet()
                .toList();
            // logSuccess(addInvoiceController.dataToEditInvoice!.currencyId!);
            if (addInvoiceController.dataToEditInvoice != null) {
              addInvoiceController.selectCurrencyDrop(countriesCurrencies[
                  ids.indexOf(
                      addInvoiceController.dataToEditInvoice!.currencyId!)]);
            } else {
              addInvoiceController.selectCurrencyDrop(countriesCurrencies[0]);
            }

            return CustomDropdown(
              items: countriesCurrencies,
              selectedItem: addInvoiceController.selectedCurrencyDrop,
              width: w,
              onchanged: (s) {
                addInvoiceController.selectCurrencyDrop(s);
                if (addInvoiceController.dataToEditInvoice != null) {
                  addInvoiceController.dataToEditInvoice!.currencyId =
                      ids[countriesCurrencies.indexOf(s!)];
                } else {
                  addInvoiceController.dataToCreateInvoice.currencyId =
                      ids[countriesCurrencies.indexOf(s!)];
                }
              },
            );
          },
        ),
        const SizedBox(height: 20),
        blackText("Is Open Invoice", 16),
        Container(
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(border: InputBorder.none),
            items: addInvoiceController.isOpenInvoiceDrops
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            value: addInvoiceController.dataToEditInvoice != null
                ? addInvoiceController.isOpenInvoiceDrops[
                    addInvoiceController.dataToEditInvoice!.isOpenInvoice!]
                : addInvoiceController.selectedIsOpenInvoiceDrop,
            onChanged: (value) {
              addInvoiceController.selectIsOpenInvoiceDrop(value!);
              if (addInvoiceController.dataToEditInvoice != null) {
                addInvoiceController.dataToEditInvoice!.isOpenInvoice =
                    value == "Fixed" ? 1 : 0;
              } else {
                addInvoiceController.dataToCreateInvoice.isOpenInvoice =
                    value == "Fixed" ? 1 : 0;
              }
            },
          ),
        ),
        const SizedBox(height: 20),
        blackText("Discount Available", 16),
        Container(
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(border: InputBorder.none),
            items: addInvoiceController.discountDrops
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            value: addInvoiceController.dataToEditInvoice != null
                ? addInvoiceController.dataToEditInvoice!.discountValue != 0
                    ? "Yes"
                    : "No"
                : addInvoiceController.selectedDiscountDrop,
            onChanged: (value) {
              addInvoiceController.selectDiscountDrop(value!);
              if (value == "No") {
                discountAvailableFlag = false;
              } else {
                discountAvailableFlag = true;
              }
              setState(() {});
            },
          ),
        ),
        const SizedBox(height: 20),

        discountAvailableFlag ? blackText("Discount Type", 16) : Container(),
        discountAvailableFlag
            ? Container(
                width: w,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButtonFormField(
                  decoration: const InputDecoration(border: InputBorder.none),
                  items: addInvoiceController.discountTypesDrops
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(
                            e,
                          ),
                        ),
                      )
                      .toList(),
                  value: addInvoiceController.dataToEditInvoice != null
                      ? addInvoiceController.dataToEditInvoice!.discountType ==
                              0
                          ? "Fixed"
                          : "Rate"
                      : addInvoiceController.selectedDiscountTypesDrop,
                  onChanged: (value) {
                    addInvoiceController.selectDiscountTypesDrop(value!);
                    if (value == "Fixed") {
                      discountTypeFlag = true;
                      if (addInvoiceController.dataToEditInvoice != null) {
                        addInvoiceController.dataToEditInvoice!.discountType =
                            1;
                      } else {
                        addInvoiceController.dataToCreateInvoice.discountType =
                            1;
                      }
                    } else {
                      discountTypeFlag = false;
                      if (addInvoiceController.dataToEditInvoice != null) {
                        addInvoiceController.dataToEditInvoice!.discountType =
                            0;
                      } else {
                        addInvoiceController.dataToCreateInvoice.discountType =
                            0;
                      }
                    }
                    setState(() {});
                  },
                ),
              )
            : Container(),
        discountAvailableFlag ? const SizedBox(height: 20) : Container(),
        discountAvailableFlag ? blackText("Discount Value", 16) : Container(),
        discountAvailableFlag
            ? SignUpTextField(
                initialValue: addInvoiceController.dataToEditInvoice != null
                    ? addInvoiceController.dataToEditInvoice!.discountValue
                        .toString()
                    : null,
                padding: EdgeInsets.all(0),
                hintText: discountTypeFlag ? "0 AED" : "0 %",
                keyBoardType: TextInputType.number,
                onchanged: (s) {
                  if (addInvoiceController.dataToEditInvoice != null) {
                    addInvoiceController.dataToEditInvoice!.discountValue =
                        int.parse(s!);
                  } else {
                    addInvoiceController.dataToCreateInvoice.discountValue =
                        int.parse(s!);
                  }
                },
              )
            : Container(),
        discountAvailableFlag ? const SizedBox(height: 20) : Container(),
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
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: TextfieldDatePicker(
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      textfieldDatePickerController: expiryDateController,
                      materialDatePickerFirstDate: DateTime(2000),
                      materialDatePickerLastDate: DateTime(2050),
                      materialDatePickerInitialDate: DateTime.now(),
                      preferredDateFormat: DateFormat('y-M-d'),
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
                    color: Color(0xffF8F8F8),
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
                          expiryTimeController,
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
                initialValue: addInvoiceController.dataToEditInvoice != null
                    ? addInvoiceController.dataToEditInvoice!.remindAfter!
                        .toString()
                    : null,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                ],
                hintText: "0",
                onchanged: (s) {
                  if (addInvoiceController.dataToEditInvoice != null) {
                    addInvoiceController.dataToEditInvoice!.remindAfter =
                        int.parse(s!);
                  } else {
                    addInvoiceController.dataToCreateInvoice.remindAfter =
                        int.parse(s!);
                  }
                },
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
        Container(
          width: w,
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButtonFormField(
            decoration: const InputDecoration(border: InputBorder.none),
            items: addInvoiceController.recurringInterval
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
            value: addInvoiceController.dataToEditInvoice != null
                ? addInvoiceController.dataToEditInvoice!.recurringIntervalId ==
                        0
                    ? "No Recurring"
                    : "Monthly"
                : addInvoiceController.selectedRecurringInterval,
            onChanged: (value) {
              addInvoiceController.selectRecurringInterval(value!);
              if (value != "No Recurring") {
                setState(() {
                  recurringIntervalFlag = true;
                });
              } else {
                setState(() {
                  recurringIntervalFlag = false;
                });
              }
              addInvoiceController.dataToCreateInvoice.recurringIntervalId =
                  (addInvoiceController.recurringInterval.indexOf(value) + 1);
              logSuccess(addInvoiceController
                  .dataToCreateInvoice.recurringIntervalId!);
            },
          ),
        ),
        SizedBox(
          width: w,
          child: Text(
            "If you have a fixed invoice, Instead of writing the same invoice again, you can repeat the invoice by activating the \"Recurring Interval\"",
            softWrap: true,
            style: TextStyle(color: Color(0xff2F6782), fontSize: 11.0.sp),
          ),
        ),
        const SizedBox(height: 20),
        recurringIntervalFlag
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackText("Start Date", 15),
                      Container(
                        width: 0.4 * w,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: TextfieldDatePicker(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            textfieldDatePickerController: startDateController,
                            materialDatePickerFirstDate: DateTime(2000),
                            materialDatePickerLastDate: DateTime(2050),
                            materialDatePickerInitialDate: DateTime.now(),
                            preferredDateFormat: DateFormat('y-M-d'),
                            cupertinoDatePickerMaximumDate: DateTime(2050),
                            cupertinoDatePickerMinimumDate: DateTime(2000),
                            cupertinoDatePickerBackgroundColor:
                                Theme.of(context).primaryColor,
                            cupertinoDatePickerMaximumYear: 2050,
                            cupertinoDateInitialDateTime:
                                DateTime(DateTime.now().year),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      blackText("End Date", 15),
                      Container(
                        width: 0.4 * w,
                        height: 50,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Center(
                          child: TextfieldDatePicker(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            textfieldDatePickerController: endDateController,
                            materialDatePickerFirstDate: DateTime(2000),
                            materialDatePickerLastDate: DateTime(2050),
                            materialDatePickerInitialDate: DateTime.now(),
                            preferredDateFormat: DateFormat('y-M-d'),
                            cupertinoDatePickerMaximumDate: DateTime(2050),
                            cupertinoDatePickerMinimumDate: DateTime(2000),
                            cupertinoDatePickerBackgroundColor:
                                Theme.of(context).primaryColor,
                            cupertinoDatePickerMaximumYear: 2050,
                            cupertinoDateInitialDateTime:
                                DateTime(DateTime.now().year),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : Container(),
        const SizedBox(height: 20),
        blackText("Language of the invoice", 16),
        const SizedBox(height: 10),
        Row(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      inactiveBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      value: 1,
                      groupValue: invoicesLangValue,
                      onChanged: (value) {
                        setState(
                          () {
                            invoicesLangValue = value;
                          },
                        );
                        addInvoiceController.dataToCreateInvoice.languageId = 1;
                      }),
                ),
                greyText("English", 16),
              ],
            ),
            SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      inactiveBorderColor: Colors.transparent,
                      value: 2,
                      groupValue: invoicesLangValue,
                      onChanged: (value) {
                        setState(
                          () {
                            invoicesLangValue = value;
                          },
                        );
                        addInvoiceController.dataToCreateInvoice.languageId = 2;
                      }),
                ),
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
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf', 'xlsx'],
            );
            if (result != null) {
              File file = File(result.files.single.path);
              fileName = result.files.single.path.split("/").last;

              addInvoiceController.dataToCreateInvoice.attachFile = file;

              setState(() {});
            } else {
              // User canceled the picker
            }
          },
          child: DottedBorder(
            padding: EdgeInsets.all(0),
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
            color: Color(0xff2F6782).withOpacity(0.4),
            strokeWidth: 1,
            dashPattern: [10, 5],
            child: Container(
              width: w,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2F6782).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: fileName == ""
                      ? Icon(
                          Icons.add_rounded,
                          color: Color(0xff00A7B3),
                          size: 22.0.sp,
                        )
                      : Text(
                          fileName,
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
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: TextField(
            controller: commentsController,
            onChanged: (value) {
              if (addInvoiceController.dataToEditInvoice != null) {
                addInvoiceController.dataToEditInvoice!.comments = value;
              } else {
                addInvoiceController.dataToCreateInvoice.comments = value;
              }
            },
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
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      inactiveBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      value: 1,
                      groupValue: termsAndConditions,
                      onChanged: (value) => setState(() {
                            termsAndConditions = value;
                            termsConditionsFlag = false;
                          })),
                ),
                greyText("Disable", 16),
              ],
            ),
            SizedBox(width: 20),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 7),
                  child: GFRadio(
                      activeBorderColor: Colors.transparent,
                      radioColor: Color(0xff66B4D2),
                      inactiveIcon: Icon(
                        Icons.circle_outlined,
                        color: Colors.grey.shade300,
                      ),
                      size: GFSize.SMALL,
                      inactiveBorderColor: Colors.transparent,
                      value: 2,
                      groupValue: termsAndConditions,
                      onChanged: (value) => setState(() {
                            termsAndConditions = value;
                            termsConditionsFlag = true;
                          })),
                ),
                greyText("Enable", 16),
              ],
            ),
          ],
        ),
        termsConditionsFlag
            ? Container(
                width: w,
                margin: const EdgeInsets.symmetric(vertical: 5),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  maxLines: 3,
                  decoration: const InputDecoration(border: InputBorder.none),
                  controller: termsController,
                  onChanged: (value) {
                    if (addInvoiceController.dataToEditInvoice != null) {
                      addInvoiceController
                          .dataToEditInvoice!.termsAndConditions = value;
                    } else {
                      addInvoiceController
                          .dataToCreateInvoice.termsAndConditions = value;
                    }
                  },
                ),
              )
            : Container(),
        termsConditionsFlag ? const SizedBox(height: 20) : Container(),
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
                  FocusScope.of(context).unfocus();
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
              blackText("Create Invoice", 16),
              SizedBox(width: 10),
              InkWell(
                customBorder: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40),
                ),
                onTap: () async {
                  if (addInvoiceController.dataToEditInvoice != null) {
                    logSuccess(
                        addInvoiceController.dataToEditInvoice!.toJson());
                    addInvoiceController.dataToEditInvoice = null;
                    Get.back();
//TODO:Stopped Here

                  } else {
                    var expiryTime = expiryTimeController.text.split(" ")[0];
                    if (expiryTime.length == 4) {
                      expiryTime =
                          "0" + expiryTimeController.text.split(" ")[0];
                    }
                    String expiryDate =
                        "${expiryDateController.text} $expiryTime";
                    addInvoiceController.dataToCreateInvoice.customerName =
                        addInvoiceController.customerInfo.customerName;
                    addInvoiceController
                            .dataToCreateInvoice.customerMobileNumbr =
                        addInvoiceController.customerInfo.customerMobileNumbr;
                    addInvoiceController
                            .dataToCreateInvoice.customerMobileNumbrCode =
                        addInvoiceController
                            .customerInfo.customerMobileNumbrCodeID;
                    addInvoiceController.dataToCreateInvoice.customerRefrence =
                        addInvoiceController.customerInfo.customerRefrence;
                    addInvoiceController.dataToCreateInvoice.customerSendBy =
                        addInvoiceController.customerInfo.customerSendBy;
                    addInvoiceController.dataToCreateInvoice.expiryDate =
                        expiryDate;
                    addInvoiceController.dataToCreateInvoice
                        .recurringStartDate = startDateController.text;
                    addInvoiceController.dataToCreateInvoice.recurringEndDate =
                        endDateController.text;

                    await addInvoiceController.createInvoice();
                  }
                },
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
    );
  }
}
