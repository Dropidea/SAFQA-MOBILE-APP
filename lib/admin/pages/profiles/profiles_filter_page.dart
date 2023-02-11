import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/profiles/controller/profiles_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:sizer/sizer.dart';

class ProfilesSearchFilterPage extends StatefulWidget {
  const ProfilesSearchFilterPage({super.key});

  @override
  State<ProfilesSearchFilterPage> createState() =>
      _CustomertSearchFilterPageState();
}

class _CustomertSearchFilterPageState extends State<ProfilesSearchFilterPage> {
  TextEditingController workEmailControler = TextEditingController();
  TextEditingController mobileControler = TextEditingController();
  TextEditingController companyNameControler = TextEditingController();
  ProfilesController _profilesController = Get.find();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xffFBFBFB),
        elevation: 0,
      ),
      backgroundColor: Color(0xffFBFBFB),
      body: ExpandableNotifier(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(
                    Icons.close,
                    size: 25.0.sp,
                  ),
                ),
                ClearFilterBTN(
                  onTap: () {
                    _profilesController.clearProfilesFilter();
                    Get.back();
                  },
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(
                keyboardType: TextInputType.text,
                initialValue: _profilesController.profilesFilter.companyName,
                onChanged: (p0) {
                  _profilesController.profilesFilter.companyName = p0;
                },
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("company_name".tr, 15),
              ),
            ),
            SizedBox(height: 30),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(
                keyboardType: TextInputType.emailAddress,
                initialValue: _profilesController.profilesFilter.workEmail,
                onChanged: (p0) {
                  _profilesController.profilesFilter.workEmail = p0;
                },
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("work_email".tr, 15),
              ),
            ),
            SizedBox(height: 30),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(
                initialValue: _profilesController.profilesFilter.mobileNumber,
                onChanged: (p0) {
                  _profilesController.profilesFilter.mobileNumber = p0;
                },
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("mobile_number".tr, 15),
              ),
            ),
            SizedBox(height: 30),

            ApplyFilterBTN(
              width: 0.7 * w,
              onTap: () {
                _profilesController.activeProdilesFilter();
                Get.back();
              },
            ),
            // Align(
            //   child: Container(
            //     margin: EdgeInsets.symmetric(vertical: 30),
            //     width: 0.7 * w,
            //     padding: EdgeInsets.all(15),
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(10),
            //         color: Color(0xff1BAFB2)),
            //     child: Center(child: whiteText("Apply", 15)),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Container buildpriceFixedTextfield() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Invoice value ...",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(
      int value, String text, int groupValue, void Function(int)? onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: GFRadio(
              activeBorderColor: Colors.transparent,
              inactiveBorderColor: Colors.transparent,
              inactiveBgColor: Colors.transparent,
              activeBgColor: Colors.transparent,
              radioColor: Color(0xff66B4D2),
              inactiveIcon: Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade300,
              ),
              size: GFSize.SMALL,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}
