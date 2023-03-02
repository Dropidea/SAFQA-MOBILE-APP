import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/product_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_store_search_filter_page.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import "package:sizer/sizer.dart";

class MyStoreTab extends StatelessWidget {
  MyStoreTab({super.key});
  final LocalsController _localsController = Get.put(LocalsController());
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<ProductsController>(builder: (c) {
      return Column(
        children: [
          SizedBox(height: 60),
          SignUpTextField(
            padding: EdgeInsets.all(0),
            hintText: "search".tr,
            onchanged: (s) {
              c.searchForProductsStoreWithName(s!);
            },
            prefixIcon: Icon(
              Icons.search_outlined,
              color: Colors.grey,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
                Get.to(() => ProductStoreSearchFilterPage());
              },
              child: Badge(
                badgeColor: Color(0xff1BAFB2),
                showBadge: c.productStoreFilter.filterActive,
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
          // SizedBox(
          //   height: 40,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       MyStoreBTN(text: "All", onTap: () {}, selected: true),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "Electronic Devices", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          Expanded(
              child: c.productsStoreToShow.isEmpty
                  ? Center(
                      child: greyText("nothing_to_show".tr, 20),
                    )
                  : GridView.builder(
                      primary: false,
                      itemCount: c.productsStoreToShow.length,
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
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xffF5F5F5),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: c.productsStoreToShow[index]
                                                  .productImage !=
                                              null
                                          ? Image(
                                              image: NetworkImage(c
                                                  .productsStoreToShow[index]
                                                  .productImage),
                                              fit: BoxFit.contain,
                                              width: 65.0.sp,
                                              height: 65.0.sp,
                                              loadingBuilder:
                                                  (BuildContext context,
                                                      Widget child,
                                                      ImageChunkEvent?
                                                          loadingProgress) {
                                                if (loadingProgress == null)
                                                  return child;
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                    value: loadingProgress
                                                                .expectedTotalBytes !=
                                                            null
                                                        ? loadingProgress
                                                                .cumulativeBytesLoaded /
                                                            loadingProgress
                                                                .expectedTotalBytes!
                                                        : null,
                                                  ),
                                                );
                                              },
                                            )
                                          : Icon(
                                              Icons.photo_rounded,
                                              size: 60.0.sp,
                                              color: Colors.grey.shade400,
                                            ),
                                    ),
                                  ),
                                  PositionedDirectional(
                                    top: 0,
                                    end: 0,
                                    child: MyPopUpMenu(
                                      menuList: [
                                        PopupMenuItem(
                                          child: blackText(
                                              "product_details".tr, 11),
                                          onTap: () {
                                            Future(() => Get.to(() =>
                                                ProductDetailsPage(
                                                    product:
                                                        c.productsStoreToShow[
                                                            index])));
                                          },
                                        ),
                                        PopupMenuItem(
                                          child: blackText(
                                              "remove_from_store".tr, 11),
                                          onTap: () {
                                            Future(() =>
                                                MyDialogs.showDeleteDialoge(
                                                    onProceed: () {
                                                      Get.back();
                                                      c
                                                          .productsStoreToShow[
                                                              index]
                                                          .inStore = 0;
                                                      c.removeFromStore(
                                                          c.productsStoreToShow[
                                                              index]);
                                                    },
                                                    message:
                                                        "Remove From Store?"));
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            blackText(
                                _localsController.currenetLocale == 0
                                    ? c.productsStoreToShow[index].nameEn!
                                    : c.productsStoreToShow[index].nameAr!,
                                14),
                            blueText(
                                "\$ ${c.productsStoreToShow[index].price}", 13)
                          ],
                        );
                      },
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                    ))
        ],
      );
    });
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
