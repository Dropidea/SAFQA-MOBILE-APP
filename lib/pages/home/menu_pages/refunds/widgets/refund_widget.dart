import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/refunds/models/refund_model.dart';
import 'package:safqa/widgets/popup_menu.dart';

class RefundWidget extends StatefulWidget {
  RefundWidget({
    super.key,
    this.onTap,
    required this.refund,
  });
  final Refund refund;
  final void Function()? onTap;
  @override
  State<RefundWidget> createState() => _RefundWidgetState();
}

class _RefundWidgetState extends State<RefundWidget> {
  LocalsController _localsController = Get.put(LocalsController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: w,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 245, 245, 245),
            borderRadius: BorderRadius.circular(15),
          ),
          // height: 120,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              blackText(
                  "customer_name".tr +
                      ": " +
                      widget.refund.invoice!.customerName!,
                  14),
              SizedBox(height: 5),
              blackText(
                  "invoice_id".tr + ": #" + widget.refund.id!.toString(), 14),
              SizedBox(height: 5),
              blackText(
                  "invoice_id".tr +
                      ": #" +
                      widget.refund.invoice!.id!.toString(),
                  14),
              SizedBox(height: 5),
              widget.refund.status == "pending"
                  ? redText(widget.refund.status!, 13)
                  : greenText(widget.refund.status!, 13)
            ],
          ),
          // blackText(widget.refund., 15),
          // greyText("#1234123123", 14),
          // blueText("pending".tr, 14, underline: true),
        ),
        PositionedDirectional(
          top: 10,
          end: 0,
          child: MyPopUpMenu(
            menuList: [
              PopupMenuItem(
                onTap: widget.onTap,
                child: blackText("refund_details".tr, 13),
              ),
            ],
          ),
        )
      ],
    );
  }
}
