import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/admin/pages/profiles/models/profile_model.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailsPage extends StatelessWidget {
  ProfileDetailsPage({super.key, required this.profile});
  final Profile profile;
  CustomersController _customersController = Get.find();
  GlobalDataController _globalDataController = Get.find();
  BankController _bankController = Get.find();
  LocalsController _localsController = Get.put(LocalsController());

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
        title: blackText("profile_details".tr, 17),
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
                      child: blackText("profile_details".tr, 15,
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
                            title1: "company_name".tr,
                            content1: profile.companyName,
                            title2: "country".tr,
                            content2: _localsController.currenetLocale == 0
                                ? _globalDataController.countries
                                    .firstWhere((element) =>
                                        element.id == profile.countryId)
                                    .nameEn
                                : _globalDataController.countries
                                    .firstWhere((element) =>
                                        element.id == profile.countryId)
                                    .nameAr,
                          ),
                          invoiceInfoMethod(
                              title1: "work_email".tr,
                              content1: profile.workEmail,
                              title2: "work_phone".tr,
                              content2: _globalDataController.getCountryCode(
                                      profile.phoneNumberCodeId!) +
                                  " " +
                                  profile.phoneNumber!),
                          invoiceInfoMethod(
                              title1: "bank_name".tr,
                              content1: _bankController.banks
                                  .firstWhere(
                                      (element) => element.id == profile.bankId)
                                  .name,
                              title2: "bank_account".tr,
                              content2: profile.accountNumber),
                          invoiceInfoMethod(
                            title1: "bank_account_holder_name".tr,
                            content1: profile.bankAccountName,
                            title2: "iban".tr,
                            content2: profile.iban,
                          ),
                          invoiceInfoMethod(
                            title1: "business_type".tr,
                            content1: profile.businessTypeId!.toString(),
                            title2: "approval_status".tr,
                            content2: profile.approvalStatus == 1
                                ? "yes".tr
                                : "no".tr,
                          ),
                          invoiceInfoMethod(
                              title1: "custom_SMS_ar".tr,
                              content1: profile.customSmsAr,
                              title2: "custom_SMS_en".tr,
                              content2: profile.customSmsEn),
                          SizedBox(height: 10),
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
