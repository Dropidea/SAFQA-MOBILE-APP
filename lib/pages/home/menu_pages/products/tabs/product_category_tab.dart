import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/category_details.dart';
import 'package:safqa/pages/home/menu_pages/products/category_search_filter.dart';
import 'package:safqa/pages/home/menu_pages/products/create_category.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsCategoryTab extends StatefulWidget {
  const ProductsCategoryTab({super.key});

  @override
  State<ProductsCategoryTab> createState() => _ProductsCategoryTabState();
}

class _ProductsCategoryTabState extends State<ProductsCategoryTab> {
  List<bool> isToggled = [true, false, true];
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
              Get.to(() => CategoryFilterPage());
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
          child: Row(
            // scrollDirection: Axis.horizontal,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              listBTN(text: "Copy", onTap: () {}, width: w / 4.5),
              MyPopUpMenu(
                menuList: [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          EvaIcons.file,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 10),
                        Text("PDF"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.print,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Printer"),
                      ],
                    ),
                  ),
                ],
                widget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: blueText("print", 12),
                  ),
                ),
              ),
              listBTN(text: "Excel", onTap: () {}, width: w / 4.5),
              listBTN(text: "CSV", onTap: () {}, width: w / 4.5),
            ],
          ),
        ),
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Get.to(() => CreateCategoryPage());
          },
          child: DottedBorder(
            padding: EdgeInsets.all(0),
            customPath: (size) {
              return Path()
                ..moveTo(10, 0)
                ..lineTo(size.width - 10, 0)
                ..arcToPoint(Offset(size.width, 10),
                    radius: Radius.circular(10))
                ..lineTo(size.width, size.height - 10)
                ..arcToPoint(Offset(size.width - 10, size.height),
                    radius: Radius.circular(10))
                ..lineTo(10, size.height)
                ..arcToPoint(Offset(0, size.height - 10),
                    radius: Radius.circular(10))
                ..lineTo(0, 10)
                ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
            },
            color: Color(0xff2F6782).withOpacity(0.4),
            strokeWidth: 1,
            dashPattern: [10, 5],
            child: Container(
              width: w,
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xff2F6782).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Icon(
                      Icons.add_rounded,
                      color: Color(0xff2F6782),
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Create a new one",
                    style: TextStyle(
                      color: Color(0xff2F6782),
                      fontSize: 13.0.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
            child: ListView.separated(
          primary: false,
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(() => CategoryDetailsPage());
              },
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 10),
                padding: EdgeInsets.all(20),
                width: w,
                height: 110,
                decoration: BoxDecoration(
                  color: Color(0xffF8F8F8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        blackText("Electronic Devices", 15),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              isToggled[index] ? "Active" : "Inactive",
                              style: TextStyle(
                                color: isToggled[index]
                                    ? Color(0xff1BAFB2)
                                    : Colors.grey,
                                fontSize: 13.0.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(width: 10),
                            FlutterSwitch(
                              height: 25.0,
                              width: 50.0,
                              padding: 3.0,
                              toggleSize: 25.0,
                              borderRadius: 20.0,
                              activeColor: Color(0xff1BAFB2),
                              value: isToggled[index],
                              onToggle: (value) {
                                logSuccess(value);
                                setState(() {
                                  isToggled[index] = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    greyText("اجهزه الكترونيه", 15),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20);
          },
        ))
      ],
    );
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            width: 55.0.sp,
            height: 70.0.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/logo/logo.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 25,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}
