import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product_link.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateProductLink extends StatefulWidget {
  CreateProductLink({
    super.key,
  });

  @override
  State<CreateProductLink> createState() => _CreateProductLinkState();
}

class _CreateProductLinkState extends State<CreateProductLink> {
  TextEditingController linkENController = TextEditingController();
  TextEditingController linkARController = TextEditingController();
  TextEditingController terms = TextEditingController();
  ProductLink productLinkToCreate = ProductLink(isActive: 0);

  ProductsController _productsController = Get.find();
  int isActive = 0;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: blackText("create_link".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                blackText("link_name_en".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    productLinkToCreate.nameEn = s;
                  },
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                blackText("link_name_ar".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  onchanged: (s) {
                    productLinkToCreate.nameAr = s;
                  },
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 20),
                TextFormField(
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: "optional".tr,
                    fillColor: Color(0xffF8F8F8),
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(10.0),
                        borderSide: BorderSide.none),
                  ),
                  onChanged: (s) {
                    productLinkToCreate.termsAndConditions = s;
                  },
                ),
                SizedBox(height: 20),
                blackText("is_active".tr, 16),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              inactiveBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              value: 1,
                              groupValue: isActive,
                              onChanged: (value) => setState(() {
                                    isActive = value;

                                    productLinkToCreate.isActive = value;
                                  })),
                        ),
                        greyText("yes".tr, 16),
                      ],
                    ),
                    SizedBox(width: 30),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              inactiveBorderColor: Colors.transparent,
                              value: 0,
                              groupValue: isActive,
                              onChanged: (value) => setState(() {
                                    isActive = value;

                                    productLinkToCreate.isActive = value;
                                  })),
                        ),
                        greyText("no".tr, 16),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText("create_link".tr, 16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            productLinkToCreate.products =
                                _productsController.productsToCreateLinks
                                    .map(
                                      (e) => e.id!,
                                    )
                                    .toList();
                            logSuccess(productLinkToCreate.toJson());
                            await _productsController
                                .createProductLink(productLinkToCreate);
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 22.0.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
