import 'package:get/get.dart';

class SignUpController extends GetxController {
  List<String> _drops = ['+1', '+2', '+3'];
  RxString _selectedDrop = "+1".obs;
  List<String> get drops => _drops;
  String get selectedDrop => _selectedDrop.value;
  void SelectDrop(String x) {
    this._selectedDrop.value = x;
  }
}
