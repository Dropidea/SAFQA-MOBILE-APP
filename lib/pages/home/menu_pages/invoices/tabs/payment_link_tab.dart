import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class PaymentLinkTab extends StatefulWidget {
  const PaymentLinkTab({super.key});

  @override
  State<PaymentLinkTab> createState() => _PaymentLinkTabState();
}

class _PaymentLinkTabState extends State<PaymentLinkTab> {
  List<bool> isToggled = List.filled(3, true);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [blackText("Today", 16), greyText("09 October 2022", 14)],
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: w,
              height: 170,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildAttachSection(),
                      Row(
                        children: [
                          Text(
                            isToggled[index] ? "Active" : "Inactive",
                            style: TextStyle(
                              color: isToggled[index]
                                  ? Color(0xff1BAFB2)
                                  : Colors.grey,
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          FlutterSwitch(
                            height: 30.0,
                            width: 60.0,
                            padding: 4.0,
                            toggleSize: 30.0,
                            borderRadius: 20.0,
                            activeColor: Color(0xff1BAFB2),
                            value: isToggled[index],
                            onToggle: (value) {
                              logSuccess(value);
                              setState(() {
                                isToggled[index] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      blackText("\$ 400.00", 16)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      greyText("06:06 PM", 14)
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20);
          },
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            blackText("Yesterday", 16),
            greyText("08 October 2022", 14)
          ],
        ),
        ListView.separated(
          shrinkWrap: true,
          primary: false,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              width: w,
              height: 170,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildAttachSection(),
                      Row(
                        children: [
                          Text(
                            isToggled[index] ? "Active" : "Inactive",
                            style: TextStyle(
                              color: isToggled[index]
                                  ? Color(0xff1BAFB2)
                                  : Colors.grey,
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 10),
                          FlutterSwitch(
                            height: 30.0,
                            width: 60.0,
                            padding: 4.0,
                            toggleSize: 30.0,
                            borderRadius: 20.0,
                            activeColor: Color(0xff1BAFB2),
                            value: isToggled[index],
                            onToggle: (value) {
                              logSuccess(value);
                              setState(() {
                                isToggled[index] = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      blackText("\$ 400.00", 16)
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "2",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                      greyText("06:06 PM", 14)
                    ],
                  ),
                ],
              ),
            );
          },
          itemCount: 3,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(height: 20);
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Row buildAttachSection() {
    return Row(
      children: [
        Icon(
          Icons.attach_file,
        ),
        SizedBox(width: 10),
        Text(
          "#2246721531",
          style: TextStyle(
            color: Colors.black,
            fontSize: 13.0.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
