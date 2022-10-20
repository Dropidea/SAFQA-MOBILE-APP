import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/create_invoice/tabs/invoice_tab.dart';

class InvoiceSubCreateInvoice extends StatelessWidget {
  const InvoiceSubCreateInvoice({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 100,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: blackText("Create Invoice", 16),

        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: CreateInvoiceTab(),
      ),
    );
  }
}
