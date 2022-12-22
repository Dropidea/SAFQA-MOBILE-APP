import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/product_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_create_page.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/product.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  ProductsController _productsController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Obx(() {
      if (_productsController.getProductsFlag.value) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
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
              textInputAction: TextInputAction.search,
              onchanged: (s) {
                _productsController.searchForProductsWithName(s!);
                setState(() {});
              },
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.to(() => ProductSearchFilterPage());
                },
                child: GetBuilder<ProductsController>(builder: (c) {
                  return Badge(
                    badgeColor: Color(0xff1BAFB2),
                    showBadge: _productsController.productFilter.filterActive,
                    position: BadgePosition.topEnd(top: 8, end: 8),
                    child: Image(
                      image: AssetImage("assets/images/filter.png"),
                      width: 18,
                      height: 18,
                    ),
                  );
                }),
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
                      width: 0.44 * w,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff2F6782).withOpacity(0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.add_rounded,
                              color: Color(0xff428994),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "create_product".tr,
                            style: TextStyle(
                              color: Color(0xff428994),
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 0.44 * w,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0xff8B8B8B).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            Icons.file_download_outlined,
                            color: Color(0xff8B8B8B),
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          "import_product".tr,
                          style: TextStyle(
                            color: Color(0xff8B8B8B),
                            fontSize: 13.0.sp,
                            fontWeight: FontWeight.w500,
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
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  listBTN(text: "select_all".tr, onTap: () {}),
                  SizedBox(width: 5),
                  listBTN(
                      text: "copy".tr,
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
                                textSize: 15.0,
                                func: () {},
                              ),
                              MyButton(
                                width: 0.3 * w,
                                heigt: 35.0.sp,
                                color: Color(0xff2D5571),
                                borderRadius: 10,
                                text: "Copy Link",
                                textColor: Colors.white,
                                textSize: 13.0,
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
                  listBTN(text: "print/pdf".tr, onTap: () {}),
                  // MyPopUpMenu(
                  //   menuList: [
                  //     PopupMenuItem(
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             EvaIcons.file,
                  //             color: Colors.grey.shade500,
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text("PDF"),
                  //         ],
                  //       ),
                  //     ),
                  //     PopupMenuItem(
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.print,
                  //             color: Colors.grey.shade500,
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text("Printer"),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  //   widget: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xffF9F9F9),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: blueText("print", 12),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 5),

                  listBTN(text: "Excel", onTap: () {}),
                  SizedBox(width: 5),
                  listBTN(text: "CSV", onTap: () {}),
                  SizedBox(width: 5),
                ],
              ),
            ),
            GetBuilder<ProductsController>(builder: (c) {
              return Expanded(
                  child: _productsController.productsToShow.isEmpty
                      ? Center(
                          child: greyText("nothing to show !!", 20),
                        )
                      : ListView.builder(
                          primary: false,
                          itemCount: _productsController.productsToShow.length,
                          itemBuilder: (context, index) {
                            return ProductWidget(
                              product:
                                  _productsController.productsToShow[index],
                              onTap: () {
                                Get.to(() => ProductDetailsPage(
                                      product: _productsController
                                          .productsToShow[index],
                                    ));
                              },
                            );
                          },
                        ));
            })
          ],
        );
      }
    });
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

Widget listBTN({String? text, void Function()? onTap, double? width}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: blueText(text!, 11),
      ),
    ),
  );
}
