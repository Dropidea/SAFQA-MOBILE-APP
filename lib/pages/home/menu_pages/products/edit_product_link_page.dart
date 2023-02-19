import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/widgets/product.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class EditProductLink extends StatefulWidget {
  EditProductLink({
    super.key,
    required this.payLinkId,
  });
  final int payLinkId;
  @override
  State<EditProductLink> createState() => _EditProductLinkState();
}

class _EditProductLinkState extends State<EditProductLink> {
  TextEditingController linkENController = TextEditingController();
  TextEditingController linkARController = TextEditingController();
  TextEditingController terms = TextEditingController();

  ProductsController _productsController = Get.find();
  List<Product> productsToEdit = [];
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _productsController.getProductLink(widget.payLinkId).then((value) {
      if (value)
        productsToEdit.addAll(_productsController.productsToCreateLinks);
    });

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
          title: blackText("edit_link".tr, 16),

          centerTitle: true,
        ),
        body: GetBuilder<ProductsController>(builder: (c) {
          return c.getProductsLinksFlag
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: formKey,
                    child: ListView(
                      primary: false,
                      children: [
                        blackText("link_name_en".tr, 16),
                        SignUpTextField(
                          padding: EdgeInsets.all(0),
                          initialValue: c.productLinkToEdit!.nameEn,
                          onchanged: (s) {
                            c.productLinkToEdit!.nameEn = s;
                          },
                          validator: (s) {
                            if (s!.isEmpty) return "Can't be empty";
                          },
                        ),
                        SizedBox(height: 20),
                        blackText("link_name_ar".tr, 16),
                        SignUpTextField(
                          padding: EdgeInsets.all(0),
                          initialValue: c.productLinkToEdit!.nameAr,
                          onchanged: (s) {
                            c.productLinkToEdit!.nameAr = s;
                          },
                          validator: (s) {
                            if (s!.isEmpty) return "Can't be empty";
                          },
                        ),
                        SizedBox(height: 20),
                        TextFormField(
                          maxLines: 3,
                          initialValue: c.productLinkToEdit!.termsAndConditions,
                          decoration: InputDecoration(
                            hintText: "optional".tr,
                            fillColor: Color(0xffF8F8F8),
                            filled: true,
                            border: OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(10.0),
                                borderSide: BorderSide.none),
                          ),
                          onChanged: (s) {
                            c.productLinkToEdit!.termsAndConditions = s;
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
                                      groupValue: c.productLinkToEdit!.isActive,
                                      onChanged: (value) => setState(() {
                                            c.productLinkToEdit!.isActive =
                                                value;
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
                                      groupValue: c.productLinkToEdit!.isActive,
                                      onChanged: (value) => setState(() {
                                            c.productLinkToEdit!.isActive =
                                                value;
                                          })),
                                ),
                                greyText("no".tr, 16),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        blackText("products".tr, 16),
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: c.productsToCreateLinks.length,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemBuilder: (context, index) => ProductWidget(
                            product: c.productsToCreateLinks[index],
                            checkedFlag: productsToEdit
                                .contains(c.productsToCreateLinks[index]),
                            onCheckChanged: (p0) {
                              if (p0) {
                                productsToEdit
                                    .add(c.productsToCreateLinks[index]);
                              } else {
                                productsToEdit
                                    .remove(c.productsToCreateLinks[index]);
                              }
                              logSuccess(productsToEdit.length);
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              blackText("edit_link".tr, 16),
                              SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  if (formKey.currentState!.validate()) {
                                    c.productLinkToEdit!.products =
                                        productsToEdit
                                            .map(
                                              (e) => e.id!,
                                            )
                                            .toList();
                                    logSuccess(c.productLinkToEdit!.toJson());
                                    await _productsController
                                        .editProductLink(c.productLinkToEdit!);
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
                );
        }));
  }
}
