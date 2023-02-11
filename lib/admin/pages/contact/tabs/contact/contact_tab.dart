import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/wallpapered_BTN.dart';

class ContactTab extends StatefulWidget {
  ContactTab({super.key});

  @override
  State<ContactTab> createState() => _ContactTabState();
}

class _ContactTabState extends State<ContactTab> {
  final LocalsController _localsController = Get.put(LocalsController());
  ContactController contactController = Get.find();
  @override
  void initState() {
    contactController.getAllContactUsInfos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<ContactController>(builder: (c) {
      return c.getContactUsInfosFlag
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 80),
                  blackText("country".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.country,
                    onchanged: (s) {
                      c.contactUsInfo!.country = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("city".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.city,
                    onchanged: (s) {
                      c.contactUsInfo!.city = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("area".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.area,
                    onchanged: (s) {
                      c.contactUsInfo!.area = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("block".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.block,
                    onchanged: (s) {
                      c.contactUsInfo!.block = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("avenue".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.avenue,
                    onchanged: (s) {
                      c.contactUsInfo!.avenue = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("street".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.street,
                    onchanged: (s) {
                      c.contactUsInfo!.street = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("sales_support_officer_info".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.salesSupportOfficerInfo,
                    onchanged: (s) {
                      c.contactUsInfo!.salesSupportOfficerInfo = s;
                    },
                  ),
                  SizedBox(height: 20),
                  blackText("support_email".tr, 13),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    initialValue: c.contactUsInfo!.supportEmail,
                    onchanged: (s) {
                      c.contactUsInfo!.supportEmail = s;
                    },
                    keyBoardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20),
                  WallpepredBTN(
                    haveWallpaper: false,
                    text: "save".tr,
                    width: w / 1.5,
                    onTap: () async {
                      await contactController
                          .editContactUsInfo(c.contactUsInfo!);
                    },
                  ),
                  SizedBox(height: 20),
                ],
              ),
            );
    });
  }
}
