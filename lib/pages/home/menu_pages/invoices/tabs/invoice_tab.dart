import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
        return ListView(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     blackText("Today", 16),
            //     greyText("09 October 2022", 14)
            //   ],
            // ),
            ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => InvoiceWidget(
                inv: invoiceController.invoicesToShow[index],
                onTap: () {
                  Get.to(
                    () => InvoiceDetailsPage(
                        invoiceModel: invoiceController.invoicesToShow[index]),
                    transition: Transition.downToUp,
                  );
                },
                type: InvoiceTypes.paid,
              ),
              itemCount: invoiceController.invoicesToShow.length,
              separatorBuilder: (BuildContext context, int index) =>
                  SizedBox(height: 20),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     blackText("Yesterday", 16),
            //     greyText("08 October 2022", 14)
            //   ],
            // ),
            // ListView.separated(
            //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) => InvoiceWidget(
            //     inv: invoiceController.invoices[index],
            //     type: InvoiceTypes.pending,
            //   ),
            //   itemCount: invoiceController.invoices.length,
            //   separatorBuilder: (BuildContext context, int index) =>
            //       SizedBox(height: 20),
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     blackText("Last week", 16),
            //     greyText("01 October 2022", 14)
            //   ],
            // ),
            // ListView.separated(
            //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            //   shrinkWrap: true,
            //   physics: NeverScrollableScrollPhysics(),
            //   itemBuilder: (context, index) => InvoiceWidget(
            //     inv: invoiceController.invoices[index],
            //     type: InvoiceTypes.pending,
            //   ),
            //   itemCount: invoiceController.invoices.length,
            //   separatorBuilder: (BuildContext context, int index) =>
            //       SizedBox(height: 20),
            // )
          ],
        );
      }
    });
  }
}

class InvoiceWidget extends StatelessWidget {
  final InvoiceModel inv;
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
                  inv.invoiceItem!.isEmpty
                      ? "no date"
                      : DateFormat('hh:mm a').format(
                          DateTime.parse(inv.invoiceItem![0].createdAt!)),
                  12)
            ],
          )
        ],
      ),
    );
  }
}
