import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/payment_link_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_payment_link.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:sizer/sizer.dart';

class PaymentLinkDetailsPage extends StatefulWidget {
  const PaymentLinkDetailsPage({super.key, required this.paymentLink});

  final PaymentLink paymentLink;
  @override
  State<PaymentLinkDetailsPage> createState() => _PaymentLinkDetailsPageState();
}

class _PaymentLinkDetailsPageState extends State<PaymentLinkDetailsPage> {
  final LocalsController _localsController = Get.find();
  final PaymentLinkController _paymentLinkController = Get.find();
  bool isActive = false;
  bool engFlag = false;
  @override
  void initState() {
    engFlag = _localsController.currenetLocale == 0;
    isActive = widget.paymentLink.isActive == 1;
    super.initState();
  }

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
        title: blackText("pl_dateils".tr, 17),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => InvoiceSubCreatePaymentLink(
                        paymentLinkToEdit: widget.paymentLink,
                      ));
                },
                child: Container(
                  width: w / 2.5,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff58D241).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          EvaIcons.edit,
                          color: Color(0xff58D241),
                          size: 18.0.sp,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "edit".tr,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Color(0xff58D241),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  MyDialogs.showDeleteDialoge(
                      message: 'are_you_sure',
                      onProceed: () async {
                        Get.back();
                        await _paymentLinkController
                            .deletePaymentLink(widget.paymentLink);
                      });
                },
                child: Container(
                  width: w / 2.5,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE47E7B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          EvaIcons.trash2,
                          color: Color(0xffE47E7B),
                          size: 18.0.sp,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "remove".tr,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Color(0xffE47E7B),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
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
                      child: blackText("pl_inf".tr, 15),
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
                              title1: "type".tr,
                              content1: "payment_links".tr,
                              title2: "date_created".tr,
                              content2: DateFormat('d/M/y').format(
                                  DateTime.parse(
                                      widget.paymentLink.createdAt!))),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              blackText("pl_url".tr, 14),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                children: [
                                  Text(
                                    isActive ? "active".tr : "inactive".tr,
                                    style: TextStyle(
                                      color: isActive
                                          ? Color(0xff1BAFB2)
                                          : Colors.grey,
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  FlutterSwitch(
                                    height: 20.0,
                                    width: 50.0,
                                    padding: 2.0,
                                    toggleSize: 20.0,
                                    borderRadius: 15.0,
                                    activeColor: Color(0xff1BAFB2),
                                    value: isActive,
                                    onToggle: (value) {
                                      logSuccess(value);
                                      setState(() {
                                        isActive = value;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Laborum aliquip ullamco aute nisi Lorem non do sunt et aute non minim.",
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                decoration: TextDecoration.underline,
                                color: Color(0xff27b4be),
                                decorationColor: Color(0xff27b4be)),
                          ),
                          SizedBox(height: 5),
                          Container(
                            width: w / 3,
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xff00A7B3).withOpacity(0.2)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  EvaIcons.attach,
                                  color: Color(0xff00A7B3),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "copy_link".tr,
                                  style: TextStyle(
                                    fontSize: 10.0.sp,
                                    color: Color(0xff00A7B3),
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          invoiceInfoMethod(
                              title1: "vendor".tr,
                              content1: "Ahmad khaled",
                              title2: "Views",
                              content2: "10"),
                          invoiceInfoMethod(
                              title1: "pl_ref".tr,
                              content1: "12345678985",
                              title2: "pl_amount".tr,
                              content2: widget.paymentLink.paymentAmount ??
                                  "${widget.paymentLink.minAmount}=>${widget.paymentLink.maxAmount}"),
                          invoiceInfoMethod(
                              title1: "pl_title".tr,
                              content1: widget.paymentLink.paymentTitle,
                              title2: "language".tr,
                              content2: widget.paymentLink.language!.id == 1
                                  ? "english".tr
                                  : "arabic".tr),
                          invoiceInfoMethod(
                              title1: "Fixed Price",
                              content1: widget.paymentLink.paymentAmount != null
                                  ? "yes".tr
                                  : "no".tr,
                              title2: "",
                              content2: ""),
                          blackText("comments".tr, 14),
                          SizedBox(height: 5),
                          greyText(
                              widget.paymentLink.comment != null
                                  ? widget.paymentLink.comment!
                                  : engFlag
                                      ? "No Comments"
                                      : "???? ???????? ??????????????",
                              14),
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
                        child: blackText("Payment Link Views", 15),
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
                      child: blackText("Payment Link Transaction Info", 15),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return index == 0
                              ? Row(
                                  children: [
                                    blackText("Number Of Transactions:", 12),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    greyText("2", 12)
                                  ],
                                )
                              : Container(
                                  width: w,
                                  height: h / 4,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: const Color(0xffF8F8F8),
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                            "assets/images/inv_item.png"),
                                        fit: BoxFit.fill),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              greyText("Customer Name", 14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              blackText("Salma Salah", 14)
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              greyText("Phone Number", 14),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              blackText("+987767712314", 14)
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Column(
                                                  children: [
                                                    greyText(
                                                        "Payment Method", 14),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    blackText(
                                                        "VISA/MasterCard", 14)
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Icon(
                                                  Icons.credit_card,
                                                  size: 50,
                                                )
                                              ])
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                          ;
                        },
                        itemCount: 3,
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
            width: 50.0.w,
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
