import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/profiles/models/profile_model.dart';
import 'package:safqa/admin/pages/profiles/models/profiles_filter.dart';
import 'package:safqa/main.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';

class ProfilesController extends GetxController {
  final Dio dio = Dio();

  sslProblem() async {
    String token = await AuthService().loadToken();
    dio.options.headers["authorization"] = "bearer  $token";
    dio.options.headers['content-Type'] = 'multipart/form-data';

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  List<Profile> profiles = [];
  List<Profile> profilesToShow = [];
  List<Profile> filteredProfiles = [];

  void searchForProfilesWithName(String name) {
    if (name == "") {
      profilesToShow = filteredProfiles;
    } else {
      List<Profile> tmp = [];
      for (var i in filteredProfiles) {
        if (i.companyName!.contains(name) ||
            i.workEmail!.contains(name) ||
            i.phoneNumber!.contains(name)) {
          tmp.add(i);
        }
        profilesToShow = tmp;
      }
    }
    update();
  }

  ProfilesFilter profilesFilter = ProfilesFilter(
      filterActive: false,
      companyName: null,
      workEmail: null,
      mobileNumber: null);

  activeProdilesFilter() {
    profilesFilter.filterActive = true;
    List<Profile> tmp1 = [];
    List<Profile> tmp2 = [];
    if (profilesFilter.companyName != null) {
      for (var i in profiles) {
        if (i.companyName!.contains(profilesFilter.companyName!)) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(profiles);
    }

    if (profilesFilter.mobileNumber != null) {
      for (var i in tmp1) {
        if (i.phoneNumber!.contains(profilesFilter.mobileNumber!)) {
          tmp2.add(i);
        }
      }
    } else {
      tmp2.addAll(tmp1);
    }
    tmp1 = [];
    if (profilesFilter.workEmail != null) {
      for (var i in tmp2) {
        if (i.workEmail!.contains(profilesFilter.workEmail!)) {
          tmp1.add(i);
        }
      }
    } else {
      tmp1.addAll(tmp2);
    }
    tmp2 = [];

    filteredProfiles = tmp1;
    profilesToShow = filteredProfiles;
    update();
  }

  clearProfilesFilter() {
    profilesFilter = ProfilesFilter(
        filterActive: false,
        companyName: null,
        workEmail: null,
        mobileNumber: null);
    filteredProfiles = profiles;
    profilesToShow = profiles;
    update();
  }

  bool getprofilesFlag = false;
  Future getAllprofiles() async {
    try {
      getprofilesFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getProfiles);
      List<Profile> tmp = [];
      for (var i in res.data['data']) {
        Profile c = Profile.fromJson(i);
        tmp.add(c);
      }
      profiles = tmp;
      profilesToShow = tmp;
      filteredProfiles = tmp;
      logSuccess("profiles get done");
      getprofilesFlag = false;
      // return globalData;
    } on DioError catch (e) {
      getprofilesFlag = false;
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getAllprofiles();
        }
      } else {
        logError(e.message);
      }
    }
    update();
  }

  //  Future deleteBank(Bank bank) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));

  //     final body = d.FormData();
  //     body.fields.add(MapEntry("_method", "DELETE"));
  //     var res = await dio.post(EndPoints.
  //         data: body);
  //     logSuccess(res.data);
  //     await getAllprofiles();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Bank Deleted Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await deleteCustomer(customerId);
  //       }
  //     } else {
  //       logError(e.message);
  //     }

  //   }
  // }

  // Future createBank(Bank bank) async {
  //   try {
  //     await sslProblem();
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(bank.toJson());
  //     var res = await dio.post(EndPoints.createBank, data: body);
  //     logSuccess(res.data);
  //     await getAllprofiles();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Bank Created Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await createBank(bank);
  //       }
  //     } else {
  //       Map<String, dynamic> m = e.response!.data;
  //       String errors = "";
  //       int c = 0;
  //       for (var i in m.values) {
  //         for (var j = 0; j < i.length; j++) {
  //           if (j == i.length - 1) {
  //             errors = errors + i[j];
  //           } else {
  //             errors = "${errors + i[j]}\n";
  //           }
  //         }

  //         c++;
  //         if (c != m.values.length) {
  //           errors += "\n";
  //         }
  //       }
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           duration: Duration(milliseconds: 3000),
  //           backgroundColor: Colors.red,
  //           // message: errors,
  //           messageText: Text(
  //             errors,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 17,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }

  // Future editBank(Bank bank) async {
  //   try {
  //     await sslProblem();
  //     logSuccess(bank.toJson());
  //     Get.dialog(const Center(
  //       child: CircularProgressIndicator(),
  //     ));
  //     final body = d.FormData.fromMap(bank.toJson());
  //     body.fields.add(MapEntry("_method", "PUT"));
  //     var res = await dio.post(EndPoints.editBank(bank.id!), data: body);
  //     logSuccess(res.data);
  //     await getAllprofiles();
  //     Get.back();
  //     MyDialogs.showSavedSuccessfullyDialoge(
  //       title: "Bank Edited Successfully",
  //       btnTXT: "close",
  //       onTap: () async {
  //         Get.back();
  //         Get.back();
  //       },
  //     );
  //   } on DioError catch (e) {
  //     Get.back();
  //     if (e.response!.statusCode == 404 &&
  //         e.response!.data["message"] == "Please Login") {
  //       bool res = await Utils.reLoginHelper(e);
  //       if (res) {
  //         await createBank(bank);
  //       }
  //     } else {
  //       Map<String, dynamic> m = e.response!.data;
  //       String errors = "";
  //       int c = 0;
  //       for (var i in m.values) {
  //         for (var j = 0; j < i.length; j++) {
  //           if (j == i.length - 1) {
  //             errors = errors + i[j];
  //           } else {
  //             errors = "${errors + i[j]}\n";
  //           }
  //         }

  //         c++;
  //         if (c != m.values.length) {
  //           errors += "\n";
  //         }
  //       }
  //       Get.showSnackbar(
  //         GetSnackBar(
  //           duration: Duration(milliseconds: 3000),
  //           backgroundColor: Colors.red,
  //           // message: errors,
  //           messageText: Text(
  //             errors,
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 17,
  //             ),
  //           ),
  //         ),
  //       );
  //     }
  //   }
  // }
}
