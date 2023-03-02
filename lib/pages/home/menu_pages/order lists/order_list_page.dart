import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/controller/order_list_controller.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/order_detais_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class OrderListsMainPage extends StatefulWidget {
  OrderListsMainPage({super.key});

  @override
  State<OrderListsMainPage> createState() => OrderListsMainPageState();
}

class OrderListsMainPageState extends State<OrderListsMainPage> {
  OrderListController _orderListController = Get.put(OrderListController());
  @override
  void initState() {
    // _orderListController.getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const ZeroAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h,
          ),
          Column(
            children: [
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22.0.sp,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    whiteText("order_list".tr, 17, fontWeight: FontWeight.w600),
                    Opacity(
                      opacity: 0,
                      child: whiteText("text", 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: w,
                  padding: EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      // Container(
                      //   width: w,
                      //   height: 60,
                      //   decoration: BoxDecoration(
                      //       borderRadius: BorderRadius.circular(15),
                      //       color: Color(0xff2F6782)),
                      //   child: Center(
                      //       child: whiteText("Total Deposits: 0.000", 16)),
                      // ),
                      // SizedBox(height: 20),
                      SignUpTextField(
                        hintText: "search".tr,
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: GetBuilder<OrderListController>(builder: (c) {
                            return Badge(
                              badgeColor: Color(0xff1BAFB2),
                              showBadge: c.orderFilter.filterActive,
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
                      SizedBox(height: 20),

                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            listBTN(
                                text: "copy".tr, onTap: () {}, width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(
                              text: "print/pdf".tr,
                              onTap: () async {},
                            ),
                            SizedBox(width: 5),
                            listBTN(
                                text: "Excel",
                                onTap: () async {},
                                width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(
                                text: "CSV",
                                onTap: () async {},
                                width: w / 4.5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: GetBuilder<OrderListController>(builder: (c) {
                          return c.getOrdersFlag
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : c.ordersToShow.length == 0
                                  ? Center(
                                      child: greyText("nothing_to_show".tr, 20),
                                    )
                                  : ListView.separated(
                                      primary: true,
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                        onTap: () {
                                          Get.to(() => OrderListDetailsPage(
                                                order: c.ordersToShow[index],
                                              ));
                                        },
                                        child: Container(
                                          padding: EdgeInsets.all(20),
                                          decoration: BoxDecoration(
                                            color: Color(0xffF9F9F9),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    blackText(
                                                        '#${c.ordersToShow[index].id}',
                                                        15,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                    greyText(
                                                        '${c.ordersToShow[index].createdAt}',
                                                        13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ]),
                                              SizedBox(height: 15),
                                              blackText(
                                                  '${"customer_name".tr}: ${c.ordersToShow[index].customerName}',
                                                  13,
                                                  fontWeight: FontWeight.w600),
                                              SizedBox(height: 15),
                                              blackText(
                                                  '${"order_value".tr}: ${c.ordersToShow[index].invoiceValue}',
                                                  13,
                                                  fontWeight: FontWeight.w600),
                                              SizedBox(height: 15),
                                              c.ordersToShow[index].status ==
                                                      "paid"
                                                  ? greenText(
                                                      '${"paid".tr}', 13,
                                                      fontWeight:
                                                          FontWeight.w600)
                                                  : redText(
                                                      '${"unpaid".tr}', 13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                              SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  blackText(
                                                      'Debit/Credit Cards :',
                                                      13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  greyText(
                                                      '450778xxxxxx2462', 13,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      itemCount: c.ordersToShow.length,
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(height: 20),
                                    );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
