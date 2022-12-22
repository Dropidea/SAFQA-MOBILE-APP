import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class RefundsSearchFilter extends StatefulWidget {
  const RefundsSearchFilter({super.key});

  @override
  State<RefundsSearchFilter> createState() => RefundsSearchFilterState();
}

class RefundsSearchFilterState extends State<RefundsSearchFilter> {
  int refundStatus = 0;
  int price = 0;
  int dateCreated = 0;

  TextEditingController fixedDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xffFBFBFB),
        elevation: 0,
      ),
      backgroundColor: Color(0xffFBFBFB),
      body: ExpandableNotifier(
        child: ListView(
          primary: false,
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 25.0.sp,
                  ),
                ),
                ClearFilterBTN(),
                // Text(
                //   "Clear",
                //   style: TextStyle(
                //     fontSize: 16.0.sp,
                //     color: Color(0xff00A7B3),
                //     decoration: TextDecoration.underline,
                //   ),
                // )
              ],
            ),

            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildRadioButton(
                        0,
                        "All",
                        refundStatus,
                        (p0) => setState(
                              () {
                                refundStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "debit".tr,
                        refundStatus,
                        (p0) => setState(
                              () {
                                refundStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "credit".tr,
                        refundStatus,
                        (p0) => setState(
                              () {
                                refundStatus = p0;
                              },
                            )),
                  ],
                ),
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("refund_status".tr, 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child:
                    blackText("refund_ref".tr, 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child:
                    blackText("invoice_id".tr, 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildRadioButton(
                        0,
                        "fixed_date".tr,
                        dateCreated,
                        (p0) => setState(
                              () {
                                FocusScope.of(context).unfocus();

                                dateCreated = p0;
                                startDateController.text = "";
                                endDateController.text = "";
                              },
                            )),
                    buildRadioButton(
                        1,
                        "from/to".tr,
                        dateCreated,
                        (p0) => setState(
                              () {
                                FocusScope.of(context).unfocus();
                                dateCreated = p0;
                                fixedDateController.text = "";
                              },
                            )),
                    SizedBox(height: 10),
                    dateCreated == 0
                        ? SizedBox(
                            width: w,
                            child: TextfieldDatePicker(
                              decoration: InputDecoration(
                                hintText: 'fixed_date'.tr,
                                fillColor: Colors.white,
                                filled: true,
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                              ),
                              textfieldDatePickerController:
                                  fixedDateController,
                              materialDatePickerFirstDate: DateTime(2000),
                              materialDatePickerLastDate: DateTime(2050),
                              materialDatePickerInitialDate: DateTime.now(),
                              preferredDateFormat: DateFormat('dd/MM/yyyy'),
                              cupertinoDatePickerMaximumDate: DateTime(2050),
                              cupertinoDatePickerMinimumDate: DateTime(2000),
                              cupertinoDatePickerBackgroundColor:
                                  Theme.of(context).primaryColor,
                              cupertinoDatePickerMaximumYear: 2050,
                              cupertinoDateInitialDateTime:
                                  DateTime(DateTime.now().year),
                            ),
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                width: 0.4 * w,
                                child: TextfieldDatePicker(
                                  decoration: InputDecoration(
                                    hintText: 'start_date'.tr,
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  textfieldDatePickerController:
                                      startDateController,
                                  materialDatePickerFirstDate: DateTime(2000),
                                  materialDatePickerLastDate: DateTime(2050),
                                  materialDatePickerInitialDate: DateTime.now(),
                                  preferredDateFormat: DateFormat('dd/MM/yyyy'),
                                  cupertinoDatePickerMaximumDate:
                                      DateTime(2050),
                                  cupertinoDatePickerMinimumDate:
                                      DateTime(2000),
                                  cupertinoDatePickerBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  cupertinoDatePickerMaximumYear: 2050,
                                  cupertinoDateInitialDateTime:
                                      DateTime(DateTime.now().year),
                                ),
                              ),
                              SizedBox(
                                width: 0.4 * w,
                                child: TextfieldDatePicker(
                                  decoration: InputDecoration(
                                    hintText: 'end_date'.tr,
                                    fillColor: Colors.white,
                                    filled: true,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                  ),
                                  textfieldDatePickerController:
                                      endDateController,
                                  materialDatePickerFirstDate: DateTime(2000),
                                  materialDatePickerLastDate: DateTime(2050),
                                  materialDatePickerInitialDate: DateTime.now(),
                                  preferredDateFormat: DateFormat('dd/MM/yyyy'),
                                  cupertinoDatePickerMaximumDate:
                                      DateTime(2050),
                                  cupertinoDatePickerMinimumDate:
                                      DateTime(2000),
                                  cupertinoDatePickerBackgroundColor:
                                      Theme.of(context).primaryColor,
                                  cupertinoDatePickerMaximumYear: 2050,
                                  cupertinoDateInitialDateTime:
                                      DateTime(DateTime.now().year),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
              header: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("date_created".tr, 15,
                    fontWeight: FontWeight.bold),
              ),
            ),

            ApplyFilterBTN(
              width: 0.7 * w,
              onTap: () {},
            ),
            // Align(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 30),
            //     width: 0.7 * w,
            //     padding: EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Color(0xff1BAFB2)),
            //     child: Center(child: whiteText("Apply", 15)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Container buildpriceFixedTextfield() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Invoice value ...",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(
      int value, String text, int groupValue, void Function(int)? onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: GFRadio(
              activeBorderColor: Colors.transparent,
              inactiveBorderColor: Colors.transparent,
              inactiveBgColor: Colors.transparent,
              activeBgColor: Colors.transparent,
              radioColor: Color(0xff66B4D2),
              inactiveIcon: Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade300,
              ),
              size: GFSize.SMALL,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}

Widget buildCustomNameTextfield({String? hint}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),
    child: TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
