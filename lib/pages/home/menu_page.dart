import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/zoom_drawer_controller.dart';
import '../../models/menu_item.dart' as mi;

class MenuPage extends StatelessWidget {
  MenuPage(
      {super.key, required this.onSelectedItem, required this.currentItem});

  final ValueChanged<mi.MenuItem> onSelectedItem;
  final mi.MenuItem currentItem;
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
          color:
              item.title == "Log out" ? Color(0xffE47E7B) : Color(0xffffffff),
        ),
        minLeadingWidth: 20,
        // selected: currentItem == item,
        onTap: () async {
          if (item.title == "Log out") {
            await AuthService().logout();
          } else {
            onSelectedItem(item);
          }
        },
      );
  MyZoomDrawerController myZoomDrawerController = Get.find();
  @override
  Widget build(BuildContext context) {
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
  // static const dashboard = mi.MenuItem("Dashboard", Icons.abc);
  static const invoices = mi.MenuItem("Invoices", EvaIcons.fileText);
  static const products = mi.MenuItem("Products", EvaIcons.shoppingBag);
  static const customers = mi.MenuItem("Customers", EvaIcons.people);
  static const commissions = mi.MenuItem("Commisions", EvaIcons.creditCard);
  static const accountStatement =
      mi.MenuItem("Account statement", EvaIcons.activity);
  static const deposits = mi.MenuItem("Deposits", EvaIcons.arrowCircleDown);
  static const refunds = mi.MenuItem("Refunds", EvaIcons.refresh);
  static const multiFactorAuthentication =
      mi.MenuItem("Multi-factor authentication", EvaIcons.lock);
  static const contact = mi.MenuItem("Contact", EvaIcons.messageCircle);
  static const settings = mi.MenuItem("Settings", EvaIcons.settings);
  static const logOut = mi.MenuItem("Log out", EvaIcons.logOut);
  static const all = <mi.MenuItem>[
    // dashboard,
    invoices,
    products,
    customers,
    commissions,
    accountStatement,
    deposits,
    refunds,
    multiFactorAuthentication,
    contact,
    settings,
    logOut
  ];
}
