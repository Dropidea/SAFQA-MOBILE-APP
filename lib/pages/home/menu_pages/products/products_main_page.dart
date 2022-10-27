import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/my_store.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class ProductsMainPage extends StatefulWidget {
  ProductsMainPage({super.key});

  @override
  State<ProductsMainPage> createState() => _ProductsMainPageState();
}

class _ProductsMainPageState extends State<ProductsMainPage> {
  int selectedTab = 0;
  List<String> tabsNames = [
    "Products",
    "My Store",
    "Products Ordered",
    "Product Category",
  ];

  Widget getPage() {
    switch (selectedTab) {
      case 0:
        return ProductsTab();
      case 1:
        return MyStoreTab();
      default:
        return ProductsTab();
    }
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
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                        selectedTab == 1
                            ? MyPopUpMenu(
                                iconColor: Colors.white,
                                menuList: [
                                  PopupMenuItem(
                                      child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.copy,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      blackText("Copy Store Link", 11),
                                    ],
                                  )),
                                  PopupMenuItem(
                                      child: Row(
                                    children: [
                                      Icon(
                                        Icons.share,
                                        size: 20,
                                      ),
                                      SizedBox(width: 5),
                                      blackText("Share Store", 11),
                                    ],
                                  )),
                                ],
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      width: w,
                      padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: getPage(),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 75,
                        margin:
                            const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Align(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = index;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: index == selectedTab
                                      ? LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff66B4D2),
                                            Color(0xff2F6782),
                                          ],
                                        )
                                      : null,
                                  color: index != selectedTab
                                      ? Colors.white
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40, vertical: 10),
                              margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: index == selectedTab ? 2 : 0),
                              child: Center(
                                child: index == selectedTab
                                    ? whiteText(tabsNames[index], 12)
                                    : greyText(tabsNames[index], 12),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: tabsNames.length,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
