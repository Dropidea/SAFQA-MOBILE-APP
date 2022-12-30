import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductStoreSearchFilterPage extends StatefulWidget {
  const ProductStoreSearchFilterPage({super.key});

  @override
  State<ProductStoreSearchFilterPage> createState() =>
      _ProductStoreSearchFilterPageState();
}

class _ProductStoreSearchFilterPageState
    extends State<ProductStoreSearchFilterPage> {
  ProductsController productController = Get.find();

  SfRangeValues _values = const SfRangeValues(0, 100);

  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _values = SfRangeValues(
        productController.productStoreFilter.priceMin ?? 0,
        productController.productStoreFilter.priceMax ??
            productController.maxPriceProduct());
    if (productController.productStoreFilter.price != null) {
      priceController.text =
          productController.productStoreFilter.price.toString();
    } else if (productController.productStoreFilter.priceMin != null &&
        productController.productStoreFilter.priceMax != null) {
      minController.text =
          productController.productStoreFilter.priceMin.toString();
      maxController.text =
          productController.productStoreFilter.priceMax.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0xffFBFBFB),
        elevation: 0,
      ),
      backgroundColor: Color(0xffFBFBFB),
      body: GetBuilder<ProductsController>(builder: (context) {
        return ExpandableNotifier(
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.close,
                      size: 25.0.sp,
                    ),
                  ),
                  ClearFilterBTN(
                    onTap: () {
                      productController.clearProductStoreFilter();
                      Get.back();
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              ExpandablePanel(
                controller: ExpandableController(initialExpanded: true),
                collapsed: Container(),
                theme: ExpandableThemeData(hasIcon: false),
                expanded: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      buildRadioButton(
                          0,
                          "all".tr,
                          productController.productStoreFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController
                                      .productStoreFilter.isActive = p0;
                                },
                              )),
                      buildRadioButton(
                          1,
                          "active".tr,
                          productController.productStoreFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController
                                      .productStoreFilter.isActive = p0;
                                },
                              )),
                      buildRadioButton(
                          2,
                          "inactive".tr,
                          productController.productStoreFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController
                                      .productStoreFilter.isActive = p0;
                                },
                              )),
                    ],
                  ),
                ),
                header: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: blackText("is_active".tr, 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ExpandablePanel(
                controller: ExpandableController(initialExpanded: true),
                collapsed: Container(),
                theme: ExpandableThemeData(hasIcon: false),
                expanded: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      buildRadioButton(
                          0,
                          "fixed_val".tr,
                          productController.productStoreFilter.priceType,
                          (p0) => setState(
                                () {
                                  productController
                                      .productStoreFilter.priceType = p0;
                                },
                              )),
                      buildRadioButton(
                          1,
                          "min/max".tr,
                          productController.productStoreFilter.priceType,
                          (p0) => setState(
                                () {
                                  productController
                                      .productStoreFilter.priceType = p0;
                                },
                              )),
                      SizedBox(height: 10),
                      productController.productStoreFilter.priceType == 0
                          ? buildpriceFixedTextfield()
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      width: 0.4 * w,
                                      height: 50,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        controller: minController,
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            productController.productStoreFilter
                                                .priceMin = int.parse(value);
                                            productController
                                                .productFilter.price = null;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: "min".tr,
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        border: Border.all(
                                          color: Colors.grey.shade300,
                                        ),
                                      ),
                                      width: 0.4 * w,
                                      height: 50,
                                      child: TextFormField(
                                        onChanged: (value) {
                                          if (value.isNotEmpty) {
                                            productController.productStoreFilter
                                                .priceMax = int.parse(value);
                                            productController
                                                .productFilter.price = null;
                                          }
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: maxController,
                                        decoration: InputDecoration(
                                          hintText: "max".tr,
                                          fillColor: Colors.white,
                                          filled: true,
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SfRangeSlider(
                                  // shouldAlwaysShowTooltip: true,

                                  min: productController.products.length == 1
                                      ? 0
                                      : productController.minPriceProduct(),
                                  max: productController.maxPriceProduct(),
                                  values: _values,
                                  interval:
                                      productController.maxPriceProduct() / 6,
                                  activeColor: Color(0xff1BAFB2),
                                  showTicks: true,
                                  showLabels: true,
                                  enableTooltip: true,
                                  // showDividers: true,
                                  // shouldAlwaysShowTooltip: true,
                                  minorTicksPerInterval: 1,
                                  stepSize:
                                      productController.maxPriceProduct() / 100,
                                  onChanged: (value) {
                                    setState(() {
                                      _values = value;
                                      minController.text =
                                          value.start.round().toString();
                                      maxController.text =
                                          value.end.round().toString();
                                      productController.productStoreFilter
                                          .priceMin = value.start.round();
                                      productController.productStoreFilter
                                          .priceMax = value.end.round();
                                    });
                                  },
                                )
                              ],
                            )
                    ],
                  ),
                ),
                header: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: blackText("price".tr, 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ExpandablePanel(
                controller: ExpandableController(initialExpanded: true),
                collapsed: Container(),
                theme: ExpandableThemeData(hasIcon: false),
                expanded: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.5),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: productController.productCategories
                        .map((e) => DropdownMenuItem<String>(
                              child: blackText(e.nameEn!, 13),
                              value: e.nameEn,
                            ))
                        .toList(),
                    value: productController.productStoreFilter.category == null
                        ? null
                        : productController.productStoreFilter.category!.nameEn,
                    hint: Text("categories".tr),
                    onChanged: (value) {
                      int ind = productController.productCategories
                          .indexWhere((element) => element.nameEn == value);

                      productController.productStoreFilter.category =
                          productController.productCategories[ind];
                    },
                  ),
                ),
                header: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: blackText("product_category".tr, 15),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ExpandablePanel(
                controller: ExpandableController(initialExpanded: true),
                collapsed: Container(),
                theme: ExpandableThemeData(hasIcon: false),
                expanded: buildCustomNameTextfield(
                  onChanged: (p0) {
                    productController.productStoreFilter.name = p0;
                  },
                ),
                header: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: blackText("product_name".tr, 15),
                ),
              ),
              ApplyFilterBTN(
                width: 0.7 * w,
                onTap: () {
                  logSuccess(productController.productStoreFilter.toJson());
                  productController.activeProductStoreFilter();
                  Get.back();
                },
              )
            ],
          ),
        );
      }),
    );
  }

  Container buildpriceFixedTextfield() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        controller: priceController,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          productController.productStoreFilter.price = int.parse(value);
          productController.productStoreFilter.priceMax = null;
          productController.productStoreFilter.priceMin = null;
        },
        decoration: InputDecoration(
          hintText: "fixed_val".tr,
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget buildRadioButton(
      int value, String text, int groupValue, void Function(int)? onChanged) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: GFRadio(
              activeBorderColor: Colors.transparent,
              inactiveBorderColor: Colors.transparent,
              inactiveBgColor: Colors.transparent,
              activeBgColor: Colors.transparent,
              radioColor: Color(0xff66B4D2),
              inactiveIcon: Icon(
                Icons.circle_outlined,
                color: Colors.grey.shade300,
              ),
              size: GFSize.SMALL,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}

class ClearFilterBTN extends StatelessWidget {
  const ClearFilterBTN({
    Key? key,
    this.onTap,
  }) : super(key: key);
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        "clear".tr,
        style: TextStyle(
          fontSize: 16.0.sp,
          color: Color(0xff00A7B3),
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class ApplyFilterBTN extends StatelessWidget {
  const ApplyFilterBTN({
    Key? key,
    this.width,
    this.height,
    this.onTap,
  }) : super(key: key);

  final double? width;
  final double? height;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Align(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          width: width,
          height: height,
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff1BAFB2),
          ),
          child: Center(
            child: whiteText("apply".tr, 15),
          ),
        ),
      ),
    );
  }
}

Widget buildCustomNameTextfield(
    {String? hint, void Function(String)? onChanged, String? initialValue}) {
  return Container(
    margin: EdgeInsets.only(top: 20),
    height: 50,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(
        color: Colors.grey.shade300,
      ),
    ),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
      ),
    ),
  );
}
