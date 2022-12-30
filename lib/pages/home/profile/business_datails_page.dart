import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import "package:flutter/material.dart";
import "package:get/get.dart";
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/profile/controller/profile_controller.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class BusinessDetailsPage extends StatefulWidget {
  BusinessDetailsPage({super.key});

  @override
  State<BusinessDetailsPage> createState() => _BusinessDetailsPageState();
}

class _BusinessDetailsPageState extends State<BusinessDetailsPage> {
  TextEditingController workPhoneController =
      TextEditingController(text: "0987765123");
  ProfileController _profileController = Get.find();
  LocalsController _localsController = Get.put(LocalsController());
  bool readOnly = true;
  late ProfileBusines _profileBusines;
  @override
  void initState() {
    _profileBusines =
        ProfileBusines.fromJson(_profileController.profileBusines!.toJson());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "business_details".tr),
      body: Container(
        width: w,
        height: h,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            readOnly
                ? MyButton(
                    color: Color(0xffDDF5D8),
                    borderRadius: 10,
                    text: "edit".tr,
                    textSize: 15,
                    heigt: 50,
                    width: w - 50,
                    func: () {
                      setState(() {
                        readOnly = !readOnly;
                      });
                    },
                    textColor: Color(0xff58D241),
                    icon: Icon(
                      EvaIcons.edit,
                      color: Color(0xff58D241),
                    ),
                    border: Border.all(
                      color: Color(0xff58D241).withOpacity(0.4),
                    ),
                  )
                : MyButton(
                    color: Color.fromARGB(255, 216, 225, 245),
                    borderRadius: 10,
                    text: "save".tr,
                    textSize: 15,
                    heigt: 50,
                    width: w - 50,
                    func: () async {
                      setState(() {
                        readOnly = !readOnly;
                      });
                      await _profileController
                          .editProfileBusiness(_profileBusines);
                    },
                    textColor: Color(0xff66B4D2),
                    icon: Icon(
                      EvaIcons.checkmarkCircle,
                      color: Color(0xff66B4D2),
                    ),
                    border: Border.all(
                      color: Color(0xff66B4D2).withOpacity(0.4),
                    ),
                  ),
            Expanded(
                child: ListView(
              padding: EdgeInsets.all(20),
              primary: false,
              children: [
                blackText("company_name".tr, 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  onchanged: (s) {
                    _profileBusines.companyName = s;
                  },
                  initialValue: _profileBusines.companyName,
                ),
                const SizedBox(height: 20),
                blackText("category".tr, 14),
                GetBuilder<SignUpController>(builder: (c) {
                  List categories = c.globalData["category"];
                  String x = "";
                  for (var i in categories) {
                    if (i["id"] == _profileBusines.categoryId) {
                      x = _localsController.currenetLocale == 0
                          ? i["name_en"]
                          : i["name_ar"];
                      break;
                    }
                  }
                  return CustomDropdown(
                    width: w,
                    items: categories
                        .map((e) => _localsController.currenetLocale == 0
                            ? e["name_en"].toString()
                            : e["name_ar"].toString())
                        .toList(),
                    onchanged: readOnly
                        ? null
                        : (s) {
                            for (var i in categories) {
                              if (i["name_en"] == s || i["name_ar"] == s) {
                                _profileBusines.categoryId = i["id"];
                              }
                            }
                          },
                    selectedItem: x,
                    height: 60,
                  );
                }),
                const SizedBox(height: 20),
                blackText("user_name".tr, 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: _localsController.currenetLocale == 0
                      ? _profileBusines.nameEn
                      : _profileBusines.nameAr,
                  onchanged: (s) {
                    if (_localsController.currenetLocale == 0) {
                      _profileBusines.nameEn = s;
                    } else {
                      _profileBusines.nameAr = s;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("work_email".tr, 14),
                    const SizedBox(width: 10),
                    greyText("(${"optional".tr})", 13)
                  ],
                ),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: _profileBusines.workEmail,
                  onchanged: (s) {
                    _profileBusines.workEmail = s;
                  },
                  suffixIcon: Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Color(0xff58D241),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("work_phone", 14),
                    const SizedBox(width: 10),
                    greyText("(${"optional".tr})", 13)
                  ],
                ),
                Stack(
                  children: [
                    // IntlPhoneField(
                    //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
                    //   dropdownIconPosition: IconPosition.trailing,
                    //   keyboardType: TextInputType.number,
                    //   readOnly: readOnly,
                    //   decoration: InputDecoration(
                    //     fillColor: Color(0xffF8F8F8),
                    //     filled: readOnly,
                    //     border: OutlineInputBorder(
                    //         borderRadius: new BorderRadius.circular(10.0),
                    //         borderSide: BorderSide.none),
                    //   ),
                    //   initialCountryCode: 'IN',
                    //   initialValue: ,
                    //   textAlign: TextAlign.start,
                    //   onChanged: (phone) {},
                    //   onCountryChanged: (value) {},
                    //   controller: workPhoneController,
                    // ),
                    GetBuilder<SignUpController>(builder: (c) {
                      List countries = c.globalData['country'];
                      List<String> ids = countries
                          .map<String>(
                            (e) => e['id'].toString(),
                          )
                          .toSet()
                          .toList();
                      List<String> countriesCodes = countries
                          .map<String>(
                            (e) => e['code'].toString(),
                          )
                          .toSet()
                          .toList();
                      c.selectPhoneNumberManagerCodeDrop(countriesCodes[
                          ids.indexOf(
                              _profileBusines.phoneNumberCodeId!.toString())]);
                      return SignUpTextField(
                        readOnly: readOnly,
                        initialValue: _profileBusines.phoneNumber,
                        onchanged: (s) {
                          _profileBusines.phoneNumber = s;
                        },
                        padding: EdgeInsets.all(0),
                        keyBoardType: TextInputType.number,
                        prefixIcon: SizedBox(
                          width: 80,
                          child: DropdownButtonFormField<String>(
                            decoration:
                                const InputDecoration(border: InputBorder.none),
                            isExpanded: true,
                            items: countriesCodes
                                .map((e) => DropdownMenuItem<String>(
                                      child: Center(child: Text(e)),
                                      value: e,
                                    ))
                                .toList(),
                            value: c.selectedPhoneNumberManagerCodeDrop,
                            onChanged: readOnly
                                ? null
                                : (value) {
                                    _profileBusines.phoneNumberCodeId =
                                        int.parse(ids[
                                            countriesCodes.indexOf(value!)]);
                                  },
                          ),
                        ),
                        // hintText: 'Manager Mobile Number',
                      );
                    }),

                    const PositionedDirectional(
                      end: 10,
                      top: 15,
                      child: Icon(
                        EvaIcons.checkmarkCircle2,
                        color: Color(0xff58D241),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    blackText("web_url".tr, 14),
                    const SizedBox(width: 10),
                    greyText("(${"optional".tr})", 13)
                  ],
                ),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: _profileBusines.websiteUrl,
                  onchanged: (s) {
                    _profileBusines.websiteUrl = s;
                  },
                ),
                const SizedBox(height: 20),
                blackText("default_lang".tr, 14),
                GetBuilder<GlobalDataController>(builder: (c) {
                  return CustomDropdown(
                    width: w,
                    height: 60,
                    items: c.languages.map((e) => e.name!).toList(),
                    onchanged: readOnly
                        ? null
                        : (s) {
                            _profileBusines.languageId = c.languages
                                .firstWhere((element) => element.name == s)
                                .id;
                          },
                    selectedItem: c
                        .languages[c.languages.indexWhere(
                      (element) => element.id == _profileBusines.languageId,
                    )]
                        .name,
                  );
                  // SignUpTextField(
                  //   readOnly: readOnly,
                  //   padding: EdgeInsets.zero,
                  //   initialValue: c
                  //       .languages[c.languages.indexWhere(
                  //     (element) => element.id == _profileBusines.languageId,
                  //   )]
                  //       .name,
                  // );
                }),
                const SizedBox(height: 20),
                blackText("inv_expiry_after", 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SignUpTextField(
                      width: 0.42 * w,
                      readOnly: readOnly,
                      padding: EdgeInsets.zero,
                      initialValue: "0",
                      onchanged: (s) {
                        //TODO:inv_expiry_after p1
                      },
                    ),
                    CustomDropdown(
                      width: 0.42 * w,
                      height: 60,
                      items: ["days".tr],
                      onchanged: readOnly
                          ? null
                          : (s) {
                              //TODO:inv_expiry_after p2
                            },
                      selectedItem: "days".tr,
                    )
                  ],
                ),
                const SizedBox(height: 20),
                blackText("products_delivery_fees".tr, 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  keyBoardType: TextInputType.number,
                  initialValue:
                      _profileBusines.productsDeliveryFees!.toString(),
                  onchanged: (s) {
                    _profileBusines.productsDeliveryFees = int.parse(s!);
                  },
                ),
                const SizedBox(height: 20),
                blackText("promo_code", 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue: _profileBusines.promoCode,
                  onchanged: (s) {
                    _profileBusines.promoCode = s;
                  },
                ),
                const SizedBox(height: 20),
                blackText("deposit_terms".tr, 14),
                CustomDropdown(
                  width: 0.42 * w,
                  height: 60,
                  items: ["Weekly".tr],
                  onchanged: readOnly
                      ? null
                      : (s) {
                          //TODO:Deposit terms
                        },
                  selectedItem: "Weekly".tr,
                ),
                const SizedBox(height: 20),
                blackText("approval_status".tr, 14),
                SignUpTextField(
                  readOnly: readOnly,
                  padding: EdgeInsets.zero,
                  initialValue:
                      _profileBusines.approvalStatus == 1 ? "yes".tr : "no".tr,
                  onchanged: (s) {
                    if (s == "yes".tr) {
                      _profileBusines.approvalStatus = 1;
                    } else {
                      _profileBusines.approvalStatus = 0;
                    }
                  },
                  suffixIcon: Icon(
                    EvaIcons.checkmarkCircle2,
                    color: Color(0xff58D241),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("custom_sms_ar".tr, 14),
                    const SizedBox(width: 10),
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
                    readOnly: readOnly,
                    onChanged: (value) {
                      _profileBusines.customSmsAr = value;
                    },
                    maxLines: 4,
                    controller: TextEditingController(
                        text: _profileBusines.customSmsAr),
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("custom_sms_en", 14),
                    const SizedBox(width: 10),
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
                    readOnly: readOnly,
                    onChanged: (value) {
                      _profileBusines.customSmsEn = value;
                    },
                    controller: TextEditingController(
                        text: _profileBusines.customSmsEn),
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    blackText("terms_conditions".tr, 14),
                    const SizedBox(width: 10),
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
                    readOnly: readOnly,
                    onChanged: (value) {
                      _profileBusines.termsAndConditions = value;
                    },
                    controller: TextEditingController(
                        text: _profileBusines.termsAndConditions),
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
                blackText("brief".tr, 14),
                Container(
                  width: w,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
                  decoration: BoxDecoration(
                    color: Color(0xffF8F8F8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TextField(
                    readOnly: readOnly,
                    onChanged: (value) {
                      //TODO:brief
                    },
                    maxLines: 4,
                    decoration: const InputDecoration(border: InputBorder.none),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
