import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';

class QuickInvoiceTab extends StatefulWidget {
  const QuickInvoiceTab({super.key});

  @override
  State<QuickInvoiceTab> createState() => _QuickInvoiceTabState();
}

class _QuickInvoiceTabState extends State<QuickInvoiceTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: blackText("Quick invoice", 16),
      ),
    );
  }
}
