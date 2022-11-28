import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:sizer/sizer.dart';

class ManageUserDetailsPage extends StatelessWidget {
  const ManageUserDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: WhiteAppBar(title: "Address Details"),
      body: Column(
        children: [
          Container(
            width: w - 50,
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
          Expanded(
            child: ExpandableNotifier(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                primary: false,
                children: [
                  invoiceInfoMethod(
                    title1: "Full Name",
                    content1: "Ahmad Ahmad",
                    title2: "Is User Enabled?",
                    content2: "Yes",
                  ),
                  invoiceInfoMethod(
                    title1: "Country",
                    content1: "UAE",
                    title2: "",
                    content2: "",
                  ),
                  invoiceInfoMethod(
                    title1: "Phone Number",
                    content1: "+97651231213123",
                    title2: "",
                    content2: "",
                  ),
                  invoiceInfoMethod(
                    title1: "Email",
                    content1: "email@gmail.com",
                    title2: "",
                    content2: "",
                  ),
                  SizedBox(height: 20),
                  blackText("United Arab Emirates - Roles", 14,
                      fontWeight: FontWeight.bold),
                  blackText("Super Master", 13),
                  SizedBox(height: 20),
                  blackText("United Arab Emirates - Notification Settings", 14,
                      fontWeight: FontWeight.bold),
                  blackText(
                      "Create Invoice / Create Batch Invoice / Refund Transferred / Approve Vendor Account / Deposit / New Order",
                      13),
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
