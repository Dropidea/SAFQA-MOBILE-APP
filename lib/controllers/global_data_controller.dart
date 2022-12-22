import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/models/contacts.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address_type.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/area.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/city.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/send_options.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';

class GlobalDataController extends GetxController {
  Dio dio = Dio();
  sslProblem() async {
    dio.options.headers['content-Type'] = 'multipart/form-data';
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "Bearer $token";

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  List<Country> countries = [];
  List<SendOption> sendOptions = [];
  List<UserRole> roles = [];
  List<City> cities = [];
  List<Area> areas = [];
  List<Area> areastoshow = [];
  List<AddressType> addressTypes = [];
  ContactUsInfo contactUsInfo = ContactUsInfo();
  ManageUser me = ManageUser();

  Future getMe() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.baseURL + EndPoints.meEndPoint);
      me = ManageUser.fromJson(res.data);
      logSuccess("me get done");
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getMe();
        }
      } else {
        logError("me failed");
      }
    }
  }

  Future getContactUsInfo() async {
    try {
      await sslProblem();
      var res1 = await dio.get(EndPoints.getContactUsPhones);
      var res2 = await dio.get(EndPoints.getContactUsMessage);
      List<ContactPhones> tmp = [];
      for (var i in res1.data['data']) {
        ContactPhones t = ContactPhones.fromJson(i);
        tmp.add(t);
      }
      ContactUsInfo tmp2 = ContactUsInfo.fromJson(res2.data["message"]);
      tmp2.contactPhones = tmp;
      contactUsInfo = tmp2;
      logSuccess("Contact Us info done");
    } on DioError catch (e) {
      logError("Contact Us info failed");
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
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getRoles();
        }
      } else {
        logError("roles failed");
      }
    }
  }

  Future getSendOptions() async {
    try {
      await sslProblem();
      var res = await dio.get(EndPoints.getSendOptions);
      for (var i in res.data['data']) {
        SendOption tmp = SendOption.fromJson(i);
        sendOptions.add(tmp);
      }
      logSuccess(sendOptions);
      logSuccess("Send Options get done");
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getSendOptions();
        }
      } else {
        logError("Send Options failed");
      }
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
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAdressTypes();
        }
      } else {
        logError("AddressTypes failed");
      }
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
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getCountries();
        }
      } else {
        logError("countries failed");
      }
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
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getCities();
        }
      } else {
        logError("Cities failed");
      }
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
      if (e.response!.statusCode == 404) {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAreas();
        }
      } else {
        logError("Areas failed");
      }
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

  String getSendOption(int id) {
    String sendOption =
        sendOptions[sendOptions.indexWhere((element) => element.id == id)]
            .nameEn!;
    return sendOption;
  }
}
