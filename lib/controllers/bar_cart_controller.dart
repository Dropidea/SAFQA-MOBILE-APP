import 'package:flutter/animation.dart';
import 'package:get/get.dart';
import 'package:safqa/models/bar_chart_data.dart';

class BarChartController extends GetxController {
  int interval = 5;
  List<MyBarChartData> data = [
    MyBarChartData(
      id: 0,
      name: "Jan",
      y: 10,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 1,
      name: "feb",
      y: 15,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 2,
      name: "mar",
      y: 50,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 3,
      name: "apr",
      y: 80,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 4,
      name: "may",
      y: 4,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 5,
      name: "jun",
      y: 70,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 6,
      name: "jul",
      y: 90,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 7,
      name: "aug",
      y: 16,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 8,
      name: "sep",
      y: 69,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 9,
      name: "oct",
      y: 54,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 10,
      name: "nov",
      y: 10,
      color: Color(0xffff0000),
    ),
    MyBarChartData(
      id: 11,
      name: "dec",
      y: 70,
      color: Color(0xffff0000),
    ),
  ];
}
