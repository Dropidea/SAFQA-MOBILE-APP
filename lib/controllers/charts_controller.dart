import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/my_chart_data.dart';

class ChartsController extends GetxController {
  int interval = 5;
  List<MyChartData> pieData = [
    MyChartData(
      name: "awaiting for transfer",
      color: Color(0xff00A7B3),
      percent: 40,
    ),
    MyChartData(
      name: "total balance",
      percent: 50,
      color: Color(0xff2F6782),
    ),
    MyChartData(
      percent: 10,
      name: "awaiting balance",
      color: Color(0xffE4E4E4),
    ),
  ];
  List<MyChartData> data = [
    MyChartData(
      id: 0,
      name: "Jan",
      y: 10,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 1,
      name: "feb",
      y: 15,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 2,
      name: "mar",
      y: 50,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 3,
      name: "apr",
      y: 80,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 4,
      name: "may",
      y: 4,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 5,
      name: "jun",
      y: 70,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 6,
      name: "jul",
      y: 90,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 7,
      name: "aug",
      y: 16,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 8,
      name: "sep",
      y: 69,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 9,
      name: "oct",
      y: 54,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 10,
      name: "nov",
      y: 10,
      color: Color(0xffff0000),
    ),
    MyChartData(
      id: 11,
      name: "dec",
      y: 70,
      color: Color(0xffff0000),
    ),
  ];

  List<PieChartSectionData> getSectins() => pieData
      .asMap()
      .map<int, PieChartSectionData>((i, d) {
        final value = PieChartSectionData(
            radius: 20, color: d.color, value: d.percent, showTitle: false);

        return MapEntry(i, value);
      })
      .values
      .toList();
}
