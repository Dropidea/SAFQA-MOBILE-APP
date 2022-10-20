import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';

class PaymentLinkTab extends StatefulWidget {
  const PaymentLinkTab({super.key});

  @override
  State<PaymentLinkTab> createState() => _PaymentLinkTabState();
}

class _PaymentLinkTabState extends State<PaymentLinkTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: blackText("Payment link", 16),
      ),
    );
  }
}
