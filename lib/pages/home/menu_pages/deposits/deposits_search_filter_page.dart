import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class DepositsSearchFilterPage extends StatefulWidget {
  const DepositsSearchFilterPage({super.key});

  @override
  State<DepositsSearchFilterPage> createState() =>
      _DepositsSearchFilterPageState();
}

class _DepositsSearchFilterPageState extends State<DepositsSearchFilterPage> {
  int invoiceStatus = 0;
  int depostisValue = 0;
  int dateCreated = 0;
  SfRangeValues _values = SfRangeValues(0, 100);
  double sMin = 0;
  double sMax = 100;
  double sInterval = 20;
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
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
                Text(
                  "Clear",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Color(0xff00A7B3),
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomerNameTextfield(),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Deposits Reference", 15,
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
              expanded: buildCustomerNameTextfield(),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Bank Name", 15, fontWeight: FontWeight.bold),
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
                        depostisValue,
                        (p0) => setState(
                              () {
                                depostisValue = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Min/Max",
                        depostisValue,
                        (p0) => setState(
                              () {
                                depostisValue = p0;
                              },
                            )),
                    SizedBox(height: 10),
                    depostisValue == 0
                        ? builddepostisValueFixedTextfield()
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
                                      controller: maxController,
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

                                min: sMin,
                                max: sMax,
                                values: _values,
                                interval: sInterval,
                                activeColor: Color(0xff1BAFB2),
                                showTicks: true,
                                showLabels: true,
                                enableTooltip: true,
                                minorTicksPerInterval: 1,
                                stepSize: 1,
                                onChanged: (value) {
                                  setState(() {
                                    _values = value;
                                    maxController.text =
                                        value.end.round().toString();
                                    minController.text =
                                        value.start.round().toString();
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
                child:
                    blackText("Deposits Date", 15, fontWeight: FontWeight.bold),
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
                                dateCreated = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "From/To",
                        dateCreated,
                        (p0) => setState(
                              () {
                                dateCreated = p0;
                              },
                            )),
                    SizedBox(height: 10),
                    dateCreated == 0
                        ? SizedBox(
                            width: w,
                            child: TextfieldDatePicker(
                              decoration: InputDecoration(
                                hintText: 'choose',
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
                                    hintText: 'From',
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
                                    hintText: 'To',
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
                child: blackText("Date", 15, fontWeight: FontWeight.bold),
              ),
            ),
            Align(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                width: 0.7 * w,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1BAFB2)),
                child: Center(child: whiteText("Apply", 15)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container builddepostisValueFixedTextfield() {
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
          hintText: "",
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

  Container buildCustomerNameTextfield() {
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
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "",
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
          GFRadio(
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
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}
