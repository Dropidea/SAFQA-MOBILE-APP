import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductSearchFilterPage extends StatefulWidget {
  const ProductSearchFilterPage({super.key});

  @override
  State<ProductSearchFilterPage> createState() =>
      _ProductSearchFilterPageState();
}

class _ProductSearchFilterPageState extends State<ProductSearchFilterPage> {
  ProductsController productController = Get.find();

  SfRangeValues _values = const SfRangeValues(0, 100);

  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _values = SfRangeValues(
        productController.productFilter.priceMin ?? 0,
        productController.productFilter.priceMax ??
            productController.maxPriceProduct());
    if (productController.productFilter.price != null) {
      priceController.text = productController.productFilter.price.toString();
    } else if (productController.productFilter.priceMin != null &&
        productController.productFilter.priceMax != null) {
      minController.text = productController.productFilter.priceMin.toString();
      maxController.text = productController.productFilter.priceMax.toString();
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
                      productController.clearProductFilter();
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
                          "All",
                          productController.productFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController.productFilter.isActive = p0;
                                },
                              )),
                      buildRadioButton(
                          1,
                          "Active",
                          productController.productFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController.productFilter.isActive = p0;
                                },
                              )),
                      buildRadioButton(
                          2,
                          "Inactive",
                          productController.productFilter.isActive!,
                          (p0) => setState(
                                () {
                                  productController.productFilter.isActive = p0;
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
                  child: blackText("Is Active", 15),
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
                          "Fixed Value",
                          productController.productFilter.priceType,
                          (p0) => setState(
                                () {
                                  productController.productFilter.priceType =
                                      p0;
                                },
                              )),
                      buildRadioButton(
                          1,
                          "Min/Max",
                          productController.productFilter.priceType,
                          (p0) => setState(
                                () {
                                  productController.productFilter.priceType =
                                      p0;
                                },
                              )),
                      SizedBox(height: 10),
                      productController.productFilter.priceType == 0
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
                                          productController.productFilter
                                              .priceMin = int.parse(value);
                                          productController
                                              .productFilter.price = null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: "Min",
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
                                          productController.productFilter
                                              .priceMax = int.parse(value);
                                          productController
                                              .productFilter.price = null;
                                        },
                                        keyboardType: TextInputType.number,
                                        controller: maxController,
                                        decoration: InputDecoration(
                                          hintText: "Max",
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

                                  min: productController.minPriceProduct(),
                                  max: productController.maxPriceProduct(),
                                  values: _values,
                                  interval:
                                      productController.maxPriceProduct() / 6,
                                  activeColor: Color(0xff1BAFB2),
                                  showTicks: true,
                                  // showLabels: true,
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
                                      productController.productFilter.priceMin =
                                          value.start.round();
                                      productController.productFilter.priceMax =
                                          value.end.round();
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
                  child: blackText("Price", 15),
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
                    value: productController.productFilter.category == null
                        ? null
                        : productController.productFilter.category!.nameEn,
                    hint: Text("Categories"),
                    onChanged: (value) {
                      int ind = productController.productCategories
                          .indexWhere((element) => element.nameEn == value);

                      productController.productFilter.category =
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
                  child: blackText("Product Category", 15),
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
                    productController.productFilter.name = p0;
                  },
                ),
                header: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.5),
                    ),
                  ),
                  child: blackText("Product Name", 15),
                ),
              ),
              ApplyFilterBTN(
                width: 0.7 * w,
                onTap: () {
                  productController.activeProductFilter();
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
          productController.productFilter.price = int.parse(value);
          productController.productFilter.priceMax = null;
          productController.productFilter.priceMin = null;
        },
        decoration: InputDecoration(
          hintText: "Fixed Value",
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
        "Clear",
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
            child: whiteText("Apply", 15),
          ),
        ),
      ),
    );
  }
}

Widget buildCustomNameTextfield(
    {String? hint, void Function(String)? onChanged}) {
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
