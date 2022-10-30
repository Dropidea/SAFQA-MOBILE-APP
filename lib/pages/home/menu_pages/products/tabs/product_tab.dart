import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/product_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_create_page.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/product.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

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
              Get.to(() => ProductSearchFilterPage());
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                //TODO:
              },
              child: GestureDetector(
                onTap: () {
                  Get.to(() => ProductCreatePage());
                },
                child: Container(
                  width: 0.45 * w,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0xff00A7B3).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Color(0xff00A7B3),
                      ),
                      Text(
                        "Create Product",
                        style: TextStyle(
                          color: Color(0xff00A7B3),
                          fontSize: 13.0.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                //TODO:
              },
              child: Container(
                width: 0.45 * w,
                height: 60,
                decoration: BoxDecoration(
                  color: Color(0xff8B8B8B).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.file_download_outlined,
                      color: Color(0xff8B8B8B),
                    ),
                    Text(
                      "Import Product",
                      style: TextStyle(
                        color: Color(0xff8B8B8B),
                        fontSize: 13.0.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              productBTN(
                  text: "Select All",
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        actionsPadding: EdgeInsets.only(bottom: 30),
                        titlePadding: EdgeInsets.all(0),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          MyButton(
                            width: 0.3 * w,
                            heigt: 35.0.sp,
                            color: Color(0xffF3F3F3),
                            borderRadius: 10,
                            textColor: Color(0xff2D5571),
                            text: "Open",
                            textSize: 15.0.sp,
                            func: () {},
                          ),
                          MyButton(
                            width: 0.3 * w,
                            heigt: 35.0.sp,
                            color: Color(0xff2D5571),
                            borderRadius: 10,
                            text: "Copy Link",
                            textColor: Colors.white,
                            textSize: 15.0.sp,
                            func: () {},
                          )
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                        title: _dialogeTitle(),
                        content: Container(
                          width: w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Color(0xffBBBBBB))),
                          child: TextFormField(
                            initialValue: "www.google.com",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(width: 5),
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
              onTap: () {
                Get.to(() => ProductDetailsPage());
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
