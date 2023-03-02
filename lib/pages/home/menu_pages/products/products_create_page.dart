import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/create_category.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductCreatePage extends StatefulWidget {
  const ProductCreatePage({super.key, this.product});
  final Product? product;
  @override
  State<ProductCreatePage> createState() => _ProductCreatePageState();
}

class _ProductCreatePageState extends State<ProductCreatePage> {
  // InvoicesController invoiceController = Get.put(InvoicesController());
  AddInvoiceController addInvoiceController = Get.find();
  TextEditingController productNameENController = TextEditingController();
  TextEditingController productNameARController = TextEditingController();
  TextEditingController remainingQuantitiyController = TextEditingController();
  TextEditingController unitPriceController = TextEditingController();
  TextEditingController discriptionENController = TextEditingController();
  TextEditingController discriptionARController = TextEditingController();
  LocalsController localsController = Get.put(LocalsController());
  String selectedCategoryId = "-1";
  String selectedCategory = "";
  String selectedCurrencyId = "1";
  String? width = "";
  String? height = "";
  String? weight = "";
  String? length = "";
  bool engFlag = false;
  @override
  void initState() {
    super.initState();
    // logSuccess(widget.product!.toJson());
    engFlag = localsController.currenetLocale == 0;
    if (widget.product != null) {
      productNameENController.text = widget.product!.nameEn!;
      productNameARController.text = widget.product!.nameAr!;
      selectedCategoryId = widget.product!.currencyId!;
      if (widget.product!.productImage != null) {
        fileName = widget.product!.productImage.toString().substring(
            widget.product!.productImage.toString().lastIndexOf("/") + 1);
        downloadFile(widget.product!.productImage, fileName)
            .then((value) => logSuccess(value));
      }
      remainingQuantitiyController.text = widget.product!.quantity!.toString();
      unitPriceController.text = widget.product!.price!.toString();
      selectedCategory = engFlag
          ? widget.product!.category!.nameEn!
          : widget.product!.category!.nameAr!;
      selectedCategoryId = widget.product!.categoryId!.toString();
      discriptionARController.text = widget.product!.descriptionAr!;
      discriptionENController.text = widget.product!.descriptionEn!;
      isActiveVal = widget.product!.isActive!;
      addToStoreVal = widget.product!.inStore!;
      isStockableVal = widget.product!.isStockable!;
      isShippableVal = widget.product!.isShippingProduct!;
      width = widget.product!.width;
      weight = widget.product!.weight;
      height = widget.product!.height;
      length = widget.product!.length;
      //  addToStoreVal = widget.product!.is!;
    }
  }

