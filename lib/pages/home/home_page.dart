import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/home/menu_pages/invoices/Invoices_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_main_page.dart';
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
          return FutureBuilder(
              future: localsController.getLocale(),
              builder: (context, snapshot) {
                return ZoomDrawer(
                  angle: 0,
                  borderRadius: 30,
                  controller: c.zoomDrawerController,
                  menuScreenWidth: 70.0.w,
                  isRtl: snapshot.hasData ? snapshot.data! : false,
                  slideWidth: 70.0.w,
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
              });
        },
      ),
    );
  }

  Widget getScreen() {
    switch (_currnetMenuItem) {
      case MyMenuItems.invoices:
        return InvoicesPage();
      case MyMenuItems.products:
        return ProductsMainPage();
      default:
        return MainPage();
    }
  }
}
