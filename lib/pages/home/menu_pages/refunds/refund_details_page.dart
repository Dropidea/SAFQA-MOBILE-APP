import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/refunds/models/refund_model.dart';
import 'package:sizer/sizer.dart';

class RefundsDetailsPage extends StatelessWidget {
  const RefundsDetailsPage({super.key, required this.refund});
  final Refund refund;
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
        title: blackText("refund_info".tr, 17),
      ),
      body: Column(
        children: [
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
                      child: blackText("refund_details".tr, 15,
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
                              title1: "refund_id".tr,
                              content1: "123172381992391873",
                              title2: "date_created".tr,
                              content2: DateFormat.yMMMEd().format(
                                  DateTime.tryParse(refund.createdAt!)!)),
                          invoiceInfoMethod(
                              title1: "invoice_id".tr,
                              content1: refund.invoice!.id!.toString(),
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "customer_name".tr,
                              content1: refund.invoice!.customerName,
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "amount_deducted_from_vendor".tr,
                              content1: "5.62",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "amount_refunded_to_cutomer".tr,
                              content1: "12.31",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "refund_status".tr,
                              content1: refund.status,
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "amount".tr,
                              content1: refund.amount.toString(),
                              title2: "",
                              content2: ""),
                        ],
                      ),
                    ),
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
            width: 45.0.w,
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
              crossAxisAlignment: CrossAxisAlignment.start,
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
