import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key});

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
        title: blackText("Invoice Details", 17),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: w / 3,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff58D241).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit_outlined,
                      color: Color(0xff58D241),
                      size: 18.0.sp,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Color(0xff58D241),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: w / 3,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffE47E7B).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.delete_outline_outlined,
                      color: Color(0xffE47E7B),
                      size: 18.0.sp,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Color(0xffE47E7B),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ExpandableNotifier(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                primary: false,
                children: [
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Customer Info", 15),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("Invoice ID", 14),
                                  const SizedBox(height: 5),
                                  greyText("2659986 / 2022000048", 12),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("Invoice Date", 14),
                                  const SizedBox(height: 5),
                                  greyText(
                                      DateFormat('dd-MMM-y')
                                          .format(DateTime.now()),
                                      12),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 15),
                          blackText("Customer Name", 14),
                          greyText("Ahmad Amin", 14),
                          SizedBox(height: 15),
                          blackText("Customer Email", 14),
                          greyText("ahmad@gmail.com", 14),
                          SizedBox(height: 15),
                          blackText("Customer Phone Number", 14),
                          greyText("+96398765446", 14),
                          SizedBox(height: 15),
                          blackText("Customer Refrence", 14),
                          greyText("Customer Refrence", 14),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("Comunication method", 14),
                                  greyText("SMS", 14),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("Send SMS counter", 14),
                                  greyText("1", 14),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Invoice Info", 15),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          invoiceInfoMethod(
                              title1: "Type",
                              content1: "Invoice",
                              title2: "Views",
                              content2: "2"),
                          invoiceInfoMethod(
                              title1: "Vendor",
                              content1: "Ahmad khaled",
                              title2: "Status",
                              content2: "Paid"),
                          invoiceInfoMethod(
                              title1: "Invoice Id",
                              content1: "1234678765434567",
                              title2: "Payment method",
                              content2: "Visa/MasterCard"),
                          invoiceInfoMethod(
                              title1: "Currency",
                              content1: "UAE (AED)",
                              title2: "Date Created",
                              content2: DateFormat('dd/M/y').format(
                                DateTime.now().subtract(
                                  Duration(days: 10),
                                ),
                              )),
                          invoiceInfoMethod(
                            title1: "Last sent date",
                            content1: DateFormat('dd/M/y')
                                .format(DateTime.now().subtract(
                              Duration(days: 10),
                            )),
                            title2: "Expiry Date",
                            content2:
                                DateFormat('dd/M/y').format(DateTime.now()) +
                                    " " +
                                    TimeOfDay.now().format(context),
                          ),
                          invoiceInfoMethod(
                              title1: "Remind After",
                              content1: "20 Days",
                              title2: "",
                              content2: ""),
                          SizedBox(height: 10),
                          blackText("Invoice Url", 14),
                          Text(
                            "Laborum aliquip ullamco aute nisi Lorem non do sunt et aute non minim.",
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                decoration: TextDecoration.underline,
                                color: Color(0xff27b4be),
                                decorationColor: Color(0xff27b4be)),
                          ),
                          SizedBox(height: 10),
                          invoiceInfoMethod(
                              title1: "Invoice Display Value",
                              content1: "40 AED",
                              title2: "Discount available",
                              content2: "No"),
                          invoiceInfoMethod(
                              title1: "Attach file",
                              content1: "No File",
                              title2: "Recurring Interval",
                              content2: "No Recurring"),
                          invoiceInfoMethod(
                              title1: "Comments",
                              content1: "No Comments",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "Language of the invoice:",
                              content1: "English",
                              title2: "Terms & conditions",
                              content2: "Disabled"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ExpandablePanel(
                      header: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: blackText("Invoice Items", 15),
                      ),
                      controller: ExpandableController(initialExpanded: true),
                      collapsed: Container(),
                      theme: ExpandableThemeData(hasIcon: false),
                      expanded: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding:
                            const EdgeInsetsDirectional.only(end: 20, top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    blackText("Product Name", 13),
                                    SizedBox(height: 10),
                                    greyText("T-shirt", 13),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    blackText("Quantity", 13),
                                    SizedBox(height: 10),
                                    greyText("10", 13),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    blackText("Unit Price", 13),
                                    SizedBox(height: 10),
                                    greyText("40 AED", 13),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  color: Colors.black,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: Center(
                                    child: whiteText("Total: 40", 14),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  ExpandablePanel(
                      header: Container(
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 0.5),
                          ),
                        ),
                        child: blackText("Invoice Views", 15),
                      ),
                      controller: ExpandableController(initialExpanded: true),
                      collapsed: Container(),
                      theme: ExpandableThemeData(hasIcon: false),
                      expanded: Container(
                        margin: EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                blackText("View DateTime", 14),
                                SizedBox(height: 10),
                                greyText("02/08/2022", 13),
                                SizedBox(height: 10),
                                greyText("02/08/2022", 13),
                              ],
                            ),
                            Column(
                              children: [
                                blackText("IpAddress", 14),
                                SizedBox(height: 10),
                                greyText("197.43.191.171", 13),
                                SizedBox(height: 10),
                                greyText("197.43.191.171", 13),
                              ],
                            )
                          ],
                        ),
                      )),
                  SizedBox(height: 20),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Invoice Info", 15),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          invoiceInfoMethod(
                              title1: "Transaction Date",
                              content1: "lorem",
                              title2: "Transaction Status",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Payment Gateway",
                              content1: "lorem",
                              title2: "Payment ID",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Authorization ID",
                              content1: "lorem",
                              title2: "Track ID",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Transaction ID",
                              content1: "lorem",
                              title2: "Reference ID",
                              content2: "lorem"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget invoiceInfoMethod({
    String? title1,
    String? content1,
    String? title2,
    String? content2,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 45.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title1", 14),
                SizedBox(height: 5),
                greyText("$content1", 14),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title2", 14),
                SizedBox(height: 5),
                greyText("$content2", 14),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
