import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as d;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/bank_model.dart';
import 'package:safqa/models/contacts.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/models/recurring_interval.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/Address_type.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/Area.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/city.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/send_options.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

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
  List<Language> languages = [];
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
      update();

      logSuccess("me get done");
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
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
      ContactUsInfo tmp2 = ContactUsInfo.fromJson(res2.data["data"]);
      tmp2.contactPhones = tmp;
      contactUsInfo = tmp2;
      logSuccess("Contact Us info done");
    } on DioError catch (e) {
      logError("Contact Us info failed");
    }
  }

  Future getLanguages() async {
    try {
      await sslProblem();
      var res1 = await dio.get(EndPoints.getLanguages);

      List<Language> tmp = [];
      for (var i in res1.data['data']) {
        Language t = Language.fromJson(i);
        tmp.add(t);
      }
      languages = tmp;
      logSuccess("Languages done");
    } on DioError catch (e) {
      logError("Languages failed");
    }
  }

  List<RecurringInterval> recurringIntervals = [];
  Future getRecurringInterval() async {
    recurringIntervals = [];
    try {
      await sslProblem();
      var res1 = await dio.get(EndPoints.getRecurringInerval);

      List<RecurringInterval> tmp = [];
      for (var i in res1.data['data']) {
        RecurringInterval t = RecurringInterval.fromJson(i);
        tmp.add(t);
      }
      recurringIntervals = tmp;
      logSuccess("Recurring Interval done");
    } on DioError catch (e) {
      logError("Recurring Interval failed");
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
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
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
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getSendOptions();
        }
      } else {
        logError("Send Options failed");
      }
    }
  }

  Future createAddressType(AddressType addressType) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      final body = d.FormData.fromMap(addressType.toJson());

      var res = await dio.post(EndPoints.createAddressType, data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getAdressTypes();

      //   return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createAddressType(addressType);
        }
      } else {
        logError(e.response!);
        // logError(e.response!.data);

      }
    }
  }

  Future editAddressType(AddressType addressType) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      final body = d.FormData.fromMap(addressType.toJson());

      body.fields.add(MapEntry("_method", "PUT"));

      var res = await dio.post(EndPoints.editAddressType(addressType.id!),
          data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Edited Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getAdressTypes();

      //   return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createAddressType(addressType);
        }
      } else {
        logError(e.response!);
        // logError(e.response!.data);

      }
    }
  }

  Future deleteAddressType(AddressType addressType) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(addressType.toJson());
      body.fields.add(MapEntry("_method", "DELETE"));
      var res = await dio.post(EndPoints.deleteAddressType(addressType.id!),
          data: body);
      logSuccess(res.data);
      addressTypes.removeWhere((element) => element == addressType);
      update();

      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "AddressType deleted Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
    }
  }

  bool getAdressTypesFlag = false;
  Future getAdressTypes() async {
    try {
      getAdressTypesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getAdressTypes);
      List<AddressType> tmp = [];
      for (var i in res.data['data']) {
        AddressType t = AddressType.fromJson(i);
        tmp.add(t);
      }
      addressTypes = tmp;
      getAdressTypesFlag = false;
      update();
      logSuccess("AddressTypes get done");
    } on DioError catch (e) {
      getAdressTypesFlag = false;
      update();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAdressTypes();
        }
      } else {
        logError("AddressTypes failed");
      }
    }
  }

  Future createCountry(Country country, var logo) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      final body = d.FormData.fromMap(country.toJson());

      body.files.add(MapEntry(
        "flag",
        await d.MultipartFile.fromFile(
          logo.path,
          filename: logo.path.split(" ").last,
          contentType: MediaType('image', '*'),
        ),
      ));
      logSuccess(body.files);
      var res = await dio.post(EndPoints.createCountry, data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getCountries();

      //   return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createCountry(country, logo);
        }
      } else {
        logError(e.response!);
        // logError(e.response!.data);

      }
    }
  }

  Future editCountry(Country country, var logo) async {
    logSuccess(country.toJson());
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      final body = d.FormData.fromMap(country.toJson());
      if (logo != null) {
        body.files.add(MapEntry(
          "flag",
          await d.MultipartFile.fromFile(
            logo.path,
            filename: logo.path.split(" ").last,
            contentType: MediaType('image', '*'),
          ),
        ));
      }
      body.fields.add(MapEntry("_method", "PUT"));

      var res = await dio.post(EndPoints.editCountry(country.id!), data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Edited Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getCountries();

      //   return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createCountry(country, logo);
        }
      } else {
        logError(e.response!);
        // logError(e.response!.data);

      }
    }
  }

  bool getCountriesFlag = false;
  Future getCountries() async {
    try {
      getCountriesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getCountries);
      List<Country> tmp = [];
      for (var i in res.data['data']) {
        Country t = Country.fromJson(i);
        tmp.add(t);
      }
      countries = tmp;
      logSuccess("countries get done");
      getCountriesFlag = false;
      update();
    } on DioError catch (e) {
      getCountriesFlag = false;
      update();
      logError(e.response!.data);
      logError("countries error");
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getCountries();
        }
      } else {
        logError("countries failed");
      }
    }
  }

  Future deleteCountry(Country country) async {
    try {
      await sslProblem();
      Get.dialog(const Center(
        child: CircularProgressIndicator(),
      ));
      final body = d.FormData.fromMap(country.toJson());
      body.fields.add(MapEntry("_method", "DELETE"));
      var res =
          await dio.post(EndPoints.deleteCountry(country.id!), data: body);
      logSuccess(res.data);
      countries.removeWhere((element) => element == country);
      update();

      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Country deleted Successfully",
        btnTXT: "close",
        onTap: () async {
          Get.back();
        },
      );
    } on DioError catch (e) {
      Get.back();
    }
  }

  Future createCity(City city) async {
    Get.dialog(Center(
      child: CircularProgressIndicator(),
    ));
    try {
      await sslProblem();
      final body = d.FormData.fromMap(city.toJson());

      var res = await dio.post(EndPoints.createCity, data: body);
      Get.back();
      MyDialogs.showSavedSuccessfullyDialoge(
        title: "Created Successfully",
        btnTXT: "Close",
        onTap: () {
          Get.back();
          Get.back();
        },
      );
      await getCities();

      //   return true;
    } on DioError catch (e) {
      Get.back();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login" &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await createCity(city);
        }
      } else {
        logError(e.response!);
        // logError(e.response!.data);

      }
    }
  }

  // Future editAddressType(AddressType addressType) async {
  //   Get.dialog(Center(
  //     child: CircularProgressIndicator(),
  //   ));
  //   try {
  //     await sslProblem();
  //     final body = d.FormData.fromMap(addressType.toJson());

  //     body.fields.add(MapEntry("_method", "PUT"));

  //     var res = await dio.post(EndPoints.editAddressType(addressType.id!),
  //         data: body);
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Edited Successfully",
  //       btnTXT: "Close",
  //       onTap: () {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //     await getAdressTypes();

  //     //   return true;
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login" &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await createAddressType(addressType);
  //       }
  //     } else {
  //       logError(e.response!);
  //       // logError(e.response!.data);

  //     }
  //   }
  // }

  // Future deleteAddressType(AddressType addressType) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(addressType.toJson());
  //     body.fields.add(MapEntry("_method", "DELETE"));
  //     var res = await dio.post(EndPoints.deleteAddressType(addressType.id!),
  //         data: body);
  //     logSuccess(res.data);
  //     addressTypes.removeWhere((element) => element == addressType);
  //     update();

  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "AddressType deleted Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //   }
  // }
  bool getCitiesFlag = false;
  Future getCities() async {
    try {
      getCitiesFlag = true;
      await sslProblem();
      var res = await dio.get(me.isSuperAdmin != null
          ? EndPoints.getAdminCities
          : EndPoints.getCities);
      getCitiesFlag = false;
      List<City> tmp = [];
      for (var i in res.data['data']) {
        City t = City.fromJson(i);
        tmp.add(t);
      }
      cities = tmp;
      update();
      logSuccess("Cities get done");
    } on DioError catch (e) {
      getCitiesFlag = false;
      update();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getCities();
        }
      } else {
        logError("Cities failed");
      }
    }
  }

  bool getAreaFlag = false;
  Future getAreas() async {
    try {
      getAreaFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getAreas);
      List<Area> tmp = [];
      for (var i in res.data['data']) {
        Area t = Area.fromJson(i);
        tmp.add(t);
      }
      areas = tmp;
      logSuccess("Areas get done");
      getAreaFlag = false;
      update();
    } on DioError catch (e) {
      getAreaFlag = false;
      update();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
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
