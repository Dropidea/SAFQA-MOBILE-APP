import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/zoom_drawer_controller.dart';
import 'package:safqa/models/menu_item.dart' as mi;
import 'package:sizer/sizer.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  Widget buildMenuItem(mi.MenuItem item) => ListTile(
        title: Text(
          item.title,
          style: TextStyle(
            color: item.title == "Log out" ? Color(0xffE47E7B) : Colors.white,
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          item.icon,
          color: item.title == "Log out" ? Color(0xffE47E7B) : Colors.white,
        ),
        minLeadingWidth: 20,
        onTap: () {},
      );
  @override
  Widget build(BuildContext context) {
    MyZoomDrawerController myZoomDrawerController = Get.find();
    return Scaffold(
      backgroundColor: Color(0xff285B74),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildXButton(myZoomDrawerController),
            Expanded(
              child: Align(
                child: ListView(
                  primary: false,
                  children: [
                    ...MyMenuItems.all.map(buildMenuItem).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildXButton(MyZoomDrawerController myZoomDrawerController) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        onTap: myZoomDrawerController.zoomDrawerController.toggle,
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            Icons.close_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class MyMenuItems {
  static final invoices = mi.MenuItem("Invoices", Icons.abc);
  static final products = mi.MenuItem("Products", Icons.abc);
  static final customers = mi.MenuItem("Customers", Icons.abc);
  static final payments = mi.MenuItem("Payments", Icons.abc);
  static final accountStatement = mi.MenuItem("Account statement", Icons.abc);
  static final deposits = mi.MenuItem("Deposits", Icons.abc);
  static final refunds = mi.MenuItem("Refunds", Icons.abc);
  static final multiFactorAuthentication =
      mi.MenuItem("multi-factor authentication", Icons.abc);
  static final help = mi.MenuItem("Help", Icons.abc);
  static final settings = mi.MenuItem("Settings", Icons.abc);
  static final logOut = mi.MenuItem("Log out", Icons.abc);
  static final all = <mi.MenuItem>[
    invoices,
    products,
    customers,
    payments,
    accountStatement,
    deposits,
    refunds,
    multiFactorAuthentication,
    help,
    settings,
    logOut
  ];
}
