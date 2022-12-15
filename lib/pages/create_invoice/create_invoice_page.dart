import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/pages/create_invoice/tabs/invoice_tab.dart';
import 'package:safqa/pages/create_invoice/tabs/payment_link_tab.dart';
import 'package:safqa/pages/create_invoice/tabs/quick_invoice_tab.dart';
import "package:sizer/sizer.dart";

// Container customDropdown(List<String> items, String? selectedItem, double width,
//     Function onchanged) {
//   return ;
// }

class CreateInvoicePage extends StatefulWidget {
  CreateInvoicePage({super.key});

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage>
    with TickerProviderStateMixin {
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

  AddInvoiceController addInvoiceController = Get.find();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // toolbarHeight: 100,
        iconTheme: IconThemeData(color: Color.fromARGB(255, 187, 169, 169)),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          _tabController.index == 0
              ? "create_new_invoice".tr
              : _tabController.index == 1
                  ? "create_quick_invoice".tr
                  : "create_payment_link".tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
        ),
        centerTitle: true,
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
                "invoices".tr,
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
                "quick_invoices".tr,
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
                "payment_links".tr,
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
            Expanded(
                child: TabBarView(
              controller: _tabController,
              children: [
                CreateInvoiceTab(),
                CreateQuickInvoiceTab(),
                CreatePaymentLinkTab(),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Text greyText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
          color: const Color(0xff8B8B8B),
          fontWeight: FontWeight.w500,
          fontSize: size.sp),
    );
  }

  Text blackText(String text, double size) {
    return Text(
      text,
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: size.sp),
    );
  }
}
