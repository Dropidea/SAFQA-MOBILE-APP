import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_add_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_details.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class CustomersMainPage extends StatefulWidget {
  CustomersMainPage({super.key});

  @override
  State<CustomersMainPage> createState() => CustomersMainPageState();
}

class CustomersMainPageState extends State<CustomersMainPage> {
  CustomersController _customersController = Get.find();
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
          Column(
            children: [
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                    whiteText("customers".tr, 17, fontWeight: FontWeight.w600),
                    Opacity(
                      opacity: 0,
                      child: whiteText("text", 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: w,
                  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      SignUpTextField(
                        hintText: "search".tr,
                        onchanged: (s) {
                          _customersController.searchForCustomerWithName(s!);
                          setState(() {});
                        },
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => CustomerSearchFilterPage());
                          },
                          child: GetBuilder<CustomersController>(builder: (c) {
                            return Badge(
                              badgeColor: Color(0xff1BAFB2),
                              showBadge: c.customerFilter.filterActive,
                              position: BadgePosition.topEnd(top: 8, end: 8),
                              child: Image(
                                image: AssetImage("assets/images/filter.png"),
                                width: 18,
                                height: 18,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => AddCustomerPage());
                            },
                            child: Container(
                              width: 0.45 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xff2F6782).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Color(0xff2F6782),
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  Text(
                                    "create_customer".tr,
                                    style: TextStyle(
                                      color: Color(0xff2F6782),
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //TODO:
                            },
                            child: Container(
                              width: 0.45 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xff8B8B8B).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.file_download_outlined,
                                      color: Color(0xff8B8B8B),
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  Text(
                                    "import_customer".tr,
                                    style: TextStyle(
                                      color: Color(0xff8B8B8B),
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            listBTN(
                                text: "copy".tr, onTap: () {}, width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(
                              text: "print/pdf".tr,
                              onTap: () {},
                            ),
                            SizedBox(width: 5),
                            listBTN(
                                text: "Excel", onTap: () {}, width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(text: "CSV", onTap: () {}, width: w / 4.5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: GetBuilder<CustomersController>(builder: (c) {
                          return c.getCustomerFlag
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : c.customersToShow.length == 0
                                  ? Center(
                                      child: greyText("nothing_to_show".tr, 20),
                                    )
                                  : ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      primary: false,
                                      itemBuilder: (context, index) => ListTile(
                                          onTap: () {
                                            Get.to(() => CustomerDetailsPage(
                                                  customer:
                                                      c.customersToShow[index],
                                                ));
                                          },
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              blackText(
                                                c.customersToShow[index]
                                                    .fullName!,
                                                14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              greyText(
                                                  c.customersToShow[index]
                                                      .phoneNumber!,
                                                  13)
                                            ],
                                          ),
                                          dense: true,
                                          visualDensity:
                                              VisualDensity(vertical: 4),
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffF9F9F9),
                                            ),
                                            child: Center(
                                              child: greyText(
                                                  c.customersToShow[index]
                                                      .fullName![0],
                                                  15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 20,
                                      ),
                                      itemCount: c.customersToShow.length,
                                    );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
