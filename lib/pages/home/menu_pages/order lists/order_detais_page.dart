import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/controller/order_list_controller.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/create_refucn_page.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/model/order_list_model.dart';
import 'package:sizer/sizer.dart';

class OrderListDetailsPage extends StatelessWidget {
  OrderListDetailsPage({super.key, required this.order});
  final Order order;
  OrderListController _orderListController = Get.find();
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
        title: blackText("order_details".tr, 17),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Get.to(() => CreateRefundPage(id: 1));
            },
            child: Container(
              width: 2 * w / 3,
              height: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 65, 171, 210).withOpacity(0.2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      EvaIcons.refresh,
                      color: Color.fromARGB(255, 65, 171, 210),
                      size: 18.0.sp,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "refund".tr,
                    style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Color.fromARGB(255, 65, 171, 210),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                ],
              ),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     GestureDetector(
          //       onTap: () {
          //         Get.to(() => AddorderPage(
          //               order: order,
          //             ));
          //       },
          //       child: Container(
          //         width: w / 2.5,
          //         height: 50,
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           color: Color(0xff58D241).withOpacity(0.2),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(bottom: 5),
          //               child: Icon(
          //                 EvaIcons.edit,
          //                 color: Color(0xff58D241),
          //                 size: 18.0.sp,
          //               ),
          //             ),
          //             SizedBox(width: 10),
          //             Text(
          //               "edit".tr,
          //               style: TextStyle(
          //                 fontSize: 14.0.sp,
          //                 color: Color(0xff58D241),
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     ),
          //     GestureDetector(
          //       onTap: () async {
          //         MyDialogs.showDeleteDialoge(
          //             onProceed: () async {
          //               Get.back();
          //               await _orderListController.deleteorder(order.id!);
          //             },
          //             message: "are_you_sure".tr);
          //       },
          //       child: Container(
          //         width: w / 2.5,
          //         height: 50,
          //         padding: EdgeInsets.all(10),
          //         decoration: BoxDecoration(
          //           color: Color(0xffE47E7B).withOpacity(0.2),
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: [
          //             Padding(
          //               padding: const EdgeInsets.only(bottom: 5),
          //               child: Icon(
          //                 EvaIcons.trash2,
          //                 color: Color(0xffE47E7B),
          //                 size: 18.0.sp,
          //               ),
          //             ),
          //             SizedBox(width: 10),
          //             Text(
          //               "remove".tr,
          //               style: TextStyle(
          //                 fontSize: 14.0.sp,
          //                 color: Color(0xffE47E7B),
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             )
          //           ],
          //         ),
          //       ),
          //     )
          //   ],
          // ),

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
                      child: blackText("order_info".tr, 15,
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
                            title1: "invoice_status".tr,
                            content1: order.status == "paid"
                                ? "paid".tr
                                : "unpaid".tr,
                            title2: "invoice_value".tr,
                            content2: order.invoiceValue.toString(),
                          ),

                          invoiceInfoMethod(
                            title1: "date_created".tr,
                            content1: order.createdAt,
                            title2: "expiry_date".tr,
                            content2: order.expiryDate,
                          ),
                          // invoiceInfoMethod(
                          //     title1: "mobile_number".tr,
                          //     content1: order.country!.code! +
                          //         " " +
                          //         order.phoneNumber!,
                          //     title2: "",
                          //     content2: ""),
                          // invoiceInfoMethod(
                          //     title1: "email".tr,
                          //     content1: order.email,
                          //     title2: "",
                          //     content2: ""),
                          // invoiceInfoMethod(
                          //     title1: "order_refrence".tr,
                          //     content1: localsController.currenetLocale == 0
                          //         ? order.orderReference ?? "No Reference"
                          //         : order.orderReference ??
                          //             "لا يوجد مرجع",
                          //     title2: "",
                          //     content2: ""),
                          // SizedBox(height: 10),
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
                            title1: "customer_name".tr,
                            content1: order.customerName,
                            title2: "customer_email".tr,
                            content2: order.customerEmail,
                          ),
                          invoiceInfoMethod(
                            title2: "customer_refrence".tr,
                            content2: order.customerReference,
                            title1: "customer_phone_number".tr,
                            content1: order.customerMobile,
                          ),
                          invoiceInfoMethod(
                            title1: "cv_id".tr,
                            content1: order.civilId,
                            title2: "comments".tr,
                            content2: order.comments,
                          ),
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
