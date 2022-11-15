import 'package:badges/badges.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/deposits/deposits_customer_details.dart';
import 'package:safqa/pages/home/menu_pages/deposits/deposits_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class DepositsMainPage extends StatefulWidget {
  DepositsMainPage({super.key});

  @override
  State<DepositsMainPage> createState() => DepositsMainPageState();
}

class DepositsMainPageState extends State<DepositsMainPage> {
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
                    whiteText("Deposits", 17, fontWeight: FontWeight.w600),
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
                      SizedBox(height: 30),
                      Container(
                        width: w,
                        height: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color(0xff2F6782)),
                        child: Center(
                            child: whiteText("Total Deposits: 0.000", 16)),
                      ),
                      SizedBox(height: 20),
                      SignUpTextField(
                        hintText: "Search ...",
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => DepositsSearchFilterPage());
                          },
                          child: Badge(
                            badgeColor: Color(0xff1BAFB2),
                            showBadge: true,
                            position: BadgePosition.topEnd(top: 8, end: 8),
                            child: Image(
                              image: AssetImage("assets/images/filter.png"),
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: Row(
                          // scrollDirection: Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            listBTN(text: "Copy", onTap: () {}, width: w / 4.5),
                            // listBTN(text: "Print", onTap: () {},width: w / 4.5),
                            MyPopUpMenu(
                              menuList: [
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        EvaIcons.file,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(width: 10),
                                      Text("PDF"),
                                    ],
                                  ),
                                ),
                                PopupMenuItem(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.print,
                                        color: Colors.grey.shade500,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Printer"),
                                    ],
                                  ),
                                ),
                              ],
                              widget: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                decoration: BoxDecoration(
                                  color: const Color(0xffF9F9F9),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Center(
                                  child: blueText("print", 12),
                                ),
                              ),
                            ),

                            listBTN(
                                text: "Excel", onTap: () {}, width: w / 4.5),
                            listBTN(text: "CSV", onTap: () {}, width: w / 4.5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: ListView(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackText("Today", 16,
                                    fontWeight: FontWeight.bold),
                                greyText("09 October 2022", 14)
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () {
                                  Get.to(() => DepositsCustomerDetailsPage());
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffF9F9F9),
                                            ),
                                            child: Center(
                                              child: Icon(
                                                Icons.image,
                                                color: Colors.grey.shade300,
                                                size: 30,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              blackText("Emirates Bank", 14),
                                              SizedBox(height: 10),
                                              greyText("#2246721355486131", 13)
                                            ],
                                          )
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          blackText("450 AED", 14,
                                              fontWeight: FontWeight.bold),
                                          SizedBox(height: 10),
                                          greyText("06:06 PM", 13)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: 3,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 20),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackText("Yesterday", 16,
                                    fontWeight: FontWeight.bold),
                                greyText("08 October 2022", 14)
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffF9F9F9),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.grey.shade300,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            blackText("Emirates Bank", 14),
                                            SizedBox(height: 10),
                                            greyText("#2246721355486131", 13)
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        blackText("450 AED", 14,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(height: 10),
                                        greyText("06:06 PM", 13)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              itemCount: 3,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 20),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                blackText("Last week", 16,
                                    fontWeight: FontWeight.bold),
                                greyText("01 October 2022", 14)
                              ],
                            ),
                            ListView.separated(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => Container(
                                margin: EdgeInsets.symmetric(vertical: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            color: Color(0xffF9F9F9),
                                          ),
                                          child: Center(
                                            child: Icon(
                                              Icons.image,
                                              color: Colors.grey.shade300,
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            blackText("Emirates Bank", 14),
                                            SizedBox(height: 10),
                                            greyText("#2246721355486131", 13)
                                          ],
                                        )
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        blackText("450 AED", 14,
                                            fontWeight: FontWeight.bold),
                                        SizedBox(height: 10),
                                        greyText("06:06 PM", 13)
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              itemCount: 3,
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      SizedBox(height: 20),
                            )
                          ],
                        ),
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
