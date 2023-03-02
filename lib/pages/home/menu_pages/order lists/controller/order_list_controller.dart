import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/model/order_filter.dart';
import 'package:safqa/pages/home/menu_pages/order%20lists/model/order_list_model.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/services/end_points.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/dialoges.dart';

class OrderListController extends GetxController {
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

  //TODO:
  List<Order> orders = [
    Order(
        customerName: "asdad",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "paid",
        id: 1),
    Order(
        customerName: "zxczv",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "un paid",
        id: 2),
  ];
  List<Order> ordersToShow = [
    Order(
        customerName: "asdad",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "paid",
        id: 1),
    Order(
        customerName: "zxczv",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "un paid",
        id: 2),
  ];
  List<Order> filteredOrders = [
    Order(
        customerName: "asdad",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "paid",
        id: 1),
    Order(
        customerName: "zxczv",
        createdAt: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        expiryDate: DateFormat.yMMMEd().format(DateTime.now()).toString(),
        invoiceValue: 100,
        status: "un paid",
        id: 2),
  ];
  bool getOrdersFlag = false;
  OrderFilter orderFilter = OrderFilter(
    filterActive: false,
    name: null,
    customerRefrence: null,
    mobileNumber: null,
  );
  activeOrderFilter() {
    orderFilter.filterActive = true;
    List<Order> tmp1 = [];
    List<Order> tmp2 = [];
//TODO:
    filteredOrders = tmp1;
    ordersToShow = filteredOrders;
    update();
  }

  clearOrderFilter() {
    orderFilter = OrderFilter(
      filterActive: false,
      name: null,
      customerRefrence: null,
      mobileNumber: null,
    );
    filteredOrders = orders;
    ordersToShow = orders;
    update();
  }

  void searchForOrderWithCustomerName(String name) {
    if (name == "") {
      ordersToShow = filteredOrders;
    } else {
      //TODO:
      List<Order> tmp = [];
      for (var i in filteredOrders) {
        if (i.customerName!.contains(name)) {
          tmp.add(i);
        }
        ordersToShow = tmp;
      }
    }
    update();
  }

  Future getOrders() async {
    try {
      getOrdersFlag = true;
      await sslProblem();
      var res = await dio.get(EndPoints.getOrders);
      List<Order> tmp = [];
      for (var i in res.data['data']) {
        Order c = Order.fromJson(i);
        tmp.add(c);
      }
      orders = tmp;
      ordersToShow = tmp;
      filteredOrders = tmp;

      getOrdersFlag = false;
      update();
    } on DioError catch (e) {
      getOrdersFlag = false;
      update();
      if (e.response!.statusCode == 404 &&
          e.response!.data["message"] == "Please Login") {
        bool res = await Utils.reLoginHelper(e);
        if (res) {
          await getOrders();
        }
      } else {
        MyDialogs.showWarningDialoge2(
            onProceed: () {
              Get.back();
            },
            message: "Error",
            yesBTN: "close");
      }
    }
    update();
  }
}
