import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_add_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:sizer/sizer.dart';

class CustomerDetailsPage extends StatelessWidget {
  CustomerDetailsPage({super.key, required this.customer});
  final Customer customer;
  CustomersController _customersController = Get.find();
  LocalsController localsController = Get.put(LocalsController());
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
        title: blackText("customer_details".tr, 17),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AddCustomerPage(
                        customer: customer,
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
                onTap: () async {
                  MyDialogs.showDeleteDialoge(
                      onProceed: () async {
                        Get.back();
                        await _customersController.deleteCustomer(customer.id!);
                      },
                      message: "Are you sure?");
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
                      child: blackText("customer_info".tr, 15,
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
                              title1: "full_name".tr,
                              content1: customer.fullName,
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "mobile_number".tr,
                              content1: customer.country!.code! +
                                  " " +
                                  customer.phoneNumber!,
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "email".tr,
                              content1: customer.email,
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "customer_refrence".tr,
                              content1: localsController.currenetLocale == 0
                                  ? customer.customerReference ?? "No Reference"
                                  : customer.customerReference ??
                                      "لا يوجد مرجع",
                              title2: "",
                              content2: ""),
                          SizedBox(height: 10),
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
                      child: blackText("bank_info".tr, 15,
                          fontWeight: FontWeight.bold),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: customer.bank == null
                          ? Container(
                              width: w,
                              height: 100,
                              child: Center(
                                child: greyText(
                                    localsController.currenetLocale == 0
                                        ? "No Bank"
                                        : "لا يوجد بنك",
                                    20),
                              ),
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                invoiceInfoMethod(
                                    title1: "bank_name".tr,
                                    content1: localsController.currenetLocale ==
                                            0
                                        ? customer.bank!.name ?? "No Bank Name"
                                        : customer.bank!.name ??
                                            "لا يوجد اسم للمصرف",
                                    title2: "",
                                    content2: ""),
                                invoiceInfoMethod(
                                    title1: "bank_account".tr,
                                    content1:
                                        localsController.currenetLocale == 0
                                            ? customer.bankAccount ??
                                                "No Bank Account"
                                            : customer.bankAccount ??
                                                "لا يوجد حساب مصرفي",
                                    title2: "",
                                    content2: ""),
                                invoiceInfoMethod(
                                    title1: "iban".tr,
                                    content1:
                                        localsController.currenetLocale == 0
                                            ? customer.iban ?? "No IBAN Found"
                                            : customer.iban ?? "لا يوجد Iban",
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
