import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/create_invoice/create_invoice_page.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/notification_page.dart';
import 'package:safqa/pages/home/pass_change_page.dart';
import 'package:safqa/pages/home/profile/profile.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/charts_controller.dart';
import '../../controllers/zoom_drawer_controller.dart';
import '../../widgets/month_year_dropdown.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  MyZoomDrawerController myZoomDrawerController = Get.find();
  AddInvoiceController addInvoiceController = Get.put(AddInvoiceController());

  SignUpController _signUpController = Get.put(SignUpController());

  ChartsController _chartsController = Get.put(ChartsController());
  CustomersController _customersController = Get.put(CustomersController());
  double _x = 0;
  double _y = 0;
  String i = "This Month";
  @override
  void initState() {
    // TODO: implement initState
    _customersController.getMyCustomers();
    _signUpController.getGlobalData();
    _signUpController.getBanks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: topSection(),
                ),
                Expanded(
                    child: Align(
                  child: ListView(
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(height: 10),
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
                                  fontSize: 22.0.sp,
                                  color: Color(0xff2F6782),
                                ),
                              ),
                              Text(
                                "Total Balance",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0.sp,
                                  color: Color(0xffAAAAAA),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40,
                            width: 125,
                            child: myDropdown(),
                          )
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 0.43 * w,
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
                                      color: Color(0xffCBCBCB),
                                      fontSize: 14.0.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: 0.43 * w,
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
                                  "33",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.0.sp,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  "Number Of Transactions",
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color(0xffCBCBCB),
                                      fontSize: 14.0.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 30),
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
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                              ),
                            ),
                            TextSpan(
                              text: ' Report',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        children: [
                          buildLegend(
                              "Number of paid invoices", Color(0xff2F6782)),
                          const SizedBox(height: 10),
                          buildLegend("Number of invoices", Color(0xffaaaaaa)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 0.3 * h,
                        width: w,
                        child: Align(
                          child: ListView(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            children: [
                              SizedBox(
                                height: 0.3 * h,
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
                                            getTitlesWidget: (value, meta) =>
                                                Text(_chartsController
                                                    .data[value.round()].name
                                                    .toString()),
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                      ), //                         alignment: BarChartAlignment.center,

                                      minY: 0,
                                      maxY: 100,
                                      groupsSpace: 12,
                                      barTouchData: BarTouchData(
                                        enabled: true,
                                        touchTooltipData: BarTouchTooltipData(
                                          tooltipBgColor: Colors.transparent,
                                          tooltipMargin: -10,
                                          getTooltipItem: (group, groupIndex,
                                                  rod, rodIndex) =>
                                              BarTooltipItem(
                                            rod.toY.round().toString(),
                                            TextStyle(),
                                          ),
                                        ),
                                      ),
                                      barGroups: _chartsController.data
                                          .map(
                                            (e) => BarChartGroupData(
                                              showingTooltipIndicators: [0, 1],
                                              x: e.id!,
                                              barsSpace: 10,
                                              barRods: [
                                                BarChartRodData(
                                                  toY: e.y!,
                                                  width: 10,
                                                  gradient:
                                                      const LinearGradient(
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
                                                    topRight:
                                                        Radius.circular(5),
                                                  ),
                                                ),
                                                BarChartRodData(
                                                  toY: e.y!,
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
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(5),
                                                    topRight:
                                                        Radius.circular(5),
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
                      const SizedBox(height: 30),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0.sp,
                          ),
                          children: const <TextSpan>[
                            TextSpan(
                              text: 'Balance',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                decorationThickness: 3,
                                decorationColor: Color(0xffaaaaaa),
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                              ),
                            ),
                            TextSpan(
                              text: ' Report',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Colors.transparent,
                                shadows: [
                                  Shadow(
                                      color: Colors.black,
                                      offset: Offset(0, -5))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildLegend2(
                                  "50 K", "Total Balance", Color(0xff2F6782)),
                              SizedBox(height: 10),
                              buildLegend2("25 K", "Awaiting Balance",
                                  Color(0xffE4E4E4)),
                              SizedBox(height: 10),
                              buildLegend2("25 K", "Awaiting to Transfer",
                                  Color(0xff00A7B3)),
                            ],
                          ),
                          Stack(
                            children: [
                              SizedBox(
                                height: 0.25 * h,
                                width: 0.4 * w,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "50 K",
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        "Total Balance",
                                        style: TextStyle(
                                            fontSize: 12.0.sp,
                                            color: Color(0xff9D9D9D)),
                                        textAlign: TextAlign.start,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 0.25 * h,
                                width: 0.4 * w,
                                child: PieChart(
                                  PieChartData(
                                    sectionsSpace: 0,
                                    sections: _chartsController.getSectins(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ))
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              child: GestureDetector(
                onTap: () => Get.to(
                  () => CreateInvoicePage(),
                  transition: Transition.rightToLeft,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 4.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0), // shadow direction: bottom right
                      )
                    ],
                  ),
                  height: 60,
                  width: w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Create New Invoice",
                        style: TextStyle(
                            fontSize: 17.0.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(width: 10),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(40),
                            color: Colors.teal),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 20.0.sp,
                        ),
                      )
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Row buildLegend2(String t1, String t2, Color c) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 15,
          height: 16,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
            color: c,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t1,
              style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 5),
            Text(
              t2,
              style: TextStyle(fontSize: 12.0.sp, color: Color(0xff9D9D9D)),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ],
    );
  }

  Row buildLegend(String text, Color color) {
    return Row(
      children: [
        Container(
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: color,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(fontSize: 13.0.sp),
        ),
      ],
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
    return Row(
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
            const SizedBox(width: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Dashboard",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0.sp),
                ),
                const SizedBox(height: 10),
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
            GestureDetector(
              onTap: () => Get.to(
                () => NotificationPage(),
                transition: Transition.downToUp,
              ),
              child: Stack(
                children: [
                  Image(
                    image: AssetImage("assets/images/notification.png"),
                    width: 25.0.sp,
                    height: 25.0.sp,
                  ),
                  Visibility(
                    visible: true,
                    //TODO:notifications
                    child: Positioned(
                      top: 0.0.sp,
                      right: 5.0.sp,
                      child: new Icon(
                        Icons.brightness_1,
                        size: 12.0,
                        color: Color(0xffDE6464),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            MyPopUpMenu(
              menuList: [
                PopupMenuItem(
                    onTap: () {
                      Future(() => Get.to(() => ProfilePage(),
                          transition: Transition.rightToLeft));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            EvaIcons.personOutline,
                            size: 20,
                            color: Color.fromARGB(255, 118, 118, 118),
                          ),
                        ),
                        SizedBox(width: 5),
                        greyText("Profile", 12, fontWeight: FontWeight.bold),
                      ],
                    )),
                PopupMenuItem(
                    onTap: () {
                      Future(() => Get.to(() => PasswordChangePage(),
                          transition: Transition.rightToLeft));
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Icon(
                            EvaIcons.lockOutline,
                            size: 20,
                            color: Color.fromARGB(255, 118, 118, 118),
                          ),
                        ),
                        SizedBox(width: 5),
                        greyText("Change Password", 12,
                            fontWeight: FontWeight.bold),
                      ],
                    )),
              ],
              widget: Image(
                image: AssetImage("assets/images/t.png"),
                width: 30.0.sp,
                height: 30.0.sp,
                fit: BoxFit.cover,
              ),
            )
          ],
        ),
      ],
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
