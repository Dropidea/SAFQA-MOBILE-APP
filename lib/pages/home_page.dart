import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/login.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/widgets/zero_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String t = "";
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find();
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Center(
        child: ListView(
          children: [
            Text("login".tr),
            GFButton(
              onPressed: () async {
                await loginController.removeToken();
                Get.offAll(() => LoginPage());
              },
              child: Text("Logout"),
            ),
            GFButton(
              onPressed: () async {
                try {
                  logSuccess("token is :${loginController.token}");
                  var res = await Dio().post(EndPoints.baseURL + "/me",
                      options: Options(headers: {
                        "Authorization": "Bearer ${loginController.token}",
                      }));
                  t = res.data.toString();
                  setState(() {});
                  logSuccess(res.data);
                } on DioError catch (e) {
                  logError(e.message);
                }
              },
              child: Text("show ME"),
            ),
            Text(
              t,
              style: TextStyle(fontSize: 22),
            )
          ],
        ),
      ),
    );
  }
}
