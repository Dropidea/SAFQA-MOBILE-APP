import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/pages/home/menu_pages/products/products_create_page.dart';
import 'package:sizer/sizer.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("Product Details", 17),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Get.to(() => ProductCreatePage(
                        product: product,
                      ));
                },
                child: Container(
                  width: w / 2.5,
                  height: 50,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Color(0xff58D241).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Icon(
                          EvaIcons.edit,
                          color: Color(0xff58D241),
                          size: 18.0.sp,
                        ),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Edit",
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          color: Color(0xff58D241),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: w / 2.5,
                height: 50,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Color(0xffE47E7B).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Icon(
                        EvaIcons.trash2,
                        color: Color(0xffE47E7B),
                        size: 18.0.sp,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Remove",
                      style: TextStyle(
                        fontSize: 14.0.sp,
                        color: Color(0xffE47E7B),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          Expanded(
            child: ExpandableNotifier(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                primary: false,
                children: [
                  ExpandablePanel(
                    header: Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 0.5),
                        ),
                      ),
                      child: blackText("Product Info", 15),
                    ),
                    controller: ExpandableController(initialExpanded: true),
                    collapsed: Container(),
                    theme: ExpandableThemeData(hasIcon: false),
                    expanded: Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          invoiceInfoMethod(
                              title1: "Product Name (En)",
                              content1: product.nameEn,
                              title2: "Product Name (Ar)",
                              content2: product.nameAr),
                          invoiceInfoMethod(
                              title1: "Category",
                              content1: product.category!.nameEn,
                              title2: "Remaining Quantity",
                              content2: product.quantity.toString()),
                          // invoiceInfoMethod(
                          //     title1: "Product Picture",
                          //     content1: "product_picture.png",
                          //     title2: "",
                          //     content2: ""),
                          invoiceInfoMethod(
                              title1: "Unit Price",
                              content1: "\$ ${product.price}",
                              title2: "",
                              content2: ""),
                          invoiceInfoMethod(
                              title1: "Is Active?",
                              content1: product.isActive == 1 ? "Yes" : "No",
                              title2: "Is Stockable?",
                              content2:
                                  product.isStockable == 1 ? "Yes" : "No"),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              blackText("Add this product in the store?", 13),
                              SizedBox(height: 5),
                              greyText("Yes", 13),
                            ],
                          ),
                          SizedBox(height: 10),
                          invoiceInfoMethod(
                              title1: "Is it shippable??",
                              content1:
                                  product.isShippingProduct == 1 ? "Yes" : "No",
                              title2: "",
                              content2: ""),
                          SizedBox(height: 10),
                          blackText("Product link", 14),
                          Text(
                            "Laborum aliquip ullamco aute nisi Lorem non do sunt et aute non minim.",
                            style: TextStyle(
                                fontSize: 14.0.sp,
                                decoration: TextDecoration.underline,
                                color: Color(0xff27b4be),
                                decorationColor: Color(0xff27b4be)),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                blackText("Discription (EN)", 13),
                                SizedBox(height: 5),
                                greyText(product.descriptionEn!, 13),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                blackText("Discription (AR)", 13),
                                SizedBox(height: 5),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: greyARText("شسيش", 13),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget invoiceInfoMethod({
    String? title1,
    String? content1,
    String? title2,
    String? content2,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 45.0.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title1", 13),
                SizedBox(height: 5),
                greyText("$content1", 13),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("$title2", 13),
                SizedBox(height: 5),
                greyText("$content2", 13),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
