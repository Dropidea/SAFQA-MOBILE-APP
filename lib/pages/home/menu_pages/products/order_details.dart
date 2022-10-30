import 'dart:math' as math;

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:sizer/sizer.dart';

class OrderDetailsPage extends StatelessWidget {
  const OrderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        actions: [
          MyPopUpMenu(
            iconColor: Colors.black,
            menuList: [
              PopupMenuItem(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.playlist_add_check,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  blackText("Picked", 11),
                ],
              )),
              PopupMenuItem(
                  child: Row(
                children: [
                  Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(math.pi),
                    child: Icon(
                      Icons.replay_outlined,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 10),
                  blackText("Resend Reciept", 11),
                ],
              )),
              PopupMenuItem(
                  child: Row(
                children: [
                  Icon(
                    Icons.print,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  blackText("Print", 11),
                ],
              )),
            ],
          )
        ],
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("Order Details", 17),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: w / 3.5,
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
                      size: 16.0.sp,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Edit",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Color(0xff58D241),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: w / 3.5,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xff00A7B3).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Icon(
                        Icons.replay_sharp,
                        color: Color(0xff00A7B3),
                        size: 16.0.sp,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Refund",
                      style: TextStyle(
                        fontSize: 12.0.sp,
                        color: Color(0xff00A7B3),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: w / 3.5,
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
                      size: 16.0.sp,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 12.0.sp,
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
                      child: blackText("Order info", 16,
                          fontWeight: FontWeight.bold),
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
                              title1: "Order ID",
                              content1: "21432446344",
                              title2: "Views",
                              content2: "2"),
                          invoiceInfoMethod(
                              title1: "Invoice value",
                              content1: "430 AED",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "Date created",
                              content1: "30/10/2021 08:18 PM",
                              title2: "Expiry date",
                              content2: "30/10/2021 08:18 PM"),
                          invoiceInfoMethod(
                              title1: "Order Status",
                              content1: "Prepared",
                              title2: "Order Type",
                              content2: "Pickup"),
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
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Customer info", 16,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10),
                          blackText("Customer Name", 14),
                          greyText("Ahmed Amin", 14),
                          SizedBox(height: 20),
                          blackText("Customer Mobile", 14),
                          greyText("+9715981331524", 14),
                          SizedBox(height: 20),
                          blackText("Customer Email", 14),
                          greyText("Mohammed@gmail.com", 14),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Payment Information Details", 16,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          invoiceInfoMethod(
                              title1: "Paid Date",
                              content1: "20/08/2022",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "Vendor Service Charge",
                              content1: "1.165 AED",
                              title2: "Due Deposit",
                              content2: "4.777 AED"),
                          invoiceInfoMethod(
                              title1: "Customer Service Charge",
                              content1: "0.000 AED",
                              title2: "VAT Amount",
                              content2: "0.058 AED"),
                          invoiceInfoMethod(
                              title1: "Customer Service Charge",
                              content1: "0.000 AED",
                              title2: "",
                              content2: ""),
                        ],
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Transaction Details", 16,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          invoiceInfoMethod(
                              title1: "Transaction Date",
                              content1: "20/08/2022",
                              title2: "Transaction Status",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Payment Gateway",
                              content1: "lorem",
                              title2: "Payment ID",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Transaction ID",
                              content1: "lorem",
                              title2: "Reference ID",
                              content2: "lorem"),
                          invoiceInfoMethod(
                              title1: "Track ID",
                              content1: "lorem",
                              title2: "",
                              content2: ""),
                        ],
                      ),
                    ),
                  ),
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Order Items", 16,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                        margin: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            InvoiceItem item = InvoiceItem(
                              productName: "name",
                              quantity: 10,
                              unitPrice: "100",
                            );

                            return Container(
                              width: w,
                              height: h / 4,
                              margin: EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/inv_item.png"),
                                    fit: BoxFit.fill),
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: h / 8,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            greyText("Product Name", 11),
                                            const SizedBox(height: 10),
                                            blackText(item.productName!, 11)
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            greyText("Unit Price", 11),
                                            SizedBox(height: 10),
                                            blackText("\$${item.unitPrice}", 11)
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            greyText("Quantity", 11),
                                            SizedBox(height: 10),
                                            blackText(
                                                item.quantity!
                                                    .round()
                                                    .toString(),
                                                11)
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: GFColors.DANGER
                                                          .withOpacity(0.2)),
                                                  child: Icon(Icons.delete,
                                                      color: GFColors.DANGER
                                                          .withAlpha(200)),
                                                ),
                                                SizedBox(width: 2),
                                                Container(
                                                  padding: EdgeInsets.all(2),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: GFColors.SUCCESS
                                                          .withOpacity(0.2)),
                                                  child: Icon(
                                                      Icons.mode_edit_outlined,
                                                      color: GFColors.SUCCESS
                                                          .withAlpha(200)),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        blackText("Total", 18),
                                        SizedBox(width: 20),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20),
                                          child: Text(
                                            "\$ 400",
                                            style: TextStyle(
                                                fontSize: 15.0.sp,
                                                color: Colors.white),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Colors.black,
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                          itemCount: 3,
                        )),
                  ),
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
            width: 48.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title1", 13),
                SizedBox(height: 5),
                greyText("$content1", 13),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                blackText("$title2", 13),
                SizedBox(height: 5),
                greyText("$content2", 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
