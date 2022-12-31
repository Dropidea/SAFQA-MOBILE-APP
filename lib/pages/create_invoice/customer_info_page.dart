// import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';

class CustomerInfoPage extends StatefulWidget {
  const CustomerInfoPage({super.key});

  @override
  State<CustomerInfoPage> createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  TextEditingController customerNameControler = TextEditingController();

  TextEditingController customerPhoneNumberControler = TextEditingController();

  TextEditingController customerEmailControler = TextEditingController();

  TextEditingController customerRefrenceControler = TextEditingController();

  final CustomersController _customersController = Get.find();

  final AddInvoiceController _addInvoiceController = Get.find();
  final GlobalDataController _globalDataController = Get.find();
  final LocalsController _localsController = Get.find();
  final SignUpController _signUpController = Get.find();

  String? customerMobileCode;

  String customerMobileCodeID = "1";
  int? sendOptionId;
  bool engFlag = false;
  @override
  void initState() {
    engFlag = _localsController.currenetLocale == 0;
    if (_addInvoiceController.dataToEditInvoice != null) {
      customerEmailControler.text =
          _addInvoiceController.dataToEditInvoice!.customerEmail ?? "";
      customerNameControler.text =
          _addInvoiceController.dataToEditInvoice!.customerName ?? "";
      customerPhoneNumberControler.text =
          _addInvoiceController.dataToEditInvoice!.customerMobileNumbr ?? "";
      customerRefrenceControler.text =
          _addInvoiceController.dataToEditInvoice!.customerRefrence ?? "";
      sendOptionId = _addInvoiceController.dataToEditInvoice!.customerSendBy;
      customerMobileCode =
          _addInvoiceController.dataToEditInvoice!.customerMobileNumbrCode;
    } else {
      customerMobileCode = _globalDataController.countries[0].code!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "customer_info".tr,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 16.0.sp),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: w,
        height: h,
        padding: const EdgeInsets.all(20),
        child: ListView(
          primary: false,
          children: [
            blueText("customer_info".tr, 15),
            Divider(thickness: 1.5),
            const SizedBox(height: 20),
            blackText("customer_name".tr, 16),
            // SignUpTextField(
            //   padding: EdgeInsets.all(0),
            // ),
            SearchField<Customer>(
              itemHeight: 40,

              searchInputDecoration: InputDecoration(
                fillColor: Color(0xffF8F8F8),
                filled: true,
                border: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(10.0),
                    borderSide: BorderSide.none),
              ),
              searchStyle: TextStyle(fontSize: 13.0.sp),
              suggestionStyle: TextStyle(fontSize: 13.0.sp),
              // onSubmit: (p0) => logSuccess(p0),

              suggestionItemDecoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),

              onSuggestionTap: (p0) {
                FocusScope.of(context).unfocus();

                customerPhoneNumberControler.text = p0.item!.phoneNumber!;
                customerEmailControler.text = p0.item!.email!;
                customerRefrenceControler.text = p0.item!.customerReference!;
              },

              controller: customerNameControler,
              suggestions: _customersController.customers
                  .map(
                    (e) => SearchFieldListItem<Customer>(e.fullName!,
                        item: e,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: greyText(e.fullName!, 15),
                        )),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            blackText("send_invoice_by".tr, 16),
            CustomDropdown(
              items: _globalDataController.sendOptions
                  .map((e) => engFlag ? e.nameEn! : e.nameAr!)
                  .toList(),
              selectedItem: _addInvoiceController.dataToEditInvoice != null
                  ? _globalDataController.sendOptions
                          .map((e) => engFlag ? e.nameEn! : e.nameAr!)
                          .toList()[
                      _globalDataController.sendOptions.indexWhere((element) =>
                          element.id ==
                          _addInvoiceController
                              .dataToEditInvoice!.customerSendBy!)]
                  : _globalDataController.sendOptions
                      .map((e) => engFlag ? e.nameEn! : e.nameAr!)
                      .toList()[0],
              width: 2,
              onchanged: (s) {
                if (_addInvoiceController.dataToEditInvoice != null) {
                  _addInvoiceController.dataToEditInvoice!.customerSendBy =
                      _globalDataController
                          .sendOptions[_globalDataController.sendOptions
                              .indexWhere((element) =>
                                  element.nameEn == s || element.nameAr == s)]
                          .id;
                } else {
                  _addInvoiceController.dataToCreateInvoice.customerSendBy =
                      _globalDataController
                          .sendOptions[_globalDataController.sendOptions
                              .indexWhere((element) =>
                                  element.nameEn == s || element.nameAr == s)]
                          .id;
                }
                sendOptionId = _globalDataController
                    .sendOptions[_globalDataController.sendOptions.indexWhere(
                        (element) =>
                            element.nameEn == s || element.nameAr == s)]
                    .id;

                // _addInvoiceController.selectSendBy(s);
              },
            ),
            const SizedBox(height: 20),
            blackText("customer_phone_number".tr, 16),
            Obx(() {
              List countries = _signUpController.globalData['country'];
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
              if (_addInvoiceController.dataToEditInvoice != null) {
                if (_addInvoiceController
                        .dataToEditInvoice!.customerMobileNumbrCode !=
                    null) {
                  _signUpController.selectPhoneNumberManagerCodeDrop(
                      _addInvoiceController
                          .dataToEditInvoice!.customerMobileNumbrCode!);
                } else {
                  _signUpController
                      .selectPhoneNumberManagerCodeDrop(countriesCodes[0]);
                }
              } else {
                _signUpController
                    .selectPhoneNumberManagerCodeDrop(countriesCodes[0]);
              }
              return SignUpTextField(
                controller: customerPhoneNumberControler,
                padding: EdgeInsets.all(0),
                keyBoardType: TextInputType.number,
                prefixIcon: SizedBox(
                  width: 60,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    items: countriesCodes
                        .map((e) => DropdownMenuItem<String>(
                              child: Center(child: Text(e)),
                              value: e,
                            ))
                        .toList(),
                    value: _signUpController.selectedPhoneNumberManagerCodeDrop,
                    onChanged: (value) {
                      customerMobileCodeID =
                          ids[countriesCodes.indexOf(value!)];
                      customerMobileCode =
                          countriesCodes[countriesCodes.indexOf(value)];
                    },
                  ),
                ),
                // hintText: 'Manager Mobile Number',
              );
            }),
            const SizedBox(height: 20),
            blackText("customer_email".tr, 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerEmailControler,
              keyBoardType: TextInputType.emailAddress,
            ),
            // IntlPhoneField(
            //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
            //   dropdownIconPosition: IconPosition.trailing,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     fillColor: Color(0xffF8F8F8),
            //     filled: true,
            //     border: OutlineInputBorder(
            //         borderRadius: new BorderRadius.circular(10.0),
            //         borderSide: BorderSide.none),
            //   ),
            //   initialCountryCode: 'AE',
            //   onChanged: (phone) {
            //     logSuccess(customerPhoneNumberControler.text);
            //   },
            //   onCountryChanged: (value) =>
            //       customerMobileCode = "+${value.dialCode}",
            //   controller: customerPhoneNumberControler,
            // ),
            const SizedBox(height: 10),
            Row(
              children: [
                blackText("customer_refrence".tr, 16),
                SizedBox(width: 10),
                greyText("(${"optional".tr})", 13)
              ],
            ),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              controller: customerRefrenceControler,
            ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
                  if (_addInvoiceController.dataToEditInvoice != null) {
                    _addInvoiceController.dataToEditInvoice!.customerName =
                        customerNameControler.text;
                    _addInvoiceController
                            .dataToEditInvoice!.customerMobileNumbr =
                        customerPhoneNumberControler.text;
                    _addInvoiceController.dataToEditInvoice!
                        .customerMobileNumbrCode = customerMobileCode;
                    _addInvoiceController.dataToEditInvoice!.customerSendBy =
                        sendOptionId;
                    _addInvoiceController.dataToEditInvoice!.customerEmail =
                        customerEmailControler.text;
                    _addInvoiceController.dataToEditInvoice!.customerRefrence =
                        customerRefrenceControler.text;
                  } else {
                    _addInvoiceController.saveCustomerInfo(
                      customerRef: customerRefrenceControler.text,
                      email: customerEmailControler.text,
                      name: customerNameControler.text,
                      phoneNum: customerPhoneNumberControler.text,
                      phoneNumCodeId: customerMobileCode!,
                      sendBy: sendOptionId ?? 1,
                    );
                  }
                  FocusScope.of(context).unfocus();
                  MyDialogs.showSavedSuccessfullyDialoge(
                    title: "Customer Saved",
                    btnTXT: "Close",
                    onTap: () {
                      Get.back();
                      Get.back();
                    },
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff2F6782),
                    image: DecorationImage(
                      image: AssetImage("assets/images/btn_wallpaper.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  width: 0.7 * w,
                  padding: EdgeInsets.all(15),
                  child: Center(
                    child: Text(
                      "save".tr,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Text blueText(String text, double size,
    {bool underline = false,
    FontWeight? fontWeight,
    double? decorationThickness}) {
  return Text(
    text,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: decorationThickness ?? 6,
        color: Color(0xff2F6782),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text blackText(String text, double size,
    {bool underline = false, FontWeight? fontWeight, TextAlign? textAlign}) {
  return Text(
    text,
    textAlign: textAlign,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Colors.black,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text prblackText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Color(0xff484848),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text whiteText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: Colors.white,
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greyText(String text, double size,
    {bool underline = false, FontWeight? fontWeight, TextAlign? textAlign}) {
  return Text(
    text,
    softWrap: true,
    textAlign: textAlign,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff8B8B8B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greyARText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    textAlign: TextAlign.end,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff8B8B8B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text greenText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xff58D241),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}

Text redText(String text, double size,
    {bool underline = false, FontWeight? fontWeight}) {
  return Text(
    text,
    softWrap: true,
    style: TextStyle(
        decoration: underline ? TextDecoration.underline : null,
        decorationThickness: 4,
        color: const Color(0xffE47E7B),
        fontWeight: fontWeight ?? FontWeight.w500,
        fontSize: size.sp),
  );
}
