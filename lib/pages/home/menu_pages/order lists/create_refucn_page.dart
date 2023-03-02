import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateRefundPage extends StatefulWidget {
  CreateRefundPage({super.key, required this.id});
  final int id;
  @override
  State<CreateRefundPage> createState() => _CreateRefundPageState();
}

class _CreateRefundPageState extends State<CreateRefundPage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController comments = TextEditingController();

  int sendDeduct = 0;
  int fullRefund = 0;
  bool deductRefundschargesFromCustomer = true;
  bool deductMyFatorah = true;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: blackText("refund".tr, 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: ListView(
              primary: false,
              children: [
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              inactiveBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              value: 0,
                              groupValue: fullRefund,
                              onChanged: (value) => setState(() {
                                    fullRefund = value;
                                  })),
                        ),
                        fullRefund == 0
                            ? blackText("full_refund".tr, 16)
                            : greyText("full_refund".tr, 16),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              inactiveBorderColor: Colors.transparent,
                              value: 1,
                              groupValue: fullRefund,
                              onChanged: (value) => setState(() {
                                    fullRefund = value;
                                  })),
                        ),
                        fullRefund == 1
                            ? blackText("partial_refund".tr, 16)
                            : greyText("partial_refund".tr, 16),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                blackText("amount".tr, 16),
                SignUpTextField(
                  padding: EdgeInsets.all(0),
                  controller: amountController,
                  keyBoardType: TextInputType.number,
                  hintText: "0 AED",
                  validator: (s) {
                    if (s!.isEmpty) return "Can't be empty";
                  },
                ),
                SizedBox(height: 10),
                greyText("p1".tr, 12),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              inactiveBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              value: 0,
                              groupValue: sendDeduct,
                              onChanged: (value) => setState(() {
                                    sendDeduct = value;
                                  })),
                        ),
                        sendDeduct == 0
                            ? blackText("send_refund".tr, 16)
                            : greyText("send_refund".tr, 16),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: GFRadio(
                              activeBorderColor: Colors.transparent,
                              radioColor: Color(0xff66B4D2),
                              inactiveIcon: Icon(
                                Icons.circle_outlined,
                                color: Colors.grey.shade300,
                              ),
                              size: GFSize.SMALL,
                              inactiveBorderColor: Colors.transparent,
                              value: 1,
                              groupValue: sendDeduct,
                              onChanged: (value) => setState(() {
                                    sendDeduct = value;
                                  })),
                        ),
                        sendDeduct == 1
                            ? blackText("deduct".tr, 16)
                            : greyText("deduct".tr, 16),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                      height: 30,
                      child: Checkbox(
                        activeColor: Color(0xff00A7B3),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ), // Rounded Checkbox
                        onChanged: (value) {
                          deductRefundschargesFromCustomer = value!;
                          setState(() {});
                        },
                        value: deductRefundschargesFromCustomer,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: blackText(
                      "p3".tr,
                      14,
                    )),
                  ],
                ),

                SizedBox(height: 20),
                Row(
                  children: [
                    SizedBox(
                      width: 25,
                      height: 30,
                      child: Checkbox(
                        activeColor: Color(0xff00A7B3),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ), // Rounded Checkbox
                        onChanged: (value) {
                          deductMyFatorah = value!;
                          setState(() {});
                        },
                        value: deductMyFatorah,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                        child: blackText(
                      "p4".tr,
                      14,
                    )),
                  ],
                ),
                SizedBox(height: 10),
                greyText("p2".tr, 12),
                SizedBox(height: 20),
                blackText("comments".tr, 16),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    onChanged: (value) {},
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                SizedBox(height: 20),

                // blackText("category_name_ar".tr, 16),
                // SignUpTextField(
                //   padding: EdgeInsets.all(0),
                //   controller: comments,
                //   validator: (s) {
                //     if (s!.isEmpty) return "Can't be empty";
                //   },
                // ),
                // SizedBox(height: 20),
                // blackText("is_active".tr, 16),
                // const SizedBox(height: 10),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      blackText("refund".tr, 16),
                      SizedBox(width: 10),
                      GestureDetector(
                        onTap: () async {
                          FocusScope.of(context).unfocus();
                          if (formKey.currentState!.validate()) {
                            MyDialogs.showSavedSuccessfullyDialoge(
                              title: "created_successfully".tr,
                              btnTXT: "close".tr,
                              onTap: () {
                                Get.back();
                                Get.back();
                                Get.back();
                              },
                            );
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(40),
                          ),
                          padding: EdgeInsets.all(20),
                          child: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 22.0.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
