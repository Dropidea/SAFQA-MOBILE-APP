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
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/create_invoice/invoice_items_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/dialoges.dart';
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
  bool recurringIntervalFlag = true;
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
      TextEditingController(text: 'dd-MM-yyyy');
  TextEditingController endDateController =
      TextEditingController(text: 'dd-MM-yyyy');
  TextEditingController expiryTimeController =
      TextEditingController(text: '00:00');
  AddInvoiceController addInvoiceController = Get.find();
  SignUpController _signUpController = Get.find();
  LoginController _loginController = Get.put(LoginController());
  InvoicesController _invoicesController = Get.find();
  LocalsController _localsController = Get.find();
  GlobalDataController globalDataController = Get.find();
  bool engFlag = false;
  @override
  void initState() {
    addInvoiceController.total = 0;
    engFlag = _localsController.currenetLocale == 0;
    addInvoiceController.dataToCreateInvoice.recurringIntervalId =
        globalDataController.recurringIntervals[0].id;
    if (addInvoiceController.dataToEditInvoice != null) {
      fileName = addInvoiceController.dataToEditInvoice!.attachFile ?? "";
      for (var i in addInvoiceController.dataToEditInvoice!.invoiceItems) {
        addInvoiceController.total += i.productQuantity! * i.productPrice!;
      }
      logSuccess(addInvoiceController.dataToEditInvoice!.attachFile);
      if (addInvoiceController.dataToEditInvoice!.discountValue != 0) {
        discountAvailableFlag = true;
        startDateController.text =
            addInvoiceController.dataToEditInvoice!.recurringStartDate ??
                "start_date".tr;
        endDateController.text =
            addInvoiceController.dataToEditInvoice!.recurringEndDate ??
                "end_date".tr;
      }

      invoicesLangValue = addInvoiceController.dataToEditInvoice!.languageId!;
      if (addInvoiceController.dataToEditInvoice!.recurringIntervalId != 4) {
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
      addInvoiceController.dataToEditInvoice!.expiryDate =
          addInvoiceController.dataToEditInvoice!.expiryDate!.substring(
              0,
              addInvoiceController.dataToEditInvoice!.expiryDate!
                  .lastIndexOf(":"));
      expiryDateController.text =
          addInvoiceController.dataToEditInvoice!.expiryDate!.split(" ")[0];
      expiryTimeController.text =
          addInvoiceController.dataToEditInvoice!.expiryDate!.split(" ")[1];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText("invoice_id".tr, 14),
                  const SizedBox(height: 5),
                  greyText(
                      addInvoiceController.dataToEditInvoice != null
                          ? addInvoiceController.dataToEditInvoice!.id!
                              .toString()
                          : "${_invoicesController.invoices.length + 1}",
                      12),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText("invoice_date".tr, 14),
                  const SizedBox(height: 5),
                  greyText(DateFormat('dd-MMM-y').format(DateTime.now()), 13),
                ],
              )
            ],
          ),
          const SizedBox(height: 30),
          blackText("currency".tr, 16),
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
                        addInvoiceController.dataToEditInvoice!.currencyId)]);
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
          blackText("is_open_invoice".tr, 16),
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
                      value == "fixed".tr ? 1 : 0;
                } else {
                  addInvoiceController.dataToCreateInvoice.isOpenInvoice =
                      value == "fixed".tr ? 1 : 0;
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          blackText("discount_available".tr, 16),
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
                      ? "yes".tr
                      : "no".tr
                  : addInvoiceController.selectedDiscountDrop,
              onChanged: (value) {
                addInvoiceController.selectDiscountDrop(value!);
                if (value == "no".tr) {
                  discountAvailableFlag = false;
                  discountValueController.text = "0";
                  if (addInvoiceController.dataToEditInvoice != null) {
                    addInvoiceController.dataToEditInvoice!.discountValue = 0;
                  } else {
                    addInvoiceController.dataToCreateInvoice.discountValue = 0;
                  }
                } else {
                  discountAvailableFlag = true;
                }
                setState(() {});
              },
            ),
          ),
          const SizedBox(height: 20),
          discountAvailableFlag
              ? blackText("discount_type".tr, 16)
              : Container(),
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
                        ? addInvoiceController
                                    .dataToEditInvoice!.discountType ==
                                1
                            ? "fixed".tr
                            : "rate".tr
                        : addInvoiceController.selectedDiscountTypesDrop,
                    onChanged: (value) {
                      addInvoiceController.selectDiscountTypesDrop(value!);
                      if (value == "fixed".tr) {
                        discountTypeFlag = true;
                        if (addInvoiceController.dataToEditInvoice != null) {
                          addInvoiceController.dataToEditInvoice!.discountType =
                              0;
                        } else {
                          addInvoiceController
                              .dataToCreateInvoice.discountType = 0;
                        }
                      } else {
                        discountTypeFlag = false;
                        if (addInvoiceController.dataToEditInvoice != null) {
                          addInvoiceController.dataToEditInvoice!.discountType =
                              1;
                        } else {
                          addInvoiceController
                              .dataToCreateInvoice.discountType = 1;
                        }
                      }
                      setState(() {});
                    },
                  ),
                )
              : Container(),
          discountAvailableFlag ? const SizedBox(height: 20) : Container(),
          discountAvailableFlag
              ? blackText("discount_value".tr, 16)
              : Container(),
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
                  blackText("expiry_date".tr, 16),
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
                        preferredDateFormat: DateFormat('y-MM-dd'),
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
                  blackText("time".tr, 16),
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
              blackText("remind_after".tr, 16),
              SizedBox(width: 10),
              greyText("(${"optional".tr})", 13)
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
              greyText("days".tr, 15)
            ],
          ),
          SizedBox(
            width: w,
            child: Text(
              engFlag
                  ? "You can create the invoice without sending it directly.The system can remind you to send the invoice at anothertime that you have to specify"
                  : "يمكنك إنشاء الفاتورة دون إرسالها مباشرة ، ويمكن للنظام أن يذكرك بإرسال الفاتورة في وقت آخر عليك تحديده",
              softWrap: true,
              style: TextStyle(color: Color(0xff2F6782), fontSize: 11.0.sp),
            ),
          ),
          const SizedBox(height: 20),
          blackText("recurring_interval".tr, 16),
          Container(
              width: w,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: CustomDropdown(
                width: w,
                items: globalDataController.recurringIntervals
                    .map((e) => engFlag ? e.nameEn! : e.nameAr!)
                    .toList(),
                onchanged: (value) {
                  {
                    startDateController.text = "start_date".tr;
                    endDateController.text = "end_date".tr;
                    if (addInvoiceController.dataToEditInvoice != null) {
                      addInvoiceController
                          .dataToEditInvoice!.recurringStartDate = null;
                      addInvoiceController.dataToEditInvoice!.recurringEndDate =
                          null;
                    }
                    if (value != "No Recurring") {
                      setState(() {
                        recurringIntervalFlag = true;
                      });
                    } else {
                      setState(() {
                        recurringIntervalFlag = false;
                      });
                    }
                    if (addInvoiceController.dataToEditInvoice != null) {
                      addInvoiceController
                              .dataToEditInvoice!.recurringIntervalId =
                          globalDataController.recurringIntervals
                              .firstWhere((element) =>
                                  element.nameEn == value ||
                                  element.nameAr == value)
                              .id;
                    } else {
                      addInvoiceController
                              .dataToCreateInvoice.recurringIntervalId =
                          globalDataController.recurringIntervals
                              .firstWhere((element) =>
                                  element.nameEn == value ||
                                  element.nameAr == value)
                              .id;
                    }
                  }
                },
                selectedItem: addInvoiceController.dataToEditInvoice != null
                    ? engFlag
                        ? globalDataController.recurringIntervals
                            .firstWhere((element) =>
                                element.id ==
                                addInvoiceController
                                    .dataToEditInvoice!.recurringIntervalId)
                            .nameEn
                        : globalDataController.recurringIntervals
                            .firstWhere((element) =>
                                element.id ==
                                addInvoiceController
                                    .dataToEditInvoice!.recurringIntervalId)
                            .nameAr
                    : engFlag
                        ? globalDataController.recurringIntervals[0].nameEn!
                        : globalDataController.recurringIntervals[0].nameAr!,
              )

              //  DropdownButtonFormField(
              //   decoration: const InputDecoration(border: InputBorder.none),
              //   items: addInvoiceController.recurringInterval
              //       .map(
              //         (e) => DropdownMenuItem(
              //           value: e,
              //           child: Text(
              //             e,
              //           ),
              //         ),
              //       )
              //       .toList(),
              //   value:
              //   onChanged: (value)    ),
              ),
          SizedBox(
            width: w,
            child: Text(
              engFlag
                  ? "If you have a fixed invoice, Instead of writing the same invoice again, you can repeat the invoice by activating the \"Recurring Interval\""
                  : "إذا كانت لديك فاتورة ثابتة ، فبدلاً من كتابة نفس الفاتورة مرة أخرى ، يمكنك تكرار الفاتورة عن طريق تنشيط \" Recurring Interval \"",
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
                        blackText("start_date".tr, 15),
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
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              textfieldDatePickerController:
                                  startDateController,
                              materialDatePickerFirstDate: DateTime(2000),
                              materialDatePickerLastDate: DateTime(2050),
                              materialDatePickerInitialDate: DateTime.now(),
                              preferredDateFormat: DateFormat('y-MM-dd'),
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
                        blackText("end_date".tr, 15),
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
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              textfieldDatePickerController: endDateController,
                              materialDatePickerFirstDate: DateTime(2000),
                              materialDatePickerLastDate: DateTime(2050),
                              materialDatePickerInitialDate: DateTime.now(),
                              preferredDateFormat: DateFormat('y-MM-dd'),
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
          blackText("language_of_invoice".tr, 16),
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
                          if (addInvoiceController.dataToEditInvoice != null) {
                            addInvoiceController.dataToEditInvoice!.languageId =
                                1;
                          } else {
                            addInvoiceController
                                .dataToCreateInvoice.languageId = 1;
                          }
                        }),
                  ),
                  greyText("english".tr, 16),
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
                          if (addInvoiceController.dataToEditInvoice != null) {
                            addInvoiceController.dataToEditInvoice!.languageId =
                                2;
                          } else {
                            addInvoiceController
                                .dataToCreateInvoice.languageId = 2;
                          }
                        }),
                  ),
                  greyText("arabic".tr, 16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              blackText("attach_file".tr, 16),
              SizedBox(width: 10),
              greyText("(${"optional".tr})", 13)
            ],
          ),
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.custom,
                allowedExtensions: ['pdf', 'xlsx'],
              );
              if (result != null) {
                File file = File(result.files.single.path!);
                fileName = result.files.single.path!.split("/").last;
                if (addInvoiceController.dataToEditInvoice != null) {
                  addInvoiceController.dataToEditInvoice!.attachFile = file;
                } else {
                  addInvoiceController.dataToCreateInvoice.attachFile = file;
                }

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
              blackText("comments".tr, 16),
              SizedBox(width: 10),
              greyText("(${"optional".tr})", 13)
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
          blackText("terms_conditions".tr, 16),
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
                  greyText("disable".tr, 16),
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
                  greyText("enable".tr, 16),
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
                blackText("customer_info".tr, 16),
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
                blackText("invoice_items".tr, 16),
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
                    blackText("total".tr, 14),
                    const SizedBox(height: 5),
                    GetBuilder<AddInvoiceController>(builder: (c) {
                      return greyText("\$ ${c.total}", 12);
                    }),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText("tax".tr, 14),
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
                blackText(
                    addInvoiceController.dataToEditInvoice != null
                        ? "edit_invoice".tr
                        : "create_invoice".tr,
                    16),
                SizedBox(width: 10),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  onTap: () async {
                    if (addInvoiceController.dataToEditInvoice != null) {
                      var expiryTime = expiryTimeController.text.split(" ")[0];
                      if (expiryTime.length == 4) {
                        expiryTime =
                            "0" + expiryTimeController.text.split(" ")[0];
                      }
                      String expiryDate =
                          "${expiryDateController.text} $expiryTime";
                      addInvoiceController.dataToEditInvoice!.expiryDate =
                          expiryDate;

                      if (startDateController.text != "start_date".tr &&
                          startDateController.text != 'dd-MM-yyyy') {
                        addInvoiceController.dataToEditInvoice!
                            .recurringStartDate = startDateController.text;
                      }
                      if (endDateController.text != "end_date".tr &&
                          endDateController.text != 'dd-MM-yyyy') {
                        addInvoiceController.dataToEditInvoice!
                            .recurringEndDate = endDateController.text;
                      }

                      // logSuccess(
                      //     addInvoiceController.dataToEditInvoice!.toJson());
                      // addInvoiceController.dataToEditInvoice = null;
                      // Get.back();
                      bool b = await addInvoiceController.editInvoice();
                      if (b) {
                        await _invoicesController.getInvoices();
                        MyDialogs.showSavedSuccessfullyDialoge(
                          title: "edited_successfully".tr,
                          btnTXT: "close".tr,
                          onTap: () async {
                            Get.back();
                            Get.back();
                            Get.back();
                          },
                        );
                      }
                    } else {
                      var expiryTime = expiryTimeController.text.split(" ")[0];
                      if (expiryTime.length == 4) {
                        expiryTime =
                            "0" + expiryTimeController.text.split(" ")[0];
                      }
                      String expiryDate =
                          "${expiryDateController.text} $expiryTime";
                      if (addInvoiceController.customerInfo != null) {
                        addInvoiceController.dataToCreateInvoice.customerName =
                            addInvoiceController.customerInfo!.customerName;
                        addInvoiceController.dataToCreateInvoice.customerEmail =
                            addInvoiceController.customerInfo!.customerEmail;
                        addInvoiceController
                                .dataToCreateInvoice.customerMobileNumbr =
                            addInvoiceController
                                .customerInfo!.customerMobileNumbr;
                        addInvoiceController
                                .dataToCreateInvoice.customerMobileNumbrCode =
                            addInvoiceController
                                .customerInfo!.customerMobileNumbrCode;
                        addInvoiceController
                                .dataToCreateInvoice.customerMobileNumbrCodeid =
                            addInvoiceController
                                .customerInfo!.customerMobileNumbrCodeID;
                        addInvoiceController
                                .dataToCreateInvoice.customerRefrence =
                            addInvoiceController.customerInfo!.customerRefrence;
                        addInvoiceController
                                .dataToCreateInvoice.customerSendBy =
                            addInvoiceController.customerInfo!.customerSendBy;
                      }
                      addInvoiceController.dataToCreateInvoice.expiryDate =
                          expiryDate;

                      if (startDateController.text != "start_date".tr &&
                          startDateController.text != 'dd-MM-yyyy') {
                        addInvoiceController.dataToCreateInvoice
                            .recurringStartDate = startDateController.text;
                      }
                      if (endDateController.text != "end_date".tr &&
                          endDateController.text != 'dd-MM-yyyy') {
                        addInvoiceController.dataToCreateInvoice
                            .recurringEndDate = endDateController.text;
                      }
                      logSuccess(
                          addInvoiceController.dataToCreateInvoice.toJson());
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
      ),
    );
  }
}
