import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/addresses/tabs/address%20types/address_type_tab.dart';
import 'package:safqa/admin/pages/addresses/tabs/areas/areas_tab.dart';
import 'package:safqa/admin/pages/addresses/tabs/cities/cities_tab.dart';
import 'package:safqa/admin/pages/addresses/tabs/countries/countries_tab.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class AddressesMainPage extends StatefulWidget {
  AddressesMainPage({super.key});

  @override
  State<AddressesMainPage> createState() => _AddressesMainPageState();
}

class _AddressesMainPageState extends State<AddressesMainPage> {
  int selectedTab = 0;
  List<String> tabsNames = [
    "countries".tr,
    "cities".tr,
    "areas".tr,
    "address_type".tr,
  ];
  ContactController contactController = Get.put(ContactController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget getPage() {
    switch (selectedTab) {
      case 0:
        return CountriesTab();
      case 1:
        return CitiesTab();
      case 2:
        return AreasTab();
      default:
        return AddressTypesTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const ZeroAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h,
          ),
          Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 90,
                    margin: const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 22.0.sp,
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      width: w,
                      // padding: EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: getPage(),
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 75,
                        margin:
                            const EdgeInsets.only(left: 20, top: 5, bottom: 5),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Align(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTab = index;
                              });
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: index == selectedTab
                                      ? LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xff66B4D2),
                                            Color(0xff2F6782),
                                          ],
                                        )
                                      : null,
                                  color: index != selectedTab
                                      ? Colors.white
                                      : null,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 7,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ]),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              margin: EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                  top: index == selectedTab ? 2 : 0),
                              child: Center(
                                child: index == selectedTab
                                    ? whiteText(tabsNames[index], 12)
                                    : greyText(tabsNames[index], 12),
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: tabsNames.length,
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