  File? file = null;
  ProductsController _productsController = Get.find();
  int isActiveVal = 1;
  int isStockableVal = 1;
  int isShippableVal = 1;
  int addToStoreVal = 1;
  SignUpController _signUpController = Get.find();
  String fileName = "";
  FocusNode d = new FocusNode();
  FocusNode d2 = new FocusNode();

  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: blackText(
              widget.product == null ? "create_product".tr : "edit_product".tr,
              16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         blackText("Invoice ID", 14),
                  //         const SizedBox(height: 5),
                  //         greyText("2659986 / 2022000048", 12),
                  //       ],
                  //     ),
                  //     Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         blackText("Invoice Date", 14),
                  //         const SizedBox(height: 5),
                  //         greyText(
                  //             DateFormat('dd-MMM-y').format(DateTime.now()), 12),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  blackText("product_name_en".tr, 15),
                  SignUpTextField(
                    focusNode: d,
                    padding: EdgeInsets.all(0),
                    fillColor: Color(0xffF8F8F8),
                    controller: productNameENController,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  blackText("product_name_ar".tr, 15),
                  SignUpTextField(
                    focusNode: d2,
                    padding: EdgeInsets.all(0),
                    fillColor: Color(0xffF8F8F8),
                    controller: productNameARController,
                    validator: (s) {
                      if (s!.isEmpty) return "Can't be empty";
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText("remaining_quantity".tr, 14),
                          SizedBox(
                            width: 0.4 * w,
                            child: SignUpTextField(
                              controller: remainingQuantitiyController,
                              keyBoardType: TextInputType.number,
                              padding: EdgeInsets.all(0),
                              fillColor: Color(0xffF8F8F8),
                              hintText: "1",
                              validator: (s) {
                                if (s!.isEmpty) return "Can't be empty";
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              blackText("product_picture".tr, 14),
                              fileName != ""
                                  ? GestureDetector(
                                      onTap: () {
                                        file = null;
                                        fileName = "";
                                        setState(() {});
                                      },
                                      child: greyText("clear".tr, 12))
                                  : Container(),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              FilePickerResult? result =
                                  await FilePicker.platform.pickFiles(
                                type: FileType.image,
                              );
                              if (result != null) {
                                file = File(result.files.single.path!);
                                fileName =
                                    result.files.single.path!.split("/").last;

                                setState(() {});
                              } else {
                                // User canceled the picker
                              }
                            },
                            child: DottedBorder(
                              customPath: (size) {
                                return Path()
                                  ..moveTo(10, 0)
                                  ..lineTo(size.width - 10, 0)
                                  ..arcToPoint(Offset(size.width, 10),
                                      radius: Radius.circular(10))
                                  ..lineTo(size.width, size.height - 10)
                                  ..arcToPoint(
                                      Offset(size.width - 10, size.height),
                                      radius: Radius.circular(10))
                                  ..lineTo(10, size.height)
                                  ..arcToPoint(Offset(0, size.height - 10),
                                      radius: Radius.circular(10))
                                  ..lineTo(0, 10)
                                  ..arcToPoint(Offset(10, 0),
                                      radius: Radius.circular(10));
                              },
                              color: Color(0xff00A7B3),
                              strokeWidth: 1,
                              dashPattern: [10, 5],
                              child: Container(
                                width: 0.45 * w,
                                height: 50,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Color(0xff00A7B3).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Center(
                                  child: Text(
                                    fileName == "" ? "choose".tr : fileName,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Color(0xff00A7B3),
                                      fontSize: 13.0.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText("unit_price".tr, 14),
                          SizedBox(
                            width: 0.3 * w,
                            child: SignUpTextField(
                              controller: unitPriceController,
                              keyBoardType: TextInputType.number,
                              padding: EdgeInsets.all(0),
                              fillColor: Color(0xffF8F8F8),
                              hintText: "0",
                              validator: (s) {
                                if (s!.isEmpty) return "Can't be empty";
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText("currency".tr, 14),
                          Obx(
                            () {
                              List countries =
                                  _signUpController.globalData['country'];
                              List<String> ids = countries
                                  .map<String>(
                                    (e) => e['id'].toString(),
                                  )
                                  .toSet()
                                  .toList();
                              List<String> countriesCurrencies = countries
                                  .map<String>(
                                    (e) => e['currency'].toString(),
                                  )
                                  .toSet()
                                  .toList();
                              addInvoiceController
                                  .selectCurrencyDrop(countriesCurrencies[0]);

                              return CustomDropdown(
                                items: countriesCurrencies,
                                selectedItem:
                                    addInvoiceController.selectedCurrencyDrop,
                                width: 0.55 * w,
                                onchanged: (s) {
                                  addInvoiceController.selectCurrencyDrop(s);
                                  selectedCurrencyId =
                                      ids[countriesCurrencies.indexOf(s!)];
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  blackText("product_category".tr, 16),
                  GetBuilder<ProductsController>(builder: (c) {
                    return DropdownButtonFormField<String>(
                      validator: (value) {
                        if (value == null) return "Category is required";
                        return null;
                      },
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: c.productCategories
                          .map((e) => DropdownMenuItem<String>(
                                value: engFlag ? e.nameEn : e.nameAr,
                                child: Text(engFlag ? e.nameEn! : e.nameAr!),
                              ))
                          .toSet()
                          .toList(),
                      value: selectedCategory == "" ? null : selectedCategory,
                      hint: Text("categories".tr),
                      onChanged: (value) {
                        selectedCategory = value!;
                        int catind = (_productsController.productCategories
                            .indexWhere((element) =>
                                element.nameEn == selectedCategory ||
                                element.nameAr == selectedCategory));
                        selectedCategoryId = _productsController
                            .productCategories[catind].id
                            .toString();
                        logError(selectedCategoryId);
                      },
                    );
                  }),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: MyButton(
                      width: 0.6 * w,
                      heigt: 50,
                      color: Color(0xff00A7B3),
                      borderRadius: 10,
                      text: "create_product_category".tr,
                      textSize: 13,
                      textColor: Colors.white,
                      func: () {
                        Get.to(() => CreateCategoryPage());
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  blackText("description_en".tr, 16),
                  Container(
                    width: w,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: discriptionENController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      validator: (s) {
                        if (s!.isEmpty) return "Can't be empty";
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  blackText("description_ar".tr, 16),
                  Container(
                    width: w,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextFormField(
                      controller: discriptionARController,
                      textAlign: TextAlign.right,
                      maxLines: 3,
                      decoration: InputDecoration(
                        fillColor: Color(0xffF8F8F8),
                        filled: true,
                        border: OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                            borderSide: BorderSide.none),
                      ),
                      validator: (s) {
                        if (s!.isEmpty) return "Can't be empty";
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
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
                                  groupValue: isActiveVal,
                                  onChanged: (value) => setState(() {
                                        isActiveVal = value;
                                      }))),
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
                                  groupValue: isActiveVal,
                                  onChanged: (value) => setState(() {
                                        isActiveVal = value;
                                      }))),
                          greyText("no".tr, 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  blackText("is_stockable".tr, 16),
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
                                  groupValue: isStockableVal,
                                  onChanged: (value) => setState(() {
                                        isStockableVal = value;
                                      }))),
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
                                  groupValue: isStockableVal,
                                  onChanged: (value) => setState(() {
                                        isStockableVal = value;
                                      }))),
                          greyText("no".tr, 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  blackText("add_to_store".tr, 16),
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
                                  groupValue: addToStoreVal,
                                  onChanged: (value) => setState(() {
                                        addToStoreVal = value;
                                      }))),
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
                                  groupValue: addToStoreVal,
                                  onChanged: (value) => setState(() {
                                        addToStoreVal = value;
                                      }))),
                          greyText("no".tr, 16),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  blackText("is_shippable".tr, 16),
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
                                  groupValue: isShippableVal,
                                  onChanged: (value) => setState(() {
                                        isShippableVal = value;
                                      }))),
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
                                  groupValue: isShippableVal,
                                  onChanged: (value) => setState(() {
                                        isShippableVal = value;
                                      }))),
                          greyText("no".tr, 16),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  isShippableVal == 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SignUpTextField(
                                  validator: (s) {
                                    if (s!.isEmpty) return "required".tr;
                                    return null;
                                  },
                                  hintText: "width".tr,
                                  padding: EdgeInsets.all(0),
                                  width: w / 2 - 30,
                                  initialValue: width,
                                  onchanged: (s) {
                                    width = s!;
                                  },
                                ),
                                SignUpTextField(
                                  validator: (s) {
                                    if (s!.isEmpty) return "required".tr;
                                    return null;
                                  },
                                  hintText: "length".tr,
                                  padding: EdgeInsets.all(0),
                                  width: w / 2 - 30,
                                  initialValue: length,
                                  onchanged: (s) {
                                    length = s!;
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SignUpTextField(
                                  validator: (s) {
                                    if (s!.isEmpty) return "required".tr;
                                    return null;
                                  },
                                  hintText: "height".tr,
                                  padding: EdgeInsets.all(0),
                                  width: w / 2 - 30,
                                  initialValue: height,
                                  onchanged: (s) {
                                    height = s!;
                                  },
                                ),
                                SignUpTextField(
                                  validator: (s) {
                                    if (s!.isEmpty) return "required".tr;
                                    return null;
                                  },
                                  hintText: "weight".tr,
                                  padding: EdgeInsets.all(0),
                                  width: w / 2 - 30,
                                  initialValue: weight,
                                  onchanged: (s) {
                                    weight = s!;
                                  },
                                )
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  SizedBox(height: 20),
                  CircularGoBTN(
                    text: widget.product == null
                        ? "create_product".tr
                        : "edit_product".tr,
                    onTap: () async {
                      if (widget.product == null) {
                        if (formKey.currentState!.validate()) {
                          Product product = Product(
                            nameEn: productNameENController.text,
                            nameAr: productNameARController.text,
                            quantity:
                                int.parse(remainingQuantitiyController.text),
                            productImage: file,
                            price: int.parse(unitPriceController.text),
                            categoryId: int.parse(selectedCategoryId),
                            descriptionAr: discriptionARController.text,
                            descriptionEn: discriptionENController.text,
                            currencyId: selectedCurrencyId,
                            isActive: isActiveVal,
                            isStockable: isStockableVal,
                            isShippingProduct: isShippableVal,
                            width: isShippableVal == 1 ? width : null,
                            height: isShippableVal == 1 ? height : null,
                            length: isShippableVal == 1 ? length : null,
                            weight: isShippableVal == 1 ? weight : null,
                            inStore: addToStoreVal,
                          );
                          FocusScope.of(context).unfocus();

                          bool? c =
                              await _productsController.createProduct(product);
                          if (c != null && c) {
                            productNameENController.text = "";
                            productNameARController.text = "";
                            remainingQuantitiyController.text = "";
                            file = null;
                            unitPriceController.text = "";
                            discriptionARController.text = "";
                            discriptionENController.text = "";
                            width = "";
                            height = "";
                            weight = "";
                            length = "";
                          }
                        }
                      } else {
                        if (formKey.currentState!.validate()) {
                          Product product = Product(
                              id: widget.product!.id,
                              nameEn: productNameENController.text,
                              nameAr: productNameARController.text,
                              quantity:
                                  int.parse(remainingQuantitiyController.text),
                              productImage: file,
                              price: int.parse(unitPriceController.text),
                              categoryId: int.parse(selectedCategoryId),
                              descriptionAr: discriptionARController.text,
                              descriptionEn: discriptionENController.text,
                              currencyId: selectedCategoryId,
                              isActive: isActiveVal,
                              isStockable: isStockableVal,
                              isShippingProduct: isShippableVal,
                              width: isShippableVal == 1 ? width : null,
                              height: isShippableVal == 1 ? height : null,
                              length: isShippableVal == 1 ? length : null,
                              weight: isShippableVal == 1 ? weight : null,
                              inStore: addToStoreVal);
                          FocusScope.of(context).unfocus();

                          bool? c =
                              await _productsController.editProduct(product);
                          if (c != null && c) {
                            productNameENController.text = "";
                            productNameARController.text = "";
                            remainingQuantitiyController.text = "";
                            file = null;
                            unitPriceController.text = "";
                            discriptionARController.text = "";
                            discriptionENController.text = "";
                            width = "";
                            height = "";
                            weight = "";
                            length = "";
                          }
                        }
                      }
                      // if (widget.product == null) {
                      //   if (formKey.currentState!.validate()) {
                      //     Product product = Product(
                      //       nameEn: productNameENController.text,
                      //       nameAr: productNameARController.text,
                      //       quantity:
                      //           int.parse(remainingQuantitiyController.text),
                      //       productImage: file,
                      //       price: int.parse(unitPriceController.text),
                      //       categoryId: int.parse(selectedCategoryId),
                      //       descriptionAr: discriptionARController.text,
                      //       descriptionEn: discriptionENController.text,
                      //       isActive: isActiveVal,
                      //       isStockable: isStockableVal,
                      //       isShippingProduct: isShippableVal,
                      //     );
                      //     FocusScope.of(context).unfocus();

                      //     bool? c =
                      //         await _productsController.createProduct(product);
                      //     if (c != null && c) {
                      //       productNameENController.text = "";
                      //       productNameARController.text = "";
                      //       remainingQuantitiyController.text = "";
                      //       file = null;
                      //       unitPriceController.text = "";
                      //       discriptionARController.text = "";
                      //       discriptionENController.text = "";
                      //     }
                      //   } else {
                      //     if (formKey.currentState!.validate()) {
                      //       Product product = Product(
                      //         nameEn: productNameENController.text,
                      //         nameAr: productNameARController.text,
                      //         quantity:
                      //             int.parse(remainingQuantitiyController.text),
                      //         productImage: file,
                      //         price: int.parse(unitPriceController.text),
                      //         categoryId: int.parse(selectedCategoryId),
                      //         descriptionAr: discriptionARController.text,
                      //         descriptionEn: discriptionENController.text,
                      //         isActive: isActiveVal,
                      //         isStockable: isStockableVal,
                      //         isShippingProduct: isShippableVal,
                      //       );
                      //       FocusScope.of(context).unfocus();
                      //       logSuccess(product.toJson());
                      //       bool? c =
                      //           await _productsController.editProduct(product);
                      //       if (c != null && c) {
                      //         productNameENController.text = "";
                      //         productNameARController.text = "";
                      //         remainingQuantitiyController.text = "";
                      //         file = null;
                      //         unitPriceController.text = "";
                      //         discriptionARController.text = "";
                      //         discriptionENController.text = "";
                      //       }
                      //     }
                      //   }

                      // }
                    },
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       blackText("Create Product", 16),
                  //       SizedBox(width: 10),
                  //       GestureDetector(
                  //         onTap: () async {
                  //           if (formKey.currentState!.validate()) {
                  //             Product product = Product(
                  //               nameEn: productNameENController.text,
                  //               nameAr: productNameARController.text,
                  //               quantity: int.parse(
                  //                   remainingQuantitiyController.text),
                  //               productImage: file,
                  //               price: int.parse(unitPriceController.text),
                  //               categoryId: int.parse(selectedCategoryId),
                  //               descriptionAr: discriptionARController.text,
                  //               descriptionEn: discriptionENController.text,
                  //               isActive: isActiveVal,
                  //               isStockable: isStockableVal,
                  //               isShippingProduct: isShippableVal,
                  //             );
                  //             FocusScope.of(context).unfocus();

                  //             bool? c = await _productsController
                  //                 .createProduct(product);
                  //             if (c != null && c) {
                  //               productNameENController.text = "";
                  //               productNameARController.text = "";
                  //               remainingQuantitiyController.text = "";
                  //               file = null;
                  //               unitPriceController.text = "";
                  //               discriptionARController.text = "";
                  //               discriptionENController.text = "";
                  //             }
                  //           } else {}
                  //         },
                  //         child: Container(
                  //           decoration: BoxDecoration(
                  //             color: Colors.black,
                  //             borderRadius: BorderRadius.circular(40),
                  //           ),
                  //           padding: EdgeInsets.all(20),
                  //           child: Icon(
                  //             Icons.arrow_forward,
                  //             color: Colors.white,
                  //             size: 22.0.sp,
                  //           ),
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ));
  }
}

Future downloadFile(String url, String name) async {
  Dio dio = Dio();
  var dir = await getApplicationDocumentsDirectory();
  var imageDownloadPath = '${dir.path}/$name';
  await dio.download(
    url,
    imageDownloadPath,
  );
  return imageDownloadPath;
}
