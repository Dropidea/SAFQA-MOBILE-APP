import 'package:get/get.dart';

class AdminController extends GetxController {
  bool _isAdmin = true;
  void setIsAdmin(bool v) {
    _isAdmin = v;
  }

  bool get isAdmin => _isAdmin;
}
