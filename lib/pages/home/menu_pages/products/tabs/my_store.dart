import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class MyStoreTab extends StatelessWidget {
  const MyStoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 60),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          hintText: "Search ...",
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.grey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Badge(
              badgeColor: Color(0xff1BAFB2),
              showBadge: true,
              position: BadgePosition.topEnd(top: 8, end: 8),
              child: Image(
                image: AssetImage("assets/images/filter.png"),
                width: 18,
                height: 18,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              MyStoreBTN(text: "All", onTap: () {}, selected: true),
              SizedBox(width: 5),
              MyStoreBTN(text: "Electronic Devices", onTap: () {}),
              SizedBox(width: 5),
              MyStoreBTN(text: "lorem ipsum", onTap: () {}),
              SizedBox(width: 5),
              MyStoreBTN(text: "lorem ipsum", onTap: () {}),
              SizedBox(width: 5),
              MyStoreBTN(text: "lorem ipsum", onTap: () {}),
              SizedBox(width: 5),
              MyStoreBTN(text: "lorem ipsum", onTap: () {}),
              SizedBox(width: 5),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
            child: GridView.builder(
          primary: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 0.3 * w,
                  decoration: BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Stack(
                    children: [
                      Center(
                        child: Icon(
                          Icons.photo_rounded,
                          size: 60.0.sp,
                          color: Colors.grey.shade400,
                        ),
                      ),
                      PositionedDirectional(
                        top: 0,
                        end: 0,
                        child: MyPopUpMenu(
                          menuList: [
                            PopupMenuItem(
                              child: blackText("Product details", 11),
                            ),
                            PopupMenuItem(
                              child: blackText("Remove from the store", 11),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                blackText("Headphones", 14),
                blueText("\$ 150", 13)
              ],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        ))
      ],
    );
  }

  Widget MyStoreBTN(
      {String? text, void Function()? onTap, bool selected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            borderRadius: BorderRadius.circular(5),
            border: selected ? Border.all(color: Color(0xff2F6782)) : null),
        child: Center(
          child: selected ? blueText(text!, 12) : greyText(text!, 12),
        ),
      ),
    );
  }
}
