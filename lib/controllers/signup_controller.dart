import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/end_points.dart';

class SignUpController extends GetxController {
  var globadData;
  List<String> _drops = ['+1', '+2', '+3'];
  RxString _selectedDrop = "+1".obs;
  List<String> get drops => _drops;
  String get selectedDrop => _selectedDrop.value;
  void SelectDrop(String x) {
    this._selectedDrop.value = x;
  }

  Future getGlobalData() async {
    try {
      var res = await Dio().get(EndPoints.baseURL + EndPoints.globalData);
      globadData = res;
      return res.data;
    } on DioError catch (e) {
      logError(e.message);
    }
  }
}
