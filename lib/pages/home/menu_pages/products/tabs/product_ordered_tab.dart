import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/order_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_ordered_search_filter_page.dart';
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
          hintText: "Search ...",
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
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              productBTN(text: "Copy", onTap: () {}),
              SizedBox(width: 5),
              productBTN(text: "Print", onTap: () {}),
              SizedBox(width: 5),
              productBTN(text: "PDF", onTap: () {}),
              SizedBox(width: 5),
              productBTN(text: "Excel", onTap: () {}),
              SizedBox(width: 5),
              productBTN(text: "CSV", onTap: () {}),
              SizedBox(width: 5),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
          primary: false,
          itemCount: 10,
          itemBuilder: (context, index) {
            return ProductWidget(
              active: index % 2 == 0,
              orderedFlag: true,
              orderedState: index % 2 == 0 ? "Delivered" : "Prepared",
              onTap: () {
                Get.to(() => OrderDetailsPage());
              },
            );
          },
        ))
      ],
    );
  }

  Widget productBTN({String? text, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
          color: const Color(0xffF9F9F9),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: blueText(text!, 12),
        ),
      ),
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
