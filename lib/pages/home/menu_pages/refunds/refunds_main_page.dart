import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/pages/home/menu_pages/refunds/refund_details_page.dart';
import 'package:safqa/pages/home/menu_pages/refunds/refunds_search_filter.dart';
import 'package:safqa/pages/home/menu_pages/refunds/widgets/refund_widget.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class RefundsMainPage extends StatefulWidget {
  RefundsMainPage({super.key});

  @override
  State<RefundsMainPage> createState() => _RefundsMainPageState();
}

class _RefundsMainPageState extends State<RefundsMainPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                        whiteText("refunds".tr, 17,
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
                        child: Column(
                          children: [
                            SizedBox(height: 40),
                            SignUpTextField(
                              padding: EdgeInsets.all(0),
                              hintText: "search".tr,
                              prefixIcon: Icon(
                                Icons.search_outlined,
                                color: Colors.grey,
                              ),
                              textInputAction: TextInputAction.search,
                              onchanged: (s) {
                                setState(() {});
                              },
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  FocusScope.of(context).unfocus();
                                  Get.to(() => RefundsSearchFilter());
                                },
                                child: Badge(
                                  badgeColor: Color(0xff1BAFB2),
                                  showBadge: true,
                                  position:
                                      BadgePosition.topEnd(top: 8, end: 8),
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/filter.png"),
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              height: 40,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  listBTN(text: "copy".tr, onTap: () {}),
                                  SizedBox(width: 5),
                                  listBTN(text: "print/pdf".tr, onTap: () {}),
                                  SizedBox(width: 5),
                                  listBTN(text: "Excel", onTap: () {}),
                                  SizedBox(width: 5),
                                  listBTN(text: "CSV", onTap: () {}),
                                  SizedBox(width: 5),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Expanded(
                              child: ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) => RefundWidget(
                                        onTap: () {
                                          Get.to(() => RefundsDetailsPage());
                                        },
                                      ),
                                  separatorBuilder: (context, index) =>
                                      SizedBox(height: 10),
                                  itemCount: 10),
                            )
                          ],
                        )),
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
