import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/create_invoice/tabs/invoice_tab.dart';

class InvoiceSubCreateInvoice extends StatelessWidget {
  InvoiceSubCreateInvoice({super.key});
  final AddInvoiceController _addInvoiceController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: blackText(
            _addInvoiceController.dataToEditInvoice != null
                ? "edit_invoice".tr
                : "create_invoice".tr,
            16),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CreateInvoiceTab(),
      ),
    );
  }
}
