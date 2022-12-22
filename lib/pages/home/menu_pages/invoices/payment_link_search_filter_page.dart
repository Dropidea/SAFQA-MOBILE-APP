import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/payment_link_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class PaymentLinkSearchFilterPage extends StatefulWidget {
  const PaymentLinkSearchFilterPage({super.key});

  @override
  State<PaymentLinkSearchFilterPage> createState() =>
      _PaymentLinkSearchFilterPageState();
}

class _PaymentLinkSearchFilterPageState
    extends State<PaymentLinkSearchFilterPage> {
  int invoiceStatus = 0;
  int paymentAmount = 0;
  int dateCreated = 0;
  late SfRangeValues _values;
  late double sMin;
  late double sMax;
  double sInterval = 20;
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController fixedDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  final PaymentLinkController _paymentLinkController = Get.find();

  @override
  void initState() {
    sMin = _paymentLinkController.minPayLinkValue();
    sMax = _paymentLinkController.maxPayLinkValue();
    _values = SfRangeValues(sMin, sMax);
    if (_paymentLinkController.paymentLinkFilter.payAmount != null ||
        (_paymentLinkController.paymentLinkFilter.payAmountMax == null &&
            _paymentLinkController.paymentLinkFilter.payAmountMin == null)) {
      paymentAmount = 0;
    } else
      paymentAmount = 1;
    if (_paymentLinkController.paymentLinkFilter.createdAt != null ||
        (_paymentLinkController.paymentLinkFilter.createdAtMax == null &&
            _paymentLinkController.paymentLinkFilter.createdAtMin == null)) {
      dateCreated = 0;
    } else
      dateCreated = 1;
    minController.text =
        _paymentLinkController.paymentLinkFilter.payAmountMin ?? "";
    maxController.text =
        _paymentLinkController.paymentLinkFilter.payAmountMax ?? "";
    startDateController.text =
        _paymentLinkController.paymentLinkFilter.createdAtMin ?? "";
    endDateController.text =
        _paymentLinkController.paymentLinkFilter.createdAtMax ?? "";
    fixedDateController.text =
        _paymentLinkController.paymentLinkFilter.createdAt ?? "";

    super.initState();
  }

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
                ClearFilterBTN(
                  onTap: () {
                    _paymentLinkController.clearPayLinkFilter();
                    Get.back();
                  },
                )
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
                        "fixed_val".tr,
                        paymentAmount,
                        (p0) => setState(
                              () {
                                FocusScope.of(context).unfocus();

                                paymentAmount = p0;
                                minController.text = "";
                                maxController.text = "";
                                _paymentLinkController
                                    .paymentLinkFilter.payAmountMin = null;
                                _paymentLinkController
                                    .paymentLinkFilter.payAmountMax = null;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "min/max".tr,
                        paymentAmount,
                        (p0) => setState(
                              () {
                                FocusScope.of(context).unfocus();

                                paymentAmount = p0;
                                _paymentLinkController
                                    .paymentLinkFilter.payAmount = null;
                              },
                            )),
                    SizedBox(height: 10),
                    paymentAmount == 0
                        ? buildInvoiceValueFixedTextfield(
                            initialValue: _paymentLinkController
                                .paymentLinkFilter.payAmount,
                            onChanged: (p0) {
                              _paymentLinkController
                                  .paymentLinkFilter.payAmount = p0;
                            },
                          )
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    width: 0.4 * w,
                                    height: 50,
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      controller: minController,
                                      onChanged: (value) {
                                        _paymentLinkController.paymentLinkFilter
                                            .payAmountMin = value;
                                      },
                                      decoration: InputDecoration(
                                        hintText: "min".tr,
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    width: 0.4 * w,
                                    height: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        _paymentLinkController.paymentLinkFilter
                                            .payAmountMax = value;
                                      },
                                      keyboardType: TextInputType.number,
                                      controller: maxController,
                                      decoration: InputDecoration(
                                        hintText: "max".tr,
                                        fillColor: Colors.white,
                                        filled: true,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SfRangeSlider(
                                // shouldAlwaysShowTooltip: true,

                                min: sMin,
                                max: sMax,
                                values: _values,
                                interval: sMax / 5,
                                activeColor: Color(0xff1BAFB2),
                                showTicks: true,
                                showLabels: true,
                                enableTooltip: true,
                                minorTicksPerInterval: 1,
                                stepSize: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _values = value;
                                    minController.text =
                                        value.start.round().toString();
                                    maxController.text =
                                        value.end.round().toString();
                                    _paymentLinkController.paymentLinkFilter
                                        .payAmountMin = minController.text;
                                    _paymentLinkController.paymentLinkFilter
                                        .payAmountMax = maxController.text;
                                  });
                                },
                              )
                            ],
                          )
                  ],
                ),
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("pl_amount".tr, 15),
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
                                _paymentLinkController
                                    .paymentLinkFilter.createdAtMin = null;
                                _paymentLinkController
                                    .paymentLinkFilter.createdAtMax = null;
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
                                _paymentLinkController
                                    .paymentLinkFilter.createdAt = null;
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
                child: blackText("date_created".tr, 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomerNameTextfield(
                  onChanged: (p0) {
                    _paymentLinkController.paymentLinkFilter.paymentLinkRef =
                        p0;
                  },
                  initialValue:
                      _paymentLinkController.paymentLinkFilter.paymentLinkRef),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("pl_ref".tr, 15),
              ),
            ),
            ApplyFilterBTN(
              width: 0.7 * w,
              onTap: () {
                _paymentLinkController.paymentLinkFilter.createdAt =
                    fixedDateController.text == ""
                        ? null
                        : fixedDateController.text;
                _paymentLinkController.paymentLinkFilter.createdAtMax =
                    endDateController.text == ""
                        ? null
                        : endDateController.text;
                _paymentLinkController.paymentLinkFilter.createdAtMin =
                    startDateController.text == ""
                        ? null
                        : startDateController.text;
                // logSuccess(gstartDateController.text)
                //     .isBefore(DateFormat('dd/MM/yyyy')
                //         .parse(endDateController.text)));
                // logSuccess(_paymentLinkController.paymentLinkFilter.toJson());
                _paymentLinkController.activePayLinkFilter();
                Get.back();
              },
            )
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

  Container buildInvoiceValueFixedTextfield(
      {TextEditingController? controller,
      void Function(String)? onChanged,
      String? initialValue}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        initialValue: initialValue,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          // hintText: "Payment Link value ...",
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

  Container buildCustomerNameTextfield(
      {TextEditingController? controller,
      void Function(String)? onChanged,
      String? initialValue}) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "pl_ref".tr,
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
