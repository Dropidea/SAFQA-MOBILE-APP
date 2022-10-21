import 'package:flutter/material.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoice_tab.dart';

class QuickInvoiceTab extends StatefulWidget {
  const QuickInvoiceTab({super.key});

  @override
  State<QuickInvoiceTab> createState() => _QuickInvoiceTabState();
}

class _QuickInvoiceTabState extends State<QuickInvoiceTab> {
  @override
  Widget build(BuildContext context) {
    return InvoiceTab();
  }
}
