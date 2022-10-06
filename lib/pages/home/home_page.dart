import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/locals_controller.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import 'main_page.dart';
import 'menu_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    LocalsController localsController = Get.find();
    MyZoomDrawerController zoomDrawerController =
        Get.put(MyZoomDrawerController());
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
                  menuScreen: const MenuPage(),
                  mainScreen: MainPage(),
                );
              });
        },
      ),
    );
  }
}
