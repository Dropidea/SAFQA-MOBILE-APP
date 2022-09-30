import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/pages/login.dart';
import 'package:safqa/widgets/zero_app_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("login".tr),
            GFButton(
              onPressed: () async {
                await loginController.removeToken();
                Get.offAll(() => LoginPage());
              },
              child: Text("Logout"),
            )
          ],
        ),
      ),
    );
  }
}
