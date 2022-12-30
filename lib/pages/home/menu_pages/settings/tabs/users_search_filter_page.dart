import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/manage_users_controller.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:sizer/sizer.dart';

class MUsersSearchFilterPage extends StatefulWidget {
  const MUsersSearchFilterPage({super.key});

  @override
  State<MUsersSearchFilterPage> createState() =>
      _CustomertSearchFilterPageState();
}

class _CustomertSearchFilterPageState extends State<MUsersSearchFilterPage> {
  TextEditingController customerPhoneNumberControler = TextEditingController();
  GlobalDataController globalDataController = Get.find();
  ManageUserController manageUserController = Get.find();
  Country? country;
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
                    manageUserController.clearManageUserFilter();
                    Get.back();
                  },
                ),
                // Text(
                //   "Clear",
                //   style: TextStyle(
                //     fontSize: 16.0.sp,
                //     color: Color(0xff00A7B3),
                //     decoration: TextDecoration.underline,
                //   ),
                // )
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
                initialValue: manageUserController.manageUserFilter.name ?? "",
                onChanged: (p0) {
                  manageUserController.manageUserFilter.name = p0;
                },
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child:
                    blackText("username".tr, 15, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: buildCustomNameTextfield(
                  onChanged: (p0) {
                    manageUserController.manageUserFilter.phoneNum = p0;
                  },
                  initialValue:
                      manageUserController.manageUserFilter.phoneNum ?? ""),
              // IntlPhoneField(
              //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
              //   dropdownIconPosition: IconPosition.trailing,
              //   keyboardType: TextInputType.number,
              //   decoration: InputDecoration(
              //     fillColor: Colors.white,
              //     filled: true,
              //     border: OutlineInputBorder(
              //         borderRadius: new BorderRadius.circular(10.0),
              //         borderSide: BorderSide.none),

              //   ),
              //   initialCountryCode: 'IN',

              //   onChanged: (phone) {},
              //   onCountryChanged: (value) {},
              //   controller: customerPhoneNumberControler,
              // ),

              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("mobile_number".tr, 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 30),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                child: Builder(builder: (context) {
                  List<Country> countries = globalDataController.countries;
                  List<String> ids = countries
                      .map<String>(
                        (e) => e.id.toString(),
                      )
                      .toSet()
                      .toList();
                  List<String> countryNames = countries
                      .map<String>(
                        (e) => e.nameEn.toString(),
                      )
                      .toSet()
                      .toList();

                  return CustomDropdown(
                    borderColor: Colors.grey.shade300,
                    backgroundColor: Colors.white,
                    width: w,
                    items: countryNames,
                    onchanged: (s) {
                      country = countries[countryNames.indexOf(s!)];
                      manageUserController.manageUserFilter.country = country;
                    },
                    selectedItem:
                        manageUserController.manageUserFilter.country != null
                            ? manageUserController
                                .manageUserFilter.country!.nameEn
                            : null,
                    hint: "choose".tr,
                  );
                }),
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("country".tr, 15, fontWeight: FontWeight.bold),
              ),
            ),

            ApplyFilterBTN(
              width: 0.7 * w,
              onTap: () {
                manageUserController.activeManageUserFilter();
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
