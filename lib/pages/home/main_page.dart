import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/zoom_drawer_controller.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});
  MyZoomDrawerController myZoomDrawerController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            topSection(),
            Expanded(
                child: Align(
              child: ListView(
                primary: false,
                children: [
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Container testing() {
    return Container(
      width: 50.0.w,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
    );
  }

  Widget topSection() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: myZoomDrawerController.zoomDrawerController.toggle,
                child: const Image(
                  image: AssetImage('assets/images/menu.png'),
                ),
              )
            ],
          ),
          Row(
            children: [],
          ),
        ],
      ),
    );
  }
}
