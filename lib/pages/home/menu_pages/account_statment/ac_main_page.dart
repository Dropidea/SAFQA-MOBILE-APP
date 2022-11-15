import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/account_statment/ac_customer_details.dart';
import 'package:safqa/pages/home/menu_pages/account_statment/ac_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/account_statment/consolidated_tax_invoice.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class AccountStateMainPage extends StatefulWidget {
  AccountStateMainPage({super.key});

  @override
  State<AccountStateMainPage> createState() => AccountStateMainPageState();
}

class AccountStateMainPageState extends State<AccountStateMainPage> {
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
                    whiteText("Account Statment", 17,
                        fontWeight: FontWeight.w600),
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
                  padding: EdgeInsets.all(20),
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
                        hintText: "Search ...",
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => AccountStatmentSearchFilterPage(),
                                transition: Transition.downToUp);
                          },
                          child: Badge(
                            badgeColor: Color(0xff1BAFB2),
                            showBadge: true,
                            position: BadgePosition.topEnd(top: 8, end: 8),
                            child: Image(
                              image: AssetImage("assets/images/filter.png"),
                              width: 18,
                              height: 18,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ConsolidatedTaxInvoice());
                            },
                            child: Container(
                              width: 0.44 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xff66B4D2),
                                    Color(0xff2F6782),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Consolidated Tax Invoice",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: 0.44 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  end: Alignment.centerLeft,
                                  begin: Alignment.centerRight,
                                  colors: [
                                    Color(0xff66B4D2),
                                    Color(0xff2F6782),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Center(
                                child: Text(
                                  "Export Filtered as CSV",
                                  style: TextStyle(
                                    color: Colors.white,
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 12.0.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          blackText("Today", 15, fontWeight: FontWeight.bold),
                          greyText("09 October 2022", 15)
                        ],
                      ),
                      Expanded(
                          child: ListView.separated(
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => Get.to(
                              () => AccountStatmentCustomerDetailsPage()),
                          child: Container(
                            width: w,
                            height: 160,
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    blackText("VAT-2022000044", 14),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.watch_later_outlined,
                                          size: 20,
                                          color: Color(0xff8B8B8B),
                                        ),
                                        SizedBox(width: 10),
                                        greyText("20:21", 13)
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    greyText("Transaction Fees", 14),
                                    index % 2 == 0
                                        ? greenText("Credit", 14)
                                        : redText("Credit", 14)
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    blueText("\$ 4.777", 14,
                                        fontWeight: FontWeight.bold),
                                    index % 2 == 0
                                        ? greenText("0.058", 14)
                                        : redText("0.058", 14)
                                  ],
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                color: Color(0xffF8F8F8),
                                borderRadius: BorderRadius.circular(15)),
                          ),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20),
                        itemCount: 5,
                      ))
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
