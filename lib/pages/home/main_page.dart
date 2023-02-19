import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/payment_link_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/create_invoice/create_invoice_page.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/pages/home/notification_page.dart';
import 'package:safqa/pages/home/pass_change_page.dart';
import 'package:safqa/pages/home/profile/profile.dart';
import 'package:safqa/pages/identity/identity_docs_page.dart';
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
  BankController _bankController = Get.put(BankController());

  ChartsController _chartsController = Get.put(ChartsController());
  CustomersController _customersController = Get.put(CustomersController());
  InvoicesController _invoicesController = Get.put(InvoicesController());
  GlobalDataController _globlDataController = Get.find();
  LocalsController _localsController = Get.find();
  final PaymentLinkController _paymentLinkController =
      Get.put(PaymentLinkController());
  double _x = 0;
  double _y = 0;
  bool engFlag = true;
  @override
  void initState() {
    engFlag = _localsController.currenetLocale == 0;
    if (_globlDataController.me.isSuperAdmin == null) {
      _customersController.getMyCustomers();
    }
    _signUpController.getGlobalData();
    _invoicesController.getInvoices();
    _bankController.getAllBanks();
    _globlDataController.getCountries();
    _globlDataController.getCities();
    _globlDataController.getAreas();
    _globlDataController.getAdressTypes();
    _globlDataController.getRoles();
    _globlDataController.getSendOptions();
    _globlDataController.getContactUsInfo();
    _globlDataController.getLanguages();
    _globlDataController.getRecurringInterval();

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
                  child: topSection(
                      name: _globlDataController.me.fullName ??
                          _globlDataController.me.name ??
                          "no name"),
                ),
                Expanded(
                    child: Align(
                  child: ListView(
                    primary: false,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      const SizedBox(height: 10),
                      Container(
                        // width: w,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Color(0xffE47E7B).withOpacity(0.07),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              EvaIcons.alertCircle,
                              color: Color(0xffE47E7B),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText(
                                      engFlag
                                          ? "The identity must be documented first in order to be able to perform any operation on the system."
                                          : "يجب توثيق الهوية أولاً حتى تتمكن من إجراء أي عملية على النظام.",
                                      13),
                                  GestureDetector(
                                    onTap: () async {
                                      // await _globlDataController
                                      //     .getContactUsInfo();
                                      Get.to(() => IdentityConfirmDocsPage(),
                                          transition: Transition.downToUp);
                                    },
                                    child: blueText(
                                        engFlag
                                            ? "Confirm Your Identity now"
                                            : "قم بتأكيد هويتك الآن",
                                        13,
                                        fontWeight: FontWeight.bold,
                                        underline: true),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
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
                                engFlag ? "Total Balance" : "إجمالي الرصيد",
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
                                  engFlag ? "Total Balance" : "إجمالي الرصيد",
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
                                  engFlag
                                      ? "Number Of Transactions"
                                      : "عدد المعاملات",
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
                            fontSize: 18.0.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: engFlag ? 'Invoices' : "تقرير ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              text: engFlag ? ' Report' : "الفواتير",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              engFlag
                                  ? "Number of paid invoices"
                                  : "عدد الفواتير المدفوعة",
                              Color(0xff2F6782)),
                          const SizedBox(height: 10),
                          buildLegend(
                              engFlag ? "Number of invoices" : "عدد الفواتير",
                              Color(0xffaaaaaa)),
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
                            // fontWeight: FontWeight.w500,
                            fontSize: 18.0.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: engFlag ? 'Balance' : "تقرير ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              text: engFlag ? ' Report' : "الرصيد",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                                  "50 K",
                                  engFlag ? "Total Balance" : "إجمالي الرصيد",
                                  Color(0xff2F6782)),
                              SizedBox(height: 10),
                              buildLegend2(
                                  "25 K",
                                  engFlag
                                      ? "Awaiting Balance"
                                      : "الرصيد في الانتظار",
                                  Color(0xffE4E4E4)),
                              SizedBox(height: 10),
                              buildLegend2(
                                  "25 K",
                                  engFlag
                                      ? "Awaiting to Transfer"
                                      : "في انتظار النقل",
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
                                        engFlag
                                            ? "Total Balance"
                                            : "إجمالي الرصيد",
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
                      SizedBox(height: 10),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            // fontWeight: FontWeight.w500,
                            fontSize: 18.0.sp,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: engFlag ? 'Payment' : "طرق ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                              text: engFlag ? ' Methods' : "الدفع",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
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
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  padding: EdgeInsets.all(20),
                                  width: w / 2,
                                  height: 130,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 7),
                                            child: Icon(EvaIcons.creditCard),
                                          ),
                                          SizedBox(width: 5),
                                          greyText("VISA/MasterCard", 13,
                                              fontWeight: FontWeight.bold)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          greyText(
                                            "Transaction No:",
                                            13,
                                          ),
                                          SizedBox(width: 5),
                                          blueText("2", 13)
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          greyText(
                                            "Total Value:",
                                            13,
                                          ),
                                          SizedBox(width: 5),
                                          blueText("200\$", 13)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 60),
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
                        "create_new_invoice".tr,
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

  Widget topSection({required String name}) {
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
                  engFlag ? "Dashboard" : "لوحة التحكم",
                  style:
                      TextStyle(fontWeight: FontWeight.w500, fontSize: 16.0.sp),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
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
            _globlDataController.me.isSuperAdmin != null
                ? Container()
                : MyPopUpMenu(
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
                              greyText(engFlag ? "Profile" : "الملف الشخصي", 12,
                                  fontWeight: FontWeight.bold),
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
                              greyText(
                                  engFlag
                                      ? "Change Password"
                                      : "تغيير كلمة السر",
                                  12,
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
