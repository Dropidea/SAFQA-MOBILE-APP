import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address_type.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/area.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/city.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';

class GlobalDataController extends GetxController {
  Dio dio = Dio();
  sslProblem() async {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "bearer  $token";

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  List<Country> countries = [];
  List<UserRole> roles = [];
  List<City> cities = [];
  List<Area> areas = [];
  List<Area> areastoshow = [];
  List<AddressType> addressTypes = [];
  ManageUser me = ManageUser();

  Future getMe() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.baseURL + EndPoints.meEndPoint);
      me = ManageUser.fromJson(res.data);
      logSuccess("me get done");
    } on DioError catch (e) {
      logError("me failed");
    }
  }

  Future getRoles() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getRoles);
      for (var i in res.data['data']) {
        UserRole tmp = UserRole.fromJson(i);
        roles.add(tmp);
      }
      logSuccess("roles get done");
    } on DioError catch (e) {
      logError("roles failed");
    }
  }

  Future getAdressTypes() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getAdressTypes);
      for (var i in res.data['data']) {
        AddressType tmp = AddressType.fromJson(i);
        addressTypes.add(tmp);
      }
      logSuccess("AddressTypes get done");
    } on DioError catch (e) {
      logError("AddressTypes failed");
    }
  }

  Future getCountries() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getCountries);
      for (var i in res.data['data']) {
        Country tmp = Country.fromJson(i);
        countries.add(tmp);
      }
      logSuccess("countries get done");
    } on DioError catch (e) {
      logError("countries failed");
    }
  }

  Future getCities() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getCities);
      for (var i in res.data['data']) {
        City tmp = City.fromJson(i);
        cities.add(tmp);
      }
      logSuccess("Cities get done");
    } on DioError catch (e) {
      logError("Cities failed");
    }
  }

  Future getAreas() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getAreas);
      for (var i in res.data['data']) {
        Area tmp = Area.fromJson(i);
        areas.add(tmp);
      }
      logSuccess("Areas get done");
    } on DioError catch (e) {
      logError("Areas failed");
    }
  }

  String? selectedCityArea;
  void deSelectCityArea() {
    selectedCityArea = null;
    update();
  }

  Future getCityAreas(int id) async {
    List<Area> tmp = [];
    for (var i in areas) {
      if (i.city!.id == id) {
        logSuccess("added");
        tmp.add(i);
      }
      areastoshow = tmp;
      update();
    }
  }

  String getCountryCode(int id) {
    String code =
        countries[countries.indexWhere((element) => element.id == id)].code!;
    return code;
  }
}
