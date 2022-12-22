import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstTimeUsingAppController extends GetxController {
  Future<bool> checkIfFirstTimeUsingApp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('first_time')!;
  }

  Future setFirstTimeUsing() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_time') == null)
      await prefs.setBool('first_time', true);
    else
      await prefs.setBool('first_time', false);
  }
}
