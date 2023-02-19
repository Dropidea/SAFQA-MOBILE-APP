import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/admin/pages/profiles/controller/profiles_controller.dart';
import 'package:safqa/admin/pages/profiles/models/profile_model.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/user_details.dart';
import 'package:sizer/sizer.dart';

class ProfileDetailsPage extends StatefulWidget {
  ProfileDetailsPage({super.key, required this.profile});
  final Profile profile;

  @override
  State<ProfileDetailsPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ProfileDetailsPage> {
  GlobalDataController _globalDataController = Get.find();

  BankController _bankController = Get.find();

  LocalsController _localsController = Get.put(LocalsController());

  ProfilesController _profilesController = Get.find();
  @override
  void initState() {
    _profilesController.getManageUsersAdmin(widget.profile.id!);
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
                            content1: widget.profile.companyName,
                            title2: "country".tr,
                            content2: _localsController.currenetLocale == 0
                                ? _globalDataController.countries
                                    .firstWhere((element) =>
                                        element.id == widget.profile.countryId)
                                    .nameEn
                                : _globalDataController.countries
                                    .firstWhere((element) =>
                                        element.id == widget.profile.countryId)
                                    .nameAr,
                          ),
                          invoiceInfoMethod(
                              title1: "work_email".tr,
                              content1: widget.profile.workEmail,
                              title2: "work_phone".tr,
                              content2: _globalDataController.getCountryCode(
                                      widget.profile.phoneNumberCodeId!) +
                                  " " +
                                  widget.profile.phoneNumber!),
                          invoiceInfoMethod(
                              title1: "bank_name".tr,
                              content1: _bankController.banks
                                  .firstWhere((element) =>
                                      element.id == widget.profile.bankId)
                                  .name,
                              title2: "bank_account".tr,
                              content2: widget.profile.accountNumber),
                          invoiceInfoMethod(
                            title1: "bank_account_holder_name".tr,
                            content1: widget.profile.bankAccountName,
                            title2: "iban".tr,
                            content2: widget.profile.iban,
                          ),
                          invoiceInfoMethod(
                            title1: "business_type".tr,
                            content1: widget.profile.businessTypeId!.toString(),
                            title2: "approval_status".tr,
                            content2: widget.profile.approvalStatus == 1
                                ? "yes".tr
                                : "no".tr,
                          ),
                          invoiceInfoMethod(
                              title1: "custom_SMS_ar".tr,
                              content1: widget.profile.customSmsAr,
                              title2: "custom_SMS_en".tr,
                              content2: widget.profile.customSmsEn),
                          SizedBox(height: 10),
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
                      child: blackText("users".tr, 15,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GetBuilder<ProfilesController>(builder: (c) {
                        return c.getManageUserFlag
                            ? Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () =>
                                          Get.to(() => ManageUserDetailsPage(
                                                manageUser:
                                                    c.manageUsers[index],
                                                activeToEdit: false,
                                              )),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              color: Color(0xffF9F9F9),
                                            ),
                                            child: Center(
                                              child: greyText("A", 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                blackText(
                                                    c.manageUsers[index]
                                                        .fullName!,
                                                    15),
                                                SizedBox(height: 5),
                                                blueText(
                                                  c.manageUsers[index].email!
                                                              .length >
                                                          20
                                                      ? c.manageUsers[index]
                                                              .email!
                                                              .substring(
                                                                  0, 20) +
                                                          "..."
                                                      : c.manageUsers[index]
                                                          .email!,
                                                  14,
                                                  // underline: true,
                                                ),
                                                SizedBox(height: 5),
                                                greyText(
                                                    c.manageUsers[index]
                                                        .phoneNumberManager!,
                                                    14),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 20,
                                    ),
                                itemCount: c.manageUsers.length);
                      }),
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
