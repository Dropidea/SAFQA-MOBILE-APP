import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/controller/admin_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/zoom_drawer_controller.dart';
import '../../models/menu_item.dart' as mi;

class MenuPage extends StatelessWidget {
  AdminController _adminController = Get.find();
  MenuPage(
      {super.key, required this.onSelectedItem, required this.currentItem});

  final ValueChanged<mi.MenuItem> onSelectedItem;
  LocalsController localsController = Get.find();
  final mi.MenuItem currentItem;
  Widget buildMenuItem(mi.MenuItem item) => ListTile(
        title: Text(
          localsController.currenetLocale == 0 ? item.titleEn : item.titleAr,
          style: TextStyle(
            color: item.titleEn == "Log out" ? Color(0xffE47E7B) : Colors.white,
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          item.icon,
          color:
              item.titleEn == "Log out" ? Color(0xffE47E7B) : Color(0xffffffff),
        ),
        minLeadingWidth: 20,
        // selected: currentItem == item,
        onTap: () async {
          if (item.titleEn == "Log out") {
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
                  children: !_adminController.isAdmin
                      ? [
                          ...MyMenuItems.all.map(buildMenuItem).toList(),
                        ]
                      : [...MyAdminMenuItems.all.map(buildMenuItem).toList()],
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

class MyAdminMenuItems {
  // static const dashboard = mi.MenuItem("Dashboard", Icons.abc);
  static const banks = mi.MenuItem(
      titleEn: "Banks",
      icon: FontAwesomeIcons.buildingColumns,
      titleAr: "????????????");
  static const profiles = mi.MenuItem(
      titleEn: "Profiles", icon: EvaIcons.people, titleAr: "?????????????? ??????????????");
  static const addresses = mi.MenuItem(
      titleEn: "Addresses", icon: Icons.location_pin, titleAr: "????????????????");
  static const languages = mi.MenuItem(
      titleEn: "Languages", icon: FontAwesomeIcons.language, titleAr: "????????????");
  static const businessCategories = mi.MenuItem(
      titleEn: "Business Categories",
      icon: FontAwesomeIcons.businessTime,
      titleAr: "???????? ??????????????");
  static const businessTypes = mi.MenuItem(
      titleEn: "Business Types",
      icon: FontAwesomeIcons.typo3,
      titleAr: "?????????? ??????????????");
  static const paymentMethods = mi.MenuItem(
      titleEn: "Payent Methods",
      icon: FontAwesomeIcons.creditCard,
      titleAr: "?????? ??????????");
  static const recurringInterval = mi.MenuItem(
      titleEn: "Recurring Interval",
      icon: FontAwesomeIcons.repeat,
      titleAr: "???????????? ???????????? ??????????????");
  static const socialMedia = mi.MenuItem(
      titleEn: "Social Media",
      icon: EvaIcons.globe,
      titleAr: "?????????? ?????????????? ??????????????????");
  static const about =
      mi.MenuItem(titleEn: "About", icon: EvaIcons.info, titleAr: "???? ????????");
  static const contact = mi.MenuItem(
      titleEn: "Contact", icon: EvaIcons.phoneCall, titleAr: "??????????");

  static const logOut = mi.MenuItem(
      titleEn: "Log out", icon: EvaIcons.logOut, titleAr: "?????????? ????????????");
  static const multiFactorAuthentication = mi.MenuItem(
      titleEn: "Multi-factor authentication",
      icon: EvaIcons.lock,
      titleAr: "???????????? ???????????? ??????????????");
  static const all = <mi.MenuItem>[
    // dashboard,
    profiles,
    addresses,
    languages,
    banks,
    businessCategories,
    businessTypes,
    paymentMethods,
    recurringInterval,
    socialMedia,
    about,
    contact,
    multiFactorAuthentication,
    logOut,
  ];
}

class MyMenuItems {
  // static const dashboard = mi.MenuItem("Dashboard", Icons.abc);
  static const invoices = mi.MenuItem(
      titleEn: "Invoices", icon: EvaIcons.fileText, titleAr: "????????????????");
  static const orderList = mi.MenuItem(
      titleEn: "Order List", icon: EvaIcons.list, titleAr: "?????????? ??????????????");
  static const products = mi.MenuItem(
      titleEn: "Products", icon: EvaIcons.shoppingBag, titleAr: "????????????????");
  static const customers = mi.MenuItem(
      titleEn: "Customers", icon: EvaIcons.people, titleAr: "??????????????");
  static const commissions = mi.MenuItem(
      titleEn: "Commisions", icon: EvaIcons.creditCard, titleAr: "????????????????");
  static const accountStatement = mi.MenuItem(
      titleEn: "Account statement",
      icon: EvaIcons.activity,
      titleAr: "?????? ????????");
  static const deposits = mi.MenuItem(
      titleEn: "Deposits",
      icon: EvaIcons.arrowCircleDown,
      titleAr: "??????????????????");
  static const refunds = mi.MenuItem(
      titleEn: "Refunds", icon: EvaIcons.refresh, titleAr: "?????????????? ????????????????");
  static const multiFactorAuthentication = mi.MenuItem(
      titleEn: "Multi-factor authentication",
      icon: EvaIcons.lock,
      titleAr: "???????????? ???????????? ??????????????");
  static const contact = mi.MenuItem(
      titleEn: "Contact Us",
      icon: EvaIcons.messageCircle,
      titleAr: "?????????? ????????");
  static const settings = mi.MenuItem(
      titleEn: "Settings", icon: EvaIcons.settings, titleAr: "??????????????????");
  static const logOut = mi.MenuItem(
      titleEn: "Log out", icon: EvaIcons.logOut, titleAr: "?????????? ????????????");
  static const all = <mi.MenuItem>[
    // dashboard,
    invoices,
    orderList,
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
