import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:sizer/sizer.dart';

class CategoryDetailsPage extends StatelessWidget {
  CategoryDetailsPage({super.key, required this.productCategory});
  final ProductCategory productCategory;
  ProductsController productsController = Get.find();
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
        title: blackText("Category Details", 17),
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
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
                        fontSize: 12.0.sp,
                        color: Color(0xff58D241),
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.dialog(AlertDialog(
                    title: Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.red.shade700,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    ),
                    content: Text("Are You Sure?"),
                    actions: <Widget>[
                      TextButton(
                        child: Text("YES"),
                        onPressed: () {
                          Future(() => Get.back());
                          Future(() => Get.back());
                        },
                      ),
                      TextButton(
                        child: Text("NO"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  ));
                },
                child: Container(
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
                          fontSize: 12.0.sp,
                          color: Color(0xffE47E7B),
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
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
                  SizedBox(height: 20),
                  blackText("Category Name (En)", 15),
                  SizedBox(height: 5),
                  greyText(productCategory.nameEn!, 15),
                  SizedBox(height: 20),
                  blackText("Category Name (Ar)", 15),
                  SizedBox(height: 5),
                  greyText(productCategory.nameAr!, 15),
                  SizedBox(height: 20),
                  blackText("Is Active", 15),
                  SizedBox(height: 5),
                  greyText(productCategory.isActive == 1 ? "Yes" : "No", 15),
                  SizedBox(height: 20),
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
            width: 48.0.w,
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
