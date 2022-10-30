import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class ProductOrderedSearchFilterPage extends StatefulWidget {
  const ProductOrderedSearchFilterPage({super.key});

  @override
  State<ProductOrderedSearchFilterPage> createState() =>
      _ProductOrderedSearchFilterPageState();
}

class _ProductOrderedSearchFilterPageState
    extends State<ProductOrderedSearchFilterPage> {
  SignUpController _signUpController = Get.find();
  int isActive = 0;
  int refund = 0;
  int orderedStatus = 0;

  int price = 0;
  int dateCreated = 0;
  SfRangeValues _values = SfRangeValues(0, 100);
  double sMin = 0;
  double sMax = 100;
  double sInterval = 20;
  TextEditingController maxController = TextEditingController();
  TextEditingController minController = TextEditingController();
  TextEditingController fixedDateController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

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
      body: ExpandableNotifier(
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
                Text(
                  "Clear",
                  style: TextStyle(
                    fontSize: 16.0.sp,
                    color: Color(0xff00A7B3),
                    decoration: TextDecoration.underline,
                  ),
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
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Active",
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "Inactive",
                        isActive,
                        (p0) => setState(
                              () {
                                isActive = p0;
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
                        "All",
                        refund,
                        (p0) => setState(
                              () {
                                refund = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Refundable",
                        refund,
                        (p0) => setState(
                              () {
                                refund = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "Not Refundable",
                        refund,
                        (p0) => setState(
                              () {
                                refund = p0;
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
                child: blackText("Refund", 15),
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
                        price,
                        (p0) => setState(
                              () {
                                price = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Min/Max",
                        price,
                        (p0) => setState(
                              () {
                                price = p0;
                              },
                            )),
                    SizedBox(height: 10),
                    price == 0
                        ? buildpriceFixedTextfield()
                        : Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
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
                                        if (value != "") {
                                          setState(() {
                                            if (double.parse(value) > 0 &&
                                                double.parse(value) < sMax) {
                                              sMin = double.parse(value);
                                              _values =
                                                  SfRangeValues(sMin, sMax);
                                            }
                                          });
                                        }
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
                                      borderRadius: BorderRadius.circular(10.0),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    width: 0.4 * w,
                                    height: 50,
                                    child: TextFormField(
                                      onChanged: (value) {
                                        if (value != "") {
                                          setState(() {
                                            if (double.parse(value) > 100 &&
                                                double.parse(value) > sMin) {
                                              sMax = double.parse(value);
                                              sInterval = sMax / 5;
                                              _values =
                                                  SfRangeValues(sMin, sMax);
                                            }
                                          });
                                        }
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

                                min: sMin,
                                max: sMax,
                                values: _values,
                                interval: sInterval,
                                activeColor: Color(0xff1BAFB2),
                                showTicks: true,
                                showLabels: true,
                                enableTooltip: true,
                                minorTicksPerInterval: 1,
                                stepSize: 1,
                                onChanged: (value) {
                                  logWarning(_signUpController.globalData);
                                  setState(() {
                                    _values = value;
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
                margin: EdgeInsets.only(top: 10),
                child: Column(
                  children: [
                    buildRadioButton(
                        0,
                        "All",
                        orderedStatus,
                        (p0) => setState(
                              () {
                                orderedStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        1,
                        "Prepared",
                        orderedStatus,
                        (p0) => setState(
                              () {
                                orderedStatus = p0;
                              },
                            )),
                    buildRadioButton(
                        2,
                        "Delivered",
                        orderedStatus,
                        (p0) => setState(
                              () {
                                orderedStatus = p0;
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
                child: blackText("Refund", 15),
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
                child: Obx(
                  () {
                    List categories = _signUpController.globalData['category'];
                    List<String> ids = categories
                        .map<String>((e) => e['id'].toString())
                        .toList();
                    List<String> categoryNames = categories
                        .map<String>((e) => e['name'].toString())
                        .toList();

                    return DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      items: categoryNames
                          .map((e) => DropdownMenuItem<String>(
                                child: Text(e),
                                value: e,
                              ))
                          .toList(),
                      value: _signUpController.selectedCategoryDrop == ""
                          ? null
                          : _signUpController.selectedCategoryDrop,
                      hint: Text("Categories"),
                      onChanged: (value) {
                        _signUpController.errors = {};

                        _signUpController.selectCategoryDrop(value!);

                        _signUpController.dataToRegister['category_id'] =
                            ids[categoryNames.indexOf(value)];
                      },
                    );
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
              expanded: buildCustomerNameTextfield(),
              header: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 0.5),
                  ),
                ),
                child: blackText("Product Name", 15),
              ),
            ),
            Align(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30),
                width: 0.7 * w,
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff1BAFB2)),
                child: Center(child: whiteText("Apply", 15)),
              ),
            ),
          ],
        ),
      ),
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
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Invoice value ...",
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

  Widget buildCustomerNameTextfield() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "Customer Name ...",
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
          GFRadio(
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
          SizedBox(
            width: 15,
          ),
          groupValue == value ? blackText(text, 15) : greyText(text, 15),
        ],
      ),
    );
  }
}
