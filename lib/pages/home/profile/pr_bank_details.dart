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
      appBar: MyAppBar(title: "bank_details".tr),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(20),
        children: [
          blackText("bank_name".tr, 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: profileController.profileBusines!.bankName,
          ),
          const SizedBox(height: 20),
          blackText("bank_account_holder_name".tr, 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: profileController.profileBusines!.bankAccountName,
          ),
          const SizedBox(height: 20),
          blackText("bank_account".tr, 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: profileController.profileBusines!.accountNumber,
          ),
          const SizedBox(height: 20),
          blackText("iban".tr, 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            readOnly: true,
            initialValue: profileController.profileBusines!.iban,
          ),
          const SizedBox(height: 20),
          blackText("available_payment_methods".tr, 14),
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.title});
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
