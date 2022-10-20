import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/zoom_drawer_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoice_tab.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_payment_link.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/invoices_sub_pages/create_quick_invoice.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/payment_link_tab.dart';
import 'package:safqa/pages/home/menu_pages/invoices/tabs/quick_invoice_tab.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({super.key});

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage>
    with TickerProviderStateMixin {
  MyZoomDrawerController myZoomDrawerController = Get.find();
  late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = new TabController(vsync: this, length: 3);
    _tabController.addListener(_handleTabSelection);
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("Invoices", 17),
        bottom: TabBar(
          isScrollable: true,
          controller: _tabController,
          indicator: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff335A69),
                Color(0xff66B4D2),
              ],
            ),
          ),
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          tabs: [
            Tab(
              child: Text(
                "Invoices",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _tabController.index == 0
                        ? Colors.white
                        : const Color(0xff8B8B8B),
                    fontSize: 13.0.sp),
              ),
            ),
            Tab(
              child: Text(
                textAlign: TextAlign.center,
                "Quick Invoices",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _tabController.index == 1
                        ? Colors.white
                        : const Color(0xff8B8B8B),
                    fontSize: 13.0.sp),
              ),
            ),
            Tab(
              child: Text(
                textAlign: TextAlign.center,
                "Payment Link",
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: _tabController.index == 2
                        ? Colors.white
                        : const Color(0xff8B8B8B),
                    fontSize: 13.sp),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        width: w,
        height: h,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: Column(
          children: [
            SignUpTextField(
              padding: EdgeInsets.all(0),
              hintText: "Search ...",
              prefixIcon: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();

                  Get.to(() => SearchFilterPage(),
                      transition: Transition.downToUp);
                },
                child: Icon(
                  Icons.filter_alt,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                if (_tabController.index == 0) {
                  Get.to(() => InvoiceSubCreateInvoice());
                } else if (_tabController.index == 1) {
                  Get.to(() => InvoiceSubCreateQuickInvoice());
                } else {
                  Get.to(() => InvoiceSubCreatePaymentLink());
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
                    ..arcToPoint(Offset(size.width - 10, size.height),
                        radius: Radius.circular(10))
                    ..lineTo(10, size.height)
                    ..arcToPoint(Offset(0, size.height - 10),
                        radius: Radius.circular(10))
                    ..lineTo(0, 10)
                    ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
                },
                color: Color(0xff00A7B3),
                strokeWidth: 1,
                dashPattern: [10, 5],
                child: Container(
                  width: w,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_rounded,
                        color: Color(0xff00A7B3),
                      ),
                      Text(
                        "Create a new one",
                        style: TextStyle(
                          color: Color(0xff00A7B3),
                          fontSize: 13.0.sp,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  InvoiceTab(),
                  QuickInvoiceTab(),
                  PaymentLinkTab(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
