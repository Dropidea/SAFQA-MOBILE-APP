import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';
import 'package:textfield_datepicker/textfield_datepicker.dart';

class ConsolidatedTaxInvoice extends StatefulWidget {
  ConsolidatedTaxInvoice({super.key});

  @override
  State<ConsolidatedTaxInvoice> createState() => _ConsolidatedTaxInvoiceState();
}

class _ConsolidatedTaxInvoiceState extends State<ConsolidatedTaxInvoice> {
  TextEditingController dateController = TextEditingController();

  int langValue = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("Consolidated Tax Invoice  ", 17),
      ),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          Container(
            width: w,
            height: 150,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xffE47E7B).withOpacity(0.07),
            ),
            child: Center(
              child: blackText(
                  "Please contact customer service and provide them with the required information.\"Address - Commercial Register No - VAT Number\"",
                  14,
                  fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(height: 20),
          blackText("Date", 16),
          SizedBox(
            width: w,
            child: TextfieldDatePicker(
              textfieldDatePickerPadding: EdgeInsets.all(0),
              decoration: InputDecoration(
                hintText: 'Choose',
                fillColor: Color(0xffF8F8F8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.transparent,
                  ),
                ),
              ),
              textfieldDatePickerController: dateController,
              materialDatePickerFirstDate: DateTime(2000),
              materialDatePickerLastDate: DateTime(2050),
              materialDatePickerInitialDate: DateTime.now(),
              preferredDateFormat: DateFormat('dd/MM/yyyy'),
              cupertinoDatePickerMaximumDate: DateTime(2050),
              cupertinoDatePickerMinimumDate: DateTime(2000),
              cupertinoDatePickerBackgroundColor:
                  Theme.of(context).primaryColor,
              cupertinoDatePickerMaximumYear: 2050,
              cupertinoDateInitialDateTime: DateTime(DateTime.now().year),
            ),
          ),
          SizedBox(height: 20),
          blackText("Language", 16),
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
                          Icons.circle,
                          color: Color(0xffF8F8F8),
                        ),
                        size: GFSize.SMALL,
                        value: 0,
                        groupValue: langValue,
                        onChanged: (value) {
                          setState(
                            () {
                              langValue = value;
                            },
                          );
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
                          Icons.circle,
                          color: Color(0xffF8F8F8),
                        ),
                        size: GFSize.SMALL,
                        inactiveBorderColor: Colors.transparent,
                        value: 1,
                        groupValue: langValue,
                        onChanged: (value) {
                          setState(
                            () {
                              langValue = value;
                            },
                          );
                        }),
                  ),
                  greyText("Arabic", 16),
                ],
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                width: 0.4 * w,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff66B4D2),
                      Color(0xff2F6782),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    "Download",
                    style: TextStyle(
                      color: Colors.white,
                      // fontWeight: FontWeight.bold,
                      fontSize: 12.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
