import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/addresses_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_address_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:sizer/sizer.dart';

class AddressDetailsPage extends StatelessWidget {
  AddressDetailsPage({super.key, required this.address});
  final Address address;
  AddressesController addressessController = Get.find();
  LocalsController _localsController = Get.put(LocalsController());
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "address_details".tr),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => AddAddressPage(
                        addressToEdit: address,
                      ));
                },
                child: Container(
                  width: w / 2.5,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff58D241).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          EvaIcons.edit,
                          color: Color(0xff58D241),
                          size: 18.0.sp,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "edit".tr,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Color(0xff58D241),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  MyDialogs.showDeleteDialoge(
                      onProceed: () {
                        Get.back();
                        addressessController.deleteAddress(address);
                      },
                      message: "are_you_sure".tr);
                },
                child: Container(
                  width: w / 2.5,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xffE47E7B).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          EvaIcons.trash2,
                          color: Color(0xffE47E7B),
                          size: 18.0.sp,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "remove".tr,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Color(0xffE47E7B),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Expanded(
            child: ExpandableNotifier(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                primary: false,
                children: [
                  invoiceInfoMethod(
                    title1: "address_type".tr,
                    content1: _localsController.currenetLocale == 0
                        ? address.addressType!.nameEn
                        : address.addressType!.nameAr,
                    title2: "city".tr,
                    content2: _localsController.currenetLocale == 0
                        ? address.city!.nameEn
                        : address.city!.nameAr,
                  ),
                  invoiceInfoMethod(
                    title1: "area".tr,
                    content1: _localsController.currenetLocale == 0
                        ? address.area!.nameEn
                        : address.area!.nameAr,
                    title2: "block".tr,
                    content2: address.block ?? "not_available".tr,
                  ),
                  invoiceInfoMethod(
                    title1: "avenue".tr,
                    content1: address.avenue,
                    title2: "house/bldg_no".tr,
                    content2: address.bldgNo ?? "not_available".tr,
                  ),
                  invoiceInfoMethod(
                    title1: "street".tr,
                    content1: address.street,
                    title2: "floor".tr,
                    content2: address.floor ?? "not_available".tr,
                  ),
                  invoiceInfoMethod(
                    title1: "appartment".tr,
                    content1: address.appartment ?? "not_available".tr,
                    title2: "instructions".tr,
                    content2: address.instructions ?? "not_available".tr,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget invoiceInfoMethod({
    String? title1,
    String? content1,
    String? title2,
    String? content2,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 50.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title1", 13),
                SizedBox(height: 5),
                greyText("$content1", 13),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title2", 13),
                SizedBox(height: 5),
                greyText("$content2", 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
