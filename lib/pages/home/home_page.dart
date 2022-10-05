import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/home/main_page.dart';
import 'package:safqa/pages/home/menu_page.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/login_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../widgets/zero_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    MyZoomDrawerController zoomDrawerController =
        Get.put(MyZoomDrawerController());
    return Scaffold(
      backgroundColor: Color(0xff285B74),
      appBar: ZeroAppBar(),
      body: GetBuilder<MyZoomDrawerController>(
        builder: (c) {
          return ZoomDrawer(
            angle: 0,
            borderRadius: 30,
            controller: c.zoomDrawerController,
            menuScreenWidth: 70.0.w,
            slideWidth: 70.0.w,
            menuScreen: MenuPage(),
            mainScreen: MainPage(),
          );
        },
      ),
    );
  }
}
