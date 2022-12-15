import 'package:badges/badges.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/pages/home/menu_pages/products/order_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_ordered_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/product.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsOrderedTab extends StatelessWidget {
  const ProductsOrderedTab({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 60),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          hintText: "search".tr,
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.grey,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(() => ProductOrderedSearchFilterPage());
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
        Expanded(
            child: ListView.builder(
          primary: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ProductWidget(
              orderedFlag: true,
              orderedState: index % 2 != 0 ? "Delivered" : "Prepared",
              onTap: () {
                Get.to(() => OrderDetailsPage());
              },
              product: Product(
                nameEn: "test",
                isActive: index % 2,
                quantity: 10,
                price: 10,
              ),
            );
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
