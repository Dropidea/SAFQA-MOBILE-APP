import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/controller/profile_controller.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class ProfileBankDetailsPage extends StatelessWidget {
  ProfileBankDetailsPage({super.key});
  ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WhiteAppBar(title: "Bank Details"),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: [
          blackText("Bank Name", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: "Abu Dhabi Islamic Bank(ADIB)",
          ),
          const SizedBox(height: 20),
          blackText("Bank Account Holder Name", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: "lafi s h m almutairi",
          ),
          const SizedBox(height: 20),
          blackText("Bank Account", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: "28633471",
          ),
          const SizedBox(height: 20),
          blackText("IBAN", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: "AE140600000000024855441",
          ),
          const SizedBox(height: 20),
          blackText("Available payment methods", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: "Debit/Credit Cards",
          ),
        ],
      ),
    );
  }
}

class WhiteAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WhiteAppBar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      title: blackText(title, 16),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.white,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
