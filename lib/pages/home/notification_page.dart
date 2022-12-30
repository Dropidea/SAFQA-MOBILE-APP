import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: blackText("notifications".tr, 16),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.separated(
          itemBuilder: (context, index) => Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: w,
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE2E2E2),
                      ),
                      child: Image(
                        image: AssetImage(
                          index % 3 == 0
                              ? "assets/images/chart.png"
                              : index % 3 == 1
                                  ? "assets/images/create_invoice.png"
                                  : "assets/images/stamp.png",
                        ),
                        width: 40,
                        height: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            index % 3 == 0
                                ? "New Order 2022000044 Recieved"
                                : index % 3 == 1
                                    ? "Employee lafi s h m almutairi has created new invoice"
                                    : "Employee lafi s h m almutairi has created new invoice",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0.sp),
                          ),
                          SizedBox(height: 10),
                          greyText("07/09/2022 06:06 PM", 11),
                        ],
                      ),
                    )
                  ],
                ),
              ),
          separatorBuilder: (context, index) => Container(
                width: w,
                height: 2,
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                color: Color(0xffD8D8D8),
              ),
          itemCount: 20),
    );
  }
}
