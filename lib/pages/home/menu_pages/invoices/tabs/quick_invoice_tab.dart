import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/models/invoice.dart';
import 'package:safqa/models/invoice_types.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/quick_invoice_details.dart';
import 'package:sizer/sizer.dart';

class QuickInvoiceTab extends StatefulWidget {
  const QuickInvoiceTab({super.key});

  @override
  State<QuickInvoiceTab> createState() => _QuickInvoiceTabState();
}

class _QuickInvoiceTabState extends State<QuickInvoiceTab> {
  InvoicesController invoiceController = Get.find();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [blackText("Today", 16), greyText("09 October 2022", 14)],
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => InvoiceWidget(
            inv: invoiceController.invoicest[index],
            onTap: () {
              Get.to(
                () => QuickInvoiceDetailsPage(),
                transition: Transition.downToUp,
              );
            },
          ),
          itemCount: invoiceController.invoicest.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            blackText("Yesterday", 16),
            greyText("08 October 2022", 14)
          ],
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              InvoiceWidget(inv: invoiceController.invoicest[index]),
          itemCount: invoiceController.invoicest.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 20),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            blackText("Last week", 16),
            greyText("01 October 2022", 14)
          ],
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) =>
              InvoiceWidget(inv: invoiceController.invoicest[index]),
          itemCount: invoiceController.invoicest.length,
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 20),
        )
      ],
    );
  }
}

class InvoiceWidget extends StatelessWidget {
  final Invoice inv;
  final void Function()? onTap;
  InvoiceWidget({
    Key? key,
    required this.inv,
    this.onTap,
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
                child: inv.type == InvoiceTypes.pending
                    ? Image(
                        image: AssetImage("assets/images/pending.png"),
                        width: 24.0.sp,
                        height: 24.0.sp,
                      )
                    : Icon(
                        inv.type == InvoiceTypes.paid
                            ? Icons.check_rounded
                            : inv.type == InvoiceTypes.unPaid
                                ? Icons.close
                                : Icons.remove_red_eye,
                        size: 24.0.sp,
                        color: inv.type == InvoiceTypes.paid
                            ? Color(0xff58D241)
                            : inv.type == InvoiceTypes.unPaid
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
                  greyText(inv.id!, 12)
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              blackText(inv.price!, 16),
              SizedBox(height: 10),
              greyText(inv.time!, 12)
            ],
          )
        ],
      ),
    );
  }
}
