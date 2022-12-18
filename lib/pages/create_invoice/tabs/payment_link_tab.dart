import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/radio/gf_radio.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/payment_link_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/models/payment_link.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class CreatePaymentLinkTab extends StatefulWidget {
  const CreatePaymentLinkTab({super.key, this.paymentLinkToEdit});
  final PaymentLink? paymentLinkToEdit;

  @override
  State<CreatePaymentLinkTab> createState() => _CreatePaymentLinkTabState();
}

class _CreatePaymentLinkTabState extends State<CreatePaymentLinkTab> {
  int langValue = 1;
  int termsAndConditions = 0;
  int paymentActive = 0;
  int paymentopen = 0;
  bool fixedPriceFlag = true;
  bool termsFlag = false;
  final formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find();
  TextEditingController textEditingController1 =
      TextEditingController(text: 'dd/MM/yyyy');
  TextEditingController textEditingController2 =
      TextEditingController(text: '00:00');

  final PaymentLinkController _paymentLinkController = Get.find();
  PaymentLink paymentLinkToCreate = PaymentLink();

  @override
  void initState() {
    if (widget.paymentLinkToEdit != null) {
      termsFlag = widget.paymentLinkToEdit!.termsAndConditions != null;
      fixedPriceFlag = widget.paymentLinkToEdit!.paymentAmount != null;
      langValue = widget.paymentLinkToEdit!.language!.id!;
      termsAndConditions = termsFlag ? 1 : 0;
      paymentopen = widget.paymentLinkToEdit!.openAmount!;
      paymentActive = widget.paymentLinkToEdit!.isActive ?? 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText("pl_id".tr, 14),
                    const SizedBox(height: 5),
                    greyText(
                        widget.paymentLinkToEdit != null
                            ? widget.paymentLinkToEdit!.id.toString()
                            : "2659986 / 2022000048",
                        12),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText("pl_date".tr, 14),
                    const SizedBox(height: 5),
                    greyText(
                        widget.paymentLinkToEdit != null
                            ? DateFormat('dd-MMM-y').format(DateTime.parse(
                                widget.paymentLinkToEdit!.createdAt!))
                            : DateFormat('dd-MMM-y').format(DateTime.now()),
                        12),
                  ],
                )
              ],
            ),
            const SizedBox(height: 30),
            blackText("pl_url_title".tr, 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              onchanged: (s) {
                if (widget.paymentLinkToEdit != null) {
                  widget.paymentLinkToEdit!.paymentTitle = s!;
                } else {
                  paymentLinkToCreate.paymentTitle = s!;
                }
              },
              initialValue: widget.paymentLinkToEdit != null
                  ? widget.paymentLinkToEdit!.paymentTitle
                  : null,
              validator: (s) {
                if (s!.isEmpty) return "required";
              },
            ),
            const SizedBox(height: 20),
            blackText("pl_active".tr, 16),
            const SizedBox(height: 10),
            Row(
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
                          groupValue: paymentActive,
                          onChanged: (value) => setState(() {
                                paymentActive = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.isActive = 1;
                                } else {
                                  paymentLinkToCreate.isActive = 1;
                                }
                              })),
                    ),
                    greyText("yes".tr, 16),
                  ],
                ),
                SizedBox(width: 20),
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
                          groupValue: paymentActive,
                          onChanged: (value) => setState(() {
                                paymentActive = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.isActive = 0;
                                } else {
                                  paymentLinkToCreate.isActive = 0;
                                }
                              })),
                    ),
                    greyText("no".tr, 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            blackText("pl_open".tr, 16),
            const SizedBox(height: 10),
            Row(
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
                          groupValue: paymentopen,
                          onChanged: (value) => setState(() {
                                paymentopen = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.openAmount = 0;
                                } else {
                                  paymentLinkToCreate.openAmount = 0;
                                }
                              })),
                    ),
                    greyText("yes".tr, 16),
                  ],
                ),
                SizedBox(width: 20),
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
                          groupValue: paymentopen,
                          onChanged: (value) => setState(() {
                                paymentopen = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.openAmount = 1;
                                } else {
                                  paymentLinkToCreate.openAmount = 1;
                                }
                              })),
                    ),
                    greyText("no".tr, 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            blackText("f_p".tr, 16),
            CustomDropdown(
              width: w,
              items: ["yes".tr, "no".tr],
              onchanged: (String? v) {
                if (v == "yes".tr) {
                  fixedPriceFlag = true;
                  if (widget.paymentLinkToEdit != null) {
                    widget.paymentLinkToEdit!.minAmount = null;
                    widget.paymentLinkToEdit!.maxAmount = null;
                  } else {
                    paymentLinkToCreate.minAmount = null;
                    paymentLinkToCreate.maxAmount = null;
                  }
                } else {
                  if (widget.paymentLinkToEdit != null) {
                    widget.paymentLinkToEdit!.paymentAmount = null;
                  } else {
                    paymentLinkToCreate.paymentAmount = null;
                  }
                  fixedPriceFlag = false;
                }
                setState(() {});
              },
              selectedItem: fixedPriceFlag ? "yes".tr : "no".tr,
            ),
            const SizedBox(height: 20),
            fixedPriceFlag ? blackText("p_v".tr, 16) : Container(),
            fixedPriceFlag
                ? SignUpTextField(
                    padding: EdgeInsets.all(0),
                    onchanged: (s) {
                      if (widget.paymentLinkToEdit != null) {
                        widget.paymentLinkToEdit!.paymentAmount = s;
                      } else {
                        paymentLinkToCreate.paymentAmount = s;
                      }
                    },
                    validator: (s) {
                      if (s!.isEmpty) return "required";
                    },
                    initialValue: widget.paymentLinkToEdit != null
                        ? widget.paymentLinkToEdit!.paymentAmount
                        : null,
                  )
                : Container(),
            !fixedPriceFlag
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText("min_v".tr, 15),
                          SignUpTextField(
                            padding: EdgeInsets.all(0),
                            width: 0.4 * w,
                            onchanged: (s) {
                              if (widget.paymentLinkToEdit != null) {
                                widget.paymentLinkToEdit!.minAmount = s;
                              } else {
                                paymentLinkToCreate.minAmount = s;
                              }
                            },
                            initialValue: widget.paymentLinkToEdit != null
                                ? widget.paymentLinkToEdit!.minAmount
                                : null,
                            validator: (s) {
                              if (s!.isEmpty) return "required";
                            },
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          blackText("max_v".tr, 15),
                          SignUpTextField(
                            padding: EdgeInsets.all(0),
                            width: 0.4 * w,
                            initialValue: widget.paymentLinkToEdit != null
                                ? widget.paymentLinkToEdit!.maxAmount
                                : null,
                            onchanged: (s) {
                              if (widget.paymentLinkToEdit != null) {
                                widget.paymentLinkToEdit!.maxAmount = s;
                              } else {
                                paymentLinkToCreate.maxAmount = s;
                              }
                            },
                            validator: (s) {
                              if (s!.isEmpty) return "required";
                            },
                          )
                        ],
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            blackText("currency".tr, 16),
            Builder(
              builder: (_) {
                List countries = _signUpController.globalData['country'];
                List<String> ids = countries
                    .map<String>(
                      (e) => e['id'].toString(),
                    )
                    .toList();
                List<String> countriesCurrencies = countries
                    .map<String>(
                      (e) => e['currency'].toString(),
                    )
                    .toList();

                return CustomDropdown(
                  items: countriesCurrencies,
                  selectedItem: widget.paymentLinkToEdit != null
                      ? widget.paymentLinkToEdit!.currency!.currency
                      : countriesCurrencies[0],
                  width: w,
                  onchanged: (s) {
                    if (widget.paymentLinkToEdit != null) {
                      widget.paymentLinkToEdit!.currencyId =
                          int.parse(ids[countriesCurrencies.indexOf(s!)]);
                    } else {
                      paymentLinkToCreate.currencyId =
                          int.parse(ids[countriesCurrencies.indexOf(s!)]);
                    }
                  },
                );
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                blackText("comments".tr, 16),
                SizedBox(width: 10),
                greyText("(${"optional".tr})", 13)
              ],
            ),
            Container(
              width: w,
              margin: const EdgeInsets.symmetric(vertical: 5),
              padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
              decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                maxLines: 3,
                decoration: const InputDecoration(border: InputBorder.none),
                controller: TextEditingController(
                    text: widget.paymentLinkToEdit != null
                        ? widget.paymentLinkToEdit!.comment
                        : null),
                onChanged: (value) {
                  if (widget.paymentLinkToEdit != null) {
                    widget.paymentLinkToEdit!.comment = value;
                  } else {
                    paymentLinkToCreate.comment = value;
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            blackText("pl_lang".tr, 16),
            const SizedBox(height: 10),
            Row(
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
                          value: 1,
                          groupValue: langValue,
                          onChanged: (value) => setState(() {
                                langValue = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.languageId = 1;
                                } else {
                                  paymentLinkToCreate.languageId = 1;
                                }
                              })),
                    ),
                    greyText("english".tr, 16),
                  ],
                ),
                SizedBox(width: 20),
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
                          value: 2,
                          groupValue: langValue,
                          onChanged: (value) => setState(() {
                                langValue = value;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.languageId = 2;
                                } else {
                                  paymentLinkToCreate.languageId = 2;
                                }
                              })),
                    ),
                    greyText("arabic".tr, 16),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            blackText("terms_conditions".tr, 16),
            const SizedBox(height: 10),
            Row(
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
                          groupValue: termsAndConditions,
                          onChanged: (value) => setState(() {
                                termsAndConditions = value;
                                termsFlag = false;
                                if (widget.paymentLinkToEdit != null) {
                                  widget.paymentLinkToEdit!.termsAndConditions =
                                      null;
                                } else {
                                  paymentLinkToCreate.termsAndConditions = null;
                                }
                              })),
                    ),
                    greyText("disable".tr, 16),
                  ],
                ),
                SizedBox(width: 20),
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
                          groupValue: termsAndConditions,
                          onChanged: (value) => setState(() {
                                termsAndConditions = value;
                                termsFlag = true;
                              })),
                    ),
                    greyText("enable".tr, 16),
                  ],
                ),
              ],
            ),
            !termsFlag ? const SizedBox(height: 20) : Container(),
            !termsFlag
                ? const SizedBox(height: 20)
                : Container(
                    width: w,
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                    decoration: BoxDecoration(
                      color: Color(0xffF8F8F8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      maxLines: 3,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      controller: TextEditingController(
                          text: widget.paymentLinkToEdit != null
                              ? widget.paymentLinkToEdit!.termsAndConditions
                              : null),
                      onChanged: (value) {
                        if (widget.paymentLinkToEdit != null) {
                          widget.paymentLinkToEdit!.termsAndConditions = value;
                        } else {
                          paymentLinkToCreate.termsAndConditions = value;
                        }
                      },
                    ),
                  ),
            CircularGoBTN(
              text: widget.paymentLinkToEdit != null
                  ? "edit_payment_link".tr
                  : "create_link".tr,
              onTap: () async {
                if (formKey.currentState!.validate()) {
                  FocusScope.of(context).unfocus();

                  if (widget.paymentLinkToEdit != null) {
                    await _paymentLinkController
                        .editPaymentLink(widget.paymentLinkToEdit!);
                  } else {
                    paymentLinkToCreate.isActive ??= 1;
                    paymentLinkToCreate.openAmount ??= 0;
                    paymentLinkToCreate.currencyId ??= 1;
                    paymentLinkToCreate.languageId ??= 1;
                    await _paymentLinkController
                        .createPaymentLink(paymentLinkToCreate);
                  }
                }

                // if (paymentLinkToCreate.paymentAmount == null &&
                //     paymentLinkToCreate.maxAmount == null &&
                //     paymentLinkToCreate.minAmount == null) {
                //   Get.showSnackbar(GetSnackBar(
                //     duration: Duration(milliseconds: 2000),
                //     backgroundColor: Colors.red,
                //     message: "You have to specify payment amount",
                //   ));
                // }
              },
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       blackText(, 16),
            //       SizedBox(width: 10),
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Colors.black,
            //           borderRadius: BorderRadius.circular(40),
            //         ),
            //         padding: EdgeInsets.all(20),
            //         child: Icon(
            //           Icons.arrow_forward,
            //           color: Colors.white,
            //           size: 22.0.sp,
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
