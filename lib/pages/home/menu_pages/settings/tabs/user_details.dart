import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_user_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:sizer/sizer.dart';

class ManageUserDetailsPage extends StatelessWidget {
  ManageUserDetailsPage({super.key, required this.manageUser});
  GlobalDataController globalDataController = Get.find();
  final ManageUser manageUser;
  String _getNotificationString() {
    String tmp = "";
    if (manageUser.notificationCreateInvoice == 1) {
      tmp += "Notification Create Invoice / ";
    }
    if (manageUser.notificationApproveVendorAccount == 1) {
      tmp += "Notification Approve Vendor Account / ";
    }
    if (manageUser.notificationCreateBatchInvoice == 1) {
      tmp += "Notification Create Batch Invoice / ";
    }
    if (manageUser.notificationCreateRecurringInvoice == 1) {
      tmp += "Notification Create Recurring Invoice / ";
    }
    if (manageUser.notificationCreateShippingInvoice == 1) {
      tmp += "Notification Create Shipping Invoice / ";
    }
    if (manageUser.notificationDeposit == 1) {
      tmp += "Notification Deposit / ";
    }
    if (manageUser.notificationInvoicePaid == 1) {
      tmp += "Notification Invoice Paid / ";
    }
    if (manageUser.notificationNewOrder == 1) {
      tmp += "Notification New Order / ";
    }
    if (manageUser.notificationNotificationsHourlyDepositRejected == 1) {
      tmp += "Notification Notifications Hourly Deposit Rejected / ";
    }
    if (manageUser.notificationNotificationsServiceRequest == 1) {
      tmp += "Notification Notifications Service Request / ";
    }
    if (manageUser.notificationRefundTransfered == 1) {
      tmp += "Notification Refund Transfered / ";
    }

    return tmp;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: WhiteAppBar(title: "Address Details"),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => AddUserPage(
                    userToEdit: manageUser,
                  ));
            },
            child: Container(
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
                    content1: manageUser.fullName,
                    title2: "Is User Enabled?",
                    content2: manageUser.isEnable == 1 ? "Yes" : "No",
                  ),
                  invoiceInfoMethod(
                    title1: "Country",
                    content1: manageUser.nationality!.nameEn,
                    title2: "",
                    content2: "",
                  ),
                  invoiceInfoMethod(
                    title1: "Phone Number",
                    content1:
                        "${globalDataController.getCountryCode(manageUser.phoneNumberCodeManagerId)} ${manageUser.phoneNumberManager!}",
                    title2: "",
                    content2: "",
                  ),
                  invoiceInfoMethod(
                    title1: "Email",
                    content1: manageUser.email,
                    title2: "",
                    content2: "",
                  ),
                  SizedBox(height: 20),
                  blackText("United Arab Emirates - Roles", 14,
                      fontWeight: FontWeight.bold),
                  blackText(manageUser.userRole!.nameEn!, 13),
                  SizedBox(height: 20),
                  blackText("United Arab Emirates - Notification Settings", 14,
                      fontWeight: FontWeight.bold),
                  blackText(
                      _getNotificationString()
                          .substring(0, _getNotificationString().length - 2),
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
