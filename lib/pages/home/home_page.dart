import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/home/menu_pages/account_statment/ac_main_page.dart';
import 'package:safqa/pages/home/menu_pages/commisions/commisions_main_page.dart';
import 'package:safqa/pages/home/menu_pages/contact/contact_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/customers_main_page.dart';
import 'package:safqa/pages/home/menu_pages/deposits/deposits_main_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/Invoices_page.dart';
import 'package:safqa/pages/home/menu_pages/mf_auth/mf_auth_main_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_main_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/settings_main_page.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/locals_controller.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../models/menu_item.dart' as mi;
import 'main_page.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LoginController loginController = Get.find();
  LocalsController localsController = Get.find();
  MyZoomDrawerController zoomDrawerController =
      Get.put(MyZoomDrawerController());
  mi.MenuItem _currnetMenuItem = MyMenuItems.invoices;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff285B74),
      body: GetBuilder<MyZoomDrawerController>(
        builder: (c) {
          return ZoomDrawer(
            angle: 0,
            borderRadius: 30,
            controller: c.zoomDrawerController,
            menuScreenWidth: 60.0.w,
            isRtl: localsController.currenetLocale == 1,
            slideWidth: 60.0.w,
            menuScreen: MenuPage(
              currentItem: _currnetMenuItem,
              onSelectedItem: (value) {
                setState(() {
                  _currnetMenuItem = value;
                });
                // zoomDrawerController.zoomDrawerController.close!();
                Get.to(() => getScreen());
              },
            ),
            mainScreen: MainPage(),
          );
        },
      ),
    );
  }

  Widget getScreen() {
    switch (_currnetMenuItem) {
      case MyMenuItems.invoices:
        return const InvoicesPage();
      case MyMenuItems.products:
        return ProductsMainPage();
      case MyMenuItems.customers:
        return CustomersMainPage();
      case MyMenuItems.commissions:
        return CommisionsMainPage();
      case MyMenuItems.accountStatement:
        return AccountStateMainPage();
      case MyMenuItems.deposits:
        return DepositsMainPage();
      case MyMenuItems.multiFactorAuthentication:
        return MultiFactorAuthMainPage();
      case MyMenuItems.contact:
        return ContactPage();
      case MyMenuItems.settings:
        return SettingsPage();

      default:
        return MainPage();
    }
  }
}
