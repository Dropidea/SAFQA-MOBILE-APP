import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class InvoiceSearchFilterPage extends StatefulWidget {
  const InvoiceSearchFilterPage({super.key});

  @override
  State<InvoiceSearchFilterPage> createState() =>
      _InvoiceSearchFilterPageState();
}

class _InvoiceSearchFilterPageState extends State<InvoiceSearchFilterPage> {
  int invoiceStatus = 0;
  int invoiceValue = 0;
  int dateCreated = 0;
  late SfRangeValues _values;
  double sMin = 0;
  double sMax = 100;
  double sInterval = 20;
  TextEditingController maxValueController = TextEditingController();
  TextEditingController minValueController = TextEditingController();
  TextEditingController valueController = TextEditingController();
  TextEditingController fixedDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController customerNameController = TextEditingController();
  final InvoicesController _invoicesController = Get.find();

  @override
  void initState() {
    if (_invoicesController.invoiceFilter.value == null) {
      invoiceValue = 1;
    } else {
      invoiceValue = 0;
    }
    if (_invoicesController.invoiceFilter.date == null) {
      dateCreated = 1;
    } else {
      dateCreated = 0;
    }
    logSuccess(_invoicesController.invoiceFilter.toJson());
    customerNameController.text =
        _invoicesController.invoiceFilter.customerName ?? "";
    startDateController.text =
        _invoicesController.invoiceFilter.startDate ?? "";
    endDateController.text = _invoicesController.invoiceFilter.endDate ?? "";
    fixedDateController.text = _invoicesController.invoiceFilter.date ?? "";
    minValueController.text =
        (_invoicesController.invoiceFilter.valueMin ?? "").toString();
    maxValueController.text =
        (_invoicesController.invoiceFilter.valueMax ?? "").toString();
    valueController.text =
        (_invoicesController.invoiceFilter.value ?? "").toString();

    _values = SfRangeValues(_invoicesController.minInvoiceValue(),
        _invoicesController.maxInvoiceValue());
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
                    _invoicesController.clearInvoiceFilter();
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
                        "All",
                        invoiceStatus,
                        (p0) => setState(
                              () {
                                invoiceStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Paid",
                        invoiceStatus,
                        (p0) => setState(
                              () {
                                invoiceStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "Unpaid",
                        invoiceStatus,
                        (p0) => setState(
                              () {
                                invoiceStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        3,
                        "Pending",
                        invoiceStatus,
                        (p0) => setState(
                              () {
                                invoiceStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        4,
                        "Canceled",
                        invoiceStatus,
                        (p0) => setState(
                              () {
                                invoiceStatus = p0;
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
                child: blackText("Invoice Status", 15),
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
                        "Fixed Value",
                        invoiceValue,
                        (p0) => setState(
                              () {
                                maxValueController.text = "";
                                minValueController.text = "";
                                invoiceValue = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Min/Max",
                        invoiceValue,
                        (p0) => setState(
                              () {
                                invoiceValue = p0;
                                valueController.text = "";
                              },
                            )),
                    SizedBox(height: 10),
                    invoiceValue == 0
                        ? buildInvoiceValueFixedTextfield(
                            controller: valueController,
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
                                      controller: minValueController,
                                      onChanged: (value) {},
                                      decoration: InputDecoration(
                                        hintText: "Min",
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
                                      onChanged: (value) {},
                                      keyboardType: TextInputType.number,
                                      controller: maxValueController,
                                      decoration: InputDecoration(
                                        hintText: "Max",
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

                                min: _invoicesController.minInvoiceValue(),
                                max: _invoicesController.maxInvoiceValue(),
                                values: _values,
                                interval:
                                    _invoicesController.maxInvoiceValue() / 5,
                                activeColor: Color(0xff1BAFB2),
                                showTicks: true,
                                showLabels: true,
                                enableTooltip: true,
                                minorTicksPerInterval: 1,
                                stepSize: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _values = value;
                                    maxValueController.text =
                                        value.end.round().toString();
                                    minValueController.text = minValueController
                                        .text = value.start.round().toString();
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
                child: blackText("Invoice Value", 15),
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
                        "Fixed Date",
                        dateCreated,
                        (p0) => setState(
                              () {
                                startDateController.text = "";
                                endDateController.text = "";
                                dateCreated = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "From/To",
                        dateCreated,
                        (p0) => setState(
                              () {
                                fixedDateController.text = "";
                                dateCreated = p0;
                              },
                            )),
                    SizedBox(height: 10),
                    dateCreated == 0
                        ? SizedBox(
                            width: w,
                            child: TextfieldDatePicker(
                              decoration: InputDecoration(
                                hintText: 'yyyy-MM-dd',
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
                              preferredDateFormat: DateFormat('yyyy-MM-dd'),
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
                                    hintText: 'yyyy-MM-dd',
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
                                  preferredDateFormat: DateFormat('yyyy-MM-dd'),
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
                                    hintText: 'yyyy-MM-dd',
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
                                  preferredDateFormat: DateFormat('yyyy-MM-dd'),
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
                child: blackText("Date Created", 15),
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
                  textEditingController: customerNameController),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Customer Name", 15),
              ),
            ),
            ApplyFilterBTN(
              onTap: () {
                _invoicesController.invoiceFilter.valueMin =
                    minValueController.text != ""
                        ? int.parse(minValueController.text)
                        : null;
                _invoicesController.invoiceFilter.valueMax =
                    maxValueController.text != ""
                        ? int.parse(maxValueController.text)
                        : null;
                _invoicesController.invoiceFilter.value =
                    valueController.text != ""
                        ? int.parse(valueController.text)
                        : null;

                _invoicesController.invoiceFilter.date =
                    fixedDateController.text == ""
                        ? null
                        : fixedDateController.text;
                _invoicesController.invoiceFilter.startDate =
                    startDateController.text == ""
                        ? null
                        : startDateController.text;
                _invoicesController.invoiceFilter.endDate =
                    endDateController.text == ""
                        ? null
                        : endDateController.text;

                _invoicesController.invoiceFilter.customerName =
                    customerNameController.text == ""
                        ? null
                        : customerNameController.text;
                _invoicesController.activeProductFilter();
                Get.back();
              },
              width: 0.7 * w,
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

  Container buildInvoiceValueFixedTextfield(
      {String? initialValue, TextEditingController? controller}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        initialValue: initialValue,
        keyboardType: TextInputType.number,
        controller: controller,
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

  Container buildCustomerNameTextfield(
      {TextEditingController? textEditingController}) {
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
        controller: textEditingController,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Customer Name ...",
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
