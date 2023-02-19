import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/data_to_create_invoice.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/models/invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_invoice.dart';
import 'package:sizer/sizer.dart';

class InvoiceDetailsPage extends StatelessWidget {
  InvoiceDetailsPage({super.key, required this.invoiceModel});
  final Invoice invoiceModel;
  DataToCreateInvoice? invoiceToEdit;
  GlobalDataController globalDataController = Get.find();
  AddInvoiceController addInvoiceController = Get.find();
  final LocalsController _localsController = Get.put(LocalsController());

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
        title: blackText("invoice_details".tr, 17),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  invoiceToEdit =
                      DataToCreateInvoice.fromJson(invoiceModel.toJson());

                  addInvoiceController.dataToEditInvoice = invoiceToEdit;

                  if (invoiceModel.currency != null) {
                    addInvoiceController.dataToEditInvoice!.currencyId =
                        invoiceModel.currency!.id!.toString();
                  }
                  if (invoiceModel.mobileCode != null)
                    // ignore: curly_braces_in_flow_control_structures
                    addInvoiceController
                            .dataToEditInvoice!.customerMobileNumbrCode =
                        invoiceModel.mobileCode!.code!.toString();

                  Get.to(() => InvoiceSubCreateInvoice());
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
              Container(
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
                      child: blackText("customer_info".tr, 15),
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
                                  blackText("invoice_id".tr, 14),
                                  const SizedBox(height: 5),
                                  greyText(invoiceModel.id.toString(), 12),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("invoice_date".tr, 14),
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
                          blackText("cus_name".tr, 14),
                          greyText(invoiceModel.customerName!, 14),
                          SizedBox(height: 15),
                          blackText("cus_email".tr, 14),
                          greyText(
                              _localsController.currenetLocale == 0
                                  ? invoiceModel.customerEmail ?? "No Email"
                                  : invoiceModel.customerEmail ??
                                      "لا يوجد إيميل",
                              14),
                          SizedBox(height: 15),
                          blackText("cus_phone_num".tr, 14),
                          greyText(
                              invoiceModel.customerMobile == null
                                  ? _localsController.currenetLocale == 0
                                      ? "No Mobile Number"
                                      : "لا يوجد رقم هاتف"
                                  : "${invoiceModel.mobileCode != null ? invoiceModel.mobileCode!.code : ''} ${invoiceModel.customerMobile!}",
                              14),
                          SizedBox(height: 15),
                          blackText("customer_refrence".tr, 14),
                          greyText(
                              _localsController.currenetLocale == 0
                                  ? invoiceModel.customerReference ??
                                      "No Customer Refrence"
                                  : invoiceModel.customerReference ??
                                      "لا يوجد مرجع للزبون",
                              14),
                          SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("comunication_method".tr, 14),
                                  greyText(
                                      globalDataController.getSendOption(
                                          invoiceModel.sendInvoiceOptionId!),
                                      14),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText("send_sms_counter".tr, 14),
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
                      child: blackText("invoice_info".tr, 15),
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
                              content1: _localsController.currenetLocale == 0
                                  ? "Invoice"
                                  : "فاتورة",
                              title2: "views".tr,
                              content2: "2"),
                          invoiceInfoMethod(
                              title1: "vendor".tr,
                              content1: "Ahmad khaled",
                              title2: "status".tr,
                              content2: "Paid"),
                          invoiceInfoMethod(
                              title1: "invoice_id".tr,
                              content1: "1234678765434567",
                              title2: "pay_method".tr,
                              content2: "Visa/MasterCard"),
                          invoiceInfoMethod(
                              title1: "currency".tr,
                              content1:
                                  "${invoiceModel.currency!.currency!} (${invoiceModel.currency!.shortCurrency!})",
                              title2: "date_created".tr,
                              content2: DateFormat('dd/M/y').format(
                                DateTime.now().subtract(
                                  Duration(days: 10),
                                ),
                              )),
                          invoiceInfoMethod(
                            title1: "l_s_date".tr,
                            content1: DateFormat('dd/M/y')
                                .format(DateTime.now().subtract(
                              Duration(days: 10),
                            )),
                            title2: "expiry_date".tr,
                            content2: DateFormat('dd/M/y').format(
                                    DateTime.parse(invoiceModel.expiryDate!)) +
                                " " +
                                DateFormat('hh:mm a').format(
                                    DateTime.parse(invoiceModel.expiryDate!)),
                          ),
                          invoiceInfoMethod(
                              title1: "remind_after".tr,
                              content1: "${invoiceModel.remindAfter} Days",
                              title2: "",
                              content2: ""),
                          SizedBox(height: 10),
                          blackText("invoice_url", 14),
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
                              title1: "invoice_value".tr,
                              content1:
                                  "${invoiceModel.invoiceValue!} ${invoiceModel.currency!.shortCurrency!}",
                              title2: "discount_available".tr,
                              content2: invoiceModel.discountType == null
                                  ? "no".tr
                                  : "yes".tr),
                          invoiceInfoMethod(
                              title1: "attach_file".tr,
                              content1:
                                  invoiceModel.attachFile ?? "No File Attached",
                              title2: "recurring_interval".tr,
                              content2: invoiceModel.recurringIntervalId == null
                                  ? "No Recurring"
                                  : invoiceModel.recurringIntervalId
                                      .toString()),
                          invoiceInfoMethod(
                              title1: "comments".tr,
                              content1: _localsController.currenetLocale == 0
                                  ? invoiceModel.comments ?? "No Comments found"
                                  : invoiceModel.comments ?? "لا يوجد تعليقات",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "language_of_invoice".tr,
                              content1: invoiceModel.languageId!.toString(),
                              title2: "terms_conditions".tr,
                              content2: _localsController.currenetLocale == 0
                                  ? invoiceModel.termsAndConditions ??
                                      "No Terms & Conditions"
                                  : invoiceModel.termsAndConditions ??
                                      "لا يوجد بنود وظروف"),
                        ],
                      ),
                    ),
                  ),
                  invoiceModel.invoiceItem!.isEmpty
                      ? Container()
                      : SizedBox(height: 20),
                  invoiceModel.invoiceItem!.isEmpty
                      ? Container()
                      : ExpandablePanel(
                          header: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.grey, width: 0.5),
                              ),
                            ),
                            child: blackText("invoice_items".tr, 15),
                          ),
                          controller:
                              ExpandableController(initialExpanded: true),
                          collapsed: Container(),
                          theme: ExpandableThemeData(hasIcon: false),
                          expanded: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: invoiceModel.invoiceItem!.length,
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.only(top: 10),
                              padding: const EdgeInsetsDirectional.only(
                                  end: 20, top: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          blackText("product_name".tr, 13),
                                          SizedBox(height: 10),
                                          greyText(
                                              invoiceModel.invoiceItem![index]
                                                  .productName!,
                                              13),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          blackText("quantity".tr, 13),
                                          SizedBox(height: 10),
                                          greyText(
                                              invoiceModel.invoiceItem![index]
                                                  .productQuantity!
                                                  .toString(),
                                              13),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          blackText("unit_price".tr, 13),
                                          SizedBox(height: 10),
                                          greyText(
                                              "${invoiceModel.invoiceItem![index].productPrice!} ${invoiceModel.currency!.shortCurrency!}",
                                              13),
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
                                          child: whiteText(
                                              "${"total".tr}: ${invoiceModel.invoiceItem![index].productPrice! * invoiceModel.invoiceItem![index].productQuantity!} ${invoiceModel.currency!.shortCurrency!} ",
                                              14),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
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
                      child: blackText("Invoice Transaction Info", 15),
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
