import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:safqa/admin/controller/admin_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/pages/home/home_page.dart';

import '../services/auth_service.dart';

class LoginController extends GetxController {
  GlobalDataController _globalDataController = Get.put(GlobalDataController());
  AdminController _adminController = Get.put(AdminController());

  Future<void> login(String email, String password, bool rememberMe) async {
    Get.dialog(
      const SizedBox(
          height: 25,
          width: 25,
          child: Center(
            child: CircularProgressIndicator(),
          )),
    );
    var res = await AuthService().login(email, password, rememberMe);
    if (res == null) {
      Navigator.of(Get.overlayContext!).pop();
    } else {
      Map<String, dynamic> decoded = Jwt.parseJwt(res);
      await _globalDataController.getMe();
      if (decoded['role_type'] == "admin")
        _adminController.setIsAdmin(true);
      else
        _adminController.setIsAdmin(false);

      Navigator.of(Get.overlayContext!).pop();
    }

    if (res != null) {
      Get.offAll(() => HomePage());
    }
  }
}
