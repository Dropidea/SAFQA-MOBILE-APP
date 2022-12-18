import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/create_invoice/tabs/payment_link_tab.dart';

class InvoiceSubCreatePaymentLink extends StatelessWidget {
  InvoiceSubCreatePaymentLink({super.key, this.paymentLinkToEdit});
  final PaymentLink? paymentLinkToEdit;
  LocalsController localsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: blackText(
            paymentLinkToEdit != null
                ? "edit_payment_link".tr
                : "create_payment_link".tr,
            16),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CreatePaymentLinkTab(paymentLinkToEdit: paymentLinkToEdit),
      ),
    );
  }
}
