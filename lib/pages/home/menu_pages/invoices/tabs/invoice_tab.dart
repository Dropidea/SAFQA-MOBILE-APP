import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/invoice_types.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/pages/home/menu_pages/invoices/models/invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoice_details.dart';
import 'package:sizer/sizer.dart';

class InvoiceTab extends StatefulWidget {
  const InvoiceTab({super.key});

  @override
  State<InvoiceTab> createState() => _InvoiceTabState();
}

class _InvoiceTabState extends State<InvoiceTab> {
  InvoicesController invoiceController = Get.find();
  @override
  void initState() {
    invoiceController.getInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GetBuilder<InvoicesController>(builder: (c) {
      if (c.getInvoicesFlag.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return GetBuilder<InvoicesController>(builder: (c) {
          return c.invoicesToShow.isEmpty
              ? Center(
                  child: greyText("nothing_to_show".tr, 20),
                )
              : ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  shrinkWrap: true,
                  // physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => InvoiceWidget(
                    inv: c.invoicesToShow[index],
                    onTap: () async {
                      logSuccess(c.invoicesToShow[index].toJson());
                      Invoice i = await invoiceController
                          .showInvoice(c.invoicesToShow[index].id!);
                      logError(i.toJson());
                      Get.to(
                        () => InvoiceDetailsPage(invoiceModel: i),
                        transition: Transition.downToUp,
                      );
                    },
                    type: c.invoicesToShow[index].status == "pending"
                        ? InvoiceTypes.pending
                        : c.invoicesToShow[index].status == "canceled"
                            ? InvoiceTypes.canceled
                            : c.invoicesToShow[index].status == "paid"
                                ? InvoiceTypes.paid
                                : InvoiceTypes.canceled,
                  ),
                  itemCount: c.invoicesToShow.length,
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(height: 20),
                );
        });
      }
    });
  }
}

class InvoiceWidget extends StatelessWidget {
  final Invoice inv;
  final InvoiceTypes type;
  final void Function()? onTap;
  InvoiceWidget({
    Key? key,
    required this.inv,
    this.onTap,
    required this.type,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffF8F8F8),
                ),
                child: type == InvoiceTypes.pending
                    ? Image(
                        image: AssetImage("assets/images/pending.png"),
                        width: 24.0.sp,
                        height: 24.0.sp,
                      )
                    : Icon(
                        type == InvoiceTypes.paid
                            ? Icons.check_rounded
                            : type == InvoiceTypes.unPaid
                                ? Icons.close
                                : Icons.remove_red_eye,
                        size: 24.0.sp,
                        color: type == InvoiceTypes.paid
                            ? Color(0xff58D241)
                            : type == InvoiceTypes.unPaid
                                ? Color(0xffE47E7B)
                                : Color(0xff2F6782)),
              ),
              SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blackText(inv.customerName!, 16),
                  SizedBox(height: 10),
                  greyText(inv.id!.toString(), 12)
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              blackText(inv.invoiceValue!.toString(), 16),
              SizedBox(height: 10),
              greyText(
                  inv.invoiceItem.isEmpty
                      ? "no date"
                      : DateFormat('hh:mm a').format(
                          DateTime.parse(inv.invoiceItem[0].createdAt!)),
                  12)
            ],
          )
        ],
      ),
    );
  }
}
