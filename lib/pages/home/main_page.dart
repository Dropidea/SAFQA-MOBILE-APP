import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/bar_cart_controller.dart';
import 'package:safqa/controllers/zoom_drawer_controller.dart';
import 'package:safqa/widgets/my_dropdown.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MyZoomDrawerController myZoomDrawerController = Get.find();

  BarChartController _barChartController = Get.put(BarChartController());
  double _x = 0;
  double _y = 0;
  String i = "This Month";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            topSection(),
            Expanded(
                child: Align(
              child: ListView(
                primary: false,
                children: [
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "\$ 35.400",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 25.0.sp,
                              color: Color(0xff2F6782),
                            ),
                          ),
                          Text(
                            "Total Balance",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0.sp,
                              color: Color(0xffAAAAAA),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                        width: 100,
                        child: myDropdown(),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 0.40 * w,
                        height: 0.2 * h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/welcome_background.png"),
                              fit: BoxFit.cover),
                          color: Color(0xff2F6782),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "\$ 35.400",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 20.0.sp,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Total Balance",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xffCBCBCB), fontSize: 14.0.sp),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 0.40 * w,
                        height: 0.12 * h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/images/welcome_background.png"),
                              fit: BoxFit.cover),
                          color: Color(0xff2F6782),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(15),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Number Of Transactions",
                            softWrap: true,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xffCBCBCB), fontSize: 14.0.sp),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0.sp,
                      ),
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Invoices',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationThickness: 3,
                            decorationColor: Color(0xffaaaaaa),
                            color: Colors.transparent,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
                          ),
                        ),
                        TextSpan(
                          text: ' Report',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.transparent,
                            shadows: [
                              Shadow(color: Colors.black, offset: Offset(0, -5))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xff2F6782),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Number of paid invoices",
                            style: TextStyle(fontSize: 13.0.sp),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Container(
                            width: 15,
                            height: 15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Color(0xffaaaaaa),
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            "Number of invoices",
                            style: TextStyle(fontSize: 13.0.sp),
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 0.6 * h,
                    width: w,
                    child: Align(
                      child: ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          SizedBox(
                            height: 0.5 * h,
                            width: w + 200,
                            child: BarChart(
                              BarChartData(
                                  gridData: FlGridData(
                                    show: false,
                                  ),
                                  borderData: FlBorderData(show: false),
                                  titlesData: FlTitlesData(
                                    // show: false,
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        getTitlesWidget: (value, meta) => Text(
                                            _barChartController
                                                .data[value.round()].name
                                                .toString()),
                                      ),
                                    ),
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ), //                         alignment: BarChartAlignment.center,

                                  minY: 0,
                                  maxY: 100,
                                  groupsSpace: 12,
                                  barTouchData: BarTouchData(
                                      enabled: true,
                                      touchTooltipData: BarTouchTooltipData(
                                        tooltipBgColor: Colors.transparent,
                                        getTooltipItem: (group, groupIndex, rod,
                                                rodIndex) =>
                                            BarTooltipItem(
                                          rod.toY.round().toString(),
                                          TextStyle(),
                                        ),
                                      )),
                                  barGroups: _barChartController.data
                                      .map(
                                        (e) => BarChartGroupData(
                                          showingTooltipIndicators: [0, 1],
                                          x: e.id,
                                          barsSpace: 10,
                                          barRods: [
                                            BarChartRodData(
                                              toY: e.y,
                                              width: 10,
                                              gradient: const LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [0.5, 1],
                                                colors: [
                                                  Color(0xff2F6782),
                                                  Color(0xffffffff),
                                                ],
                                              ),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                            ),
                                            BarChartRodData(
                                              toY: e.y,
                                              width: 10,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                stops: [0.9, 1],
                                                colors: [
                                                  Color(0xffaaaaaa),
                                                  Color(0xffffffff),
                                                ],
                                              ),
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(5),
                                                topRight: Radius.circular(5),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                      .toList()),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                  testing(),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }

  Container testing() {
    return Container(
      width: 50.0.w,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
    );
  }

  Widget topSection() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              InkWell(
                onTap: myZoomDrawerController.zoomDrawerController.toggle,
                child: const Image(
                  image: AssetImage('assets/images/menu.png'),
                ),
              ),
              SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Dashboard",
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16.0.sp),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "lafi s h m almutairi",
                    style: TextStyle(
                      fontSize: 13.0.sp,
                      color: Color(0xff858585),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.notifications_rounded,
                size: 30.0.sp,
                color: Color(0xffD1D1D1),
              ),
              SizedBox(width: 10),
              Image(
                image: AssetImage("assets/images/t.png"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _getOffset(GlobalKey key) {
    RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
    Offset? position = box?.localToGlobal(Offset.zero);
    if (position != null) {
      setState(() {
        _x = position.dx;
        _y = position.dy;
      });
    }
  }
}
