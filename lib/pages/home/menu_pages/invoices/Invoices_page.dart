import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/payment_link_controller.dart';
import 'package:safqa/controllers/zoom_drawer_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/pages/home/menu_pages/invoices/invoice_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/payment_link_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoice_tab.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_payment_link.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_quick_invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/payment_link_tab.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  MyZoomDrawerController myZoomDrawerController = Get.find();
  int selectedTab = 0;
  List<String> tabsNames = [
    "invoices".tr,
    // "quick_invoices".tr,
    "payment_links".tr
  ];
  final AddInvoiceController _addInvoiceController =
      Get.put(AddInvoiceController());
  final PaymentLinkController _paymentLinkController = Get.find();
  InvoicesController invoiceController = Get.find();

  Widget getPage() {
    switch (selectedTab) {
      case 0:
        return InvoiceTab();
      // case 1:
      //   return QuickInvoiceTab();
      default:
        return PaymentLinkTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
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
              Column(children: [
                Container(
                  height: 90,
                  margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
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
                      whiteText(tabsNames[selectedTab], 17,
                          fontWeight: FontWeight.w600),
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
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        SignUpTextField(
                          padding: EdgeInsets.all(0),
                          onchanged: (s) {
                            if (selectedTab == 0) {
                              invoiceController.searchForInvoicesWithName(s!);
                            } else if (selectedTab == 1) {
                            } else {
                              _paymentLinkController.searchForPayLink(s!);
                            }
                          },
                          hintText: "search".tr,
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.grey,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              if (selectedTab == 2) {
                                Get.to(() => PaymentLinkSearchFilterPage(),
                                    transition: Transition.downToUp);
                              } else {
                                Get.to(() => InvoiceSearchFilterPage(),
                                    transition: Transition.downToUp);
                              }
                            },
                            child: selectedTab == 0
                                ? GetBuilder<InvoicesController>(builder: (c) {
                                    return Badge(
                                      badgeColor: Color(0xff1BAFB2),
                                      showBadge: c.invoiceFilter.filterActive,
                                      position:
                                          BadgePosition.topEnd(top: 8, end: 8),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/filter.png"),
                                        width: 18,
                                        height: 18,
                                      ),
                                    );
                                  })
                                : GetBuilder<PaymentLinkController>(
                                    builder: (c) {
                                    return Badge(
                                      badgeColor: Color(0xff1BAFB2),
                                      showBadge:
                                          c.paymentLinkFilter.filterActive,
                                      position:
                                          BadgePosition.topEnd(top: 8, end: 8),
                                      child: Image(
                                        image: AssetImage(
                                            "assets/images/filter.png"),
                                        width: 18,
                                        height: 18,
                                      ),
                                    );
                                  }),
                          ),
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (selectedTab == 0) {
                              Get.to(() => InvoiceSubCreateInvoice());
                            } else if (selectedTab == 1) {
                              Get.to(() => InvoiceSubCreateQuickInvoice());
                            } else {
                              Get.to(() => InvoiceSubCreatePaymentLink());
                            }
                          },
                          child: DottedBorder(
                            padding: EdgeInsets.all(0),
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
                            color: Color(0xff2F6782).withOpacity(0.4),
                            strokeWidth: 1,
                            dashPattern: [10, 5],
                            child: Container(
                              width: w,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xff2F6782).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_rounded,
                                    color: Color(0xff2F6782),
                                  ),
                                  Text(
                                    "create_new".tr,
                                    style: TextStyle(
                                      color: Color(0xff2F6782),
                                      fontSize: 13.0.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(child: getPage()),
                      ],
                    ),
                  ),
                )
              ]),
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
                      primary: false,
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
                              width: w / 2.5,
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
                                  horizontal: 20, vertical: 10),
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

    // Scaffold(
    //   appBar: AppBar(
    //     backgroundColor: Colors.white,
    //     elevation: 0,
    //     centerTitle: true,
    //     iconTheme: IconThemeData(color: Colors.black),
    //     title: blackText("Invoices", 17),
    //     bottom: TabBar(
    //       isScrollable: true,
    //       controller: _tabController,
    //       indicator: const BoxDecoration(
    //         borderRadius: BorderRadius.all(
    //           Radius.circular(10),
    //         ),
    //         gradient: LinearGradient(
    //           begin: Alignment.centerLeft,
    //           end: Alignment.centerRight,
    //           colors: [
    //             Color(0xff335A69),
    //             Color(0xff66B4D2),
    //           ],
    //         ),
    //       ),
    //       // padding: const EdgeInsets.symmetric(horizontal: 10),
    //       tabs: [
    //         Tab(
    //           child: Text(
    //             "Invoices",
    //             textAlign: TextAlign.center,
    //             style: TextStyle(
    //                 fontWeight: FontWeight.w500,
    //                 color: _tabController.index == 0
    //                     ? Colors.white
    //                     : const Color(0xff8B8B8B),
    //                 fontSize: 13.0.sp),
    //           ),
    //         ),
    //         Tab(
    //           child: Text(
    //             textAlign: TextAlign.center,
    //             "Quick Invoices",
    //             style: TextStyle(
    //                 fontWeight: FontWeight.w500,
    //                 color: _tabController.index == 1
    //                     ? Colors.white
    //                     : const Color(0xff8B8B8B),
    //                 fontSize: 13.0.sp),
    //           ),
    //         ),
    //         Tab(
    //           child: Text(
    //             textAlign: TextAlign.center,
    //             "Payment Link",
    //             style: TextStyle(
    //                 fontWeight: FontWeight.w500,
    //                 color: _tabController.index == 2
    //                     ? Colors.white
    //                     : const Color(0xff8B8B8B),
    //                 fontSize: 13.sp),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   body: Container(
    //     width: w,
    //     height: h,
    //     padding: const EdgeInsets.symmetric(
    //       horizontal: 20,
    //       vertical: 20,
    //     ),
    //     child: Column(
    //       children: [
    //         SignUpTextField(
    //           padding: EdgeInsets.all(0),
    //           hintText: "search".tr,
    //           prefixIcon: Icon(
    //             Icons.search_outlined,
    //             color: Colors.grey,
    //           ),
    //           suffixIcon: GestureDetector(
    //             onTap: () {
    //               FocusScope.of(context).unfocus();
    //               if (_tabController.index == 2) {
    //                 Get.to(() => PaymentLinkSearchFilterPage(),
    //                     transition: Transition.downToUp);
    //               } else {
    //                 Get.to(() => InvoiceSearchFilterPage(),
    //                     transition: Transition.downToUp);
    //               }
    //             },
    //             child: Badge(
    //               badgeColor: Color(0xff1BAFB2),
    //               showBadge: true,
    //               position: BadgePosition.topEnd(top: 8, end: 8),
    //               child: Image(
    //                 image: AssetImage("assets/images/filter.png"),
    //                 width: 18,
    //                 height: 18,
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         GestureDetector(
    //           onTap: () {
    //             if (_tabController.index == 0) {
    //               Get.to(() => InvoiceSubCreateInvoice());
    //             } else if (_tabController.index == 1) {
    //               Get.to(() => InvoiceSubCreateQuickInvoice());
    //             } else {
    //               Get.to(() => InvoiceSubCreatePaymentLink());
    //             }
    //           },
    //           child: DottedBorder(
    //             padding: EdgeInsets.all(0),
    //             customPath: (size) {
    //               return Path()
    //                 ..moveTo(10, 0)
    //                 ..lineTo(size.width - 10, 0)
    //                 ..arcToPoint(Offset(size.width, 10),
    //                     radius: Radius.circular(10))
    //                 ..lineTo(size.width, size.height - 10)
    //                 ..arcToPoint(Offset(size.width - 10, size.height),
    //                     radius: Radius.circular(10))
    //                 ..lineTo(10, size.height)
    //                 ..arcToPoint(Offset(0, size.height - 10),
    //                     radius: Radius.circular(10))
    //                 ..lineTo(0, 10)
    //                 ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
    //             },
    //             color: Color(0xff2F6782).withOpacity(0.4),
    //             strokeWidth: 1,
    //             dashPattern: [10, 5],
    //             child: Container(
    //               width: w,
    //               height: 40,
    //               decoration: BoxDecoration(
    //                 color: Color(0xff2F6782).withOpacity(0.1),
    //                 borderRadius: BorderRadius.circular(10),
    //               ),
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   Icon(
    //                     Icons.add_rounded,
    //                     color: Color(0xff2F6782),
    //                   ),
    //                   Text(
    //                     "Create a new one",
    //                     style: TextStyle(
    //                       color: Color(0xff2F6782),
    //                       fontSize: 13.0.sp,
    //                     ),
    //                   )
    //                 ],
    //               ),
    //             ),
    //           ),
    //         ),
    //         const SizedBox(height: 20),
    //         Expanded(
    //           child: TabBarView(
    //             controller: _tabController,
    //             children: [
    //               InvoiceTab(),
    //               QuickInvoiceTab(),
    //               PaymentLinkTab(),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
