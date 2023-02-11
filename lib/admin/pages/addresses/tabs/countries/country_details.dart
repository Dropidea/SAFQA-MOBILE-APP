import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class CountryDetailsPage extends StatelessWidget {
  const CountryDetailsPage({super.key, required this.country});
  final Country country;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("country_details".tr, 17),
      ),
      body: ExpandableNotifier(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          primary: false,
          children: [
            ExpandablePanel(
              header: Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("country_details".tr, 15),
              ),
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DetailsItem(
                      title1: "name_ar".tr,
                      title2: "name_en".tr,
                      content1: country.nameAr,
                      content2: country.nameEn,
                    ),
                    DetailsItem(
                      title1: "code".tr,
                      title2: "currency".tr,
                      content1: country.code,
                      content2: country.currency,
                    ),
                    DetailsItem(
                      title1: "nationality_ar".tr,
                      title2: "nationality_en".tr,
                      content1: country.nationalityAr,
                      content2: country.nationalityEn,
                    ),
                    DetailsItem(
                      title1: "flag".tr,
                      title2: "active".tr,
                      content1: country.flag,
                      content2: country.countryActive == 0 ? "no".tr : "yes".tr,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget DetailsItem({
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
          width: 45.0.w,
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
