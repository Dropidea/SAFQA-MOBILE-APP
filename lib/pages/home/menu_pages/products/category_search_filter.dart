import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CategoryFilterPage extends StatefulWidget {
  const CategoryFilterPage({super.key});

  @override
  State<CategoryFilterPage> createState() => _CategoryFilterPage();
}

class _CategoryFilterPage extends State<CategoryFilterPage> {
  int isActive = 0;

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
                Text(
                  "Clear",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Color(0xff00A7B3),
                    decoration: TextDecoration.underline,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildRadioButton(
                        0,
                        "All",
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Active",
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "Inactive",
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
                              },
                            )),
                  ],
                ),
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Is Active", 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ExpandablePanel(
              controller: ExpandableController(initialExpanded: true),
              collapsed: Container(),
              theme: ExpandableThemeData(hasIcon: false),
              expanded: Container(
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    SizedBox(height: 20),
                    SignUpTextField(
                      padding: EdgeInsets.all(0),
                      hintText: "Category Name (En / Ar)",
                    ),
                  ],
                ),
              ),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Category Name", 15),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                width: 0.7 * w,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1BAFB2)),
                child: Center(child: whiteText("Apply", 15)),
              ),
            ),
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

  Widget buildCustomerNameTextfield() {
    return Container(
      margin: EdgeInsets.only(top: 10),
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
          hintText: "Customer Name ...",
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
          GFRadio(
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
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}
