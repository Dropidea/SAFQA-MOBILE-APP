import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:searchfield/searchfield.dart';
import 'package:sizer/sizer.dart';

class BankInfoPage extends StatelessWidget {
  BankInfoPage({super.key, this.bank});
  final Bank? bank;
  TextEditingController bankNameControler = TextEditingController();
  String bankAccountControler = "";
  String ibanControler = "";
  final SignUpController _signUpController = Get.find();
  final CustomersController _customersController = Get.find();
  int bankId = 1;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Bank Info",
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
            const SizedBox(height: 20),
            blackText("Bank Name", 16),
            SearchField<Bank>(
              itemHeight: 40,
              initialValue: bank != null
                  ? SearchFieldListItem<Bank>(bank!.name!,
                      item: bank!,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 10),
                        child: greyText(bank!.name ?? "", 15),
                      ))
                  : _customersController.customerToCreate.bank!.name == null
                      ? null
                      : SearchFieldListItem<Bank>(
                          _customersController.customerToCreate.bank!.name ??
                              "",
                          item: _customersController.customerToCreate.bank!,
                          child: Padding(
                            padding:
                                const EdgeInsetsDirectional.only(start: 10),
                            child: greyText(
                                _customersController
                                        .customerToCreate.bank!.name ??
                                    "",
                                15),
                          )),
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
                bankId = p0.item!.id!;
              },
              controller: bankNameControler,
              suggestions: _signUpController.banks
                  .map(
                    (e) => SearchFieldListItem<Bank>(e.name!,
                        item: e,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 10),
                          child: greyText(e.name!, 15),
                        )),
                  )
                  .toList(),
            ),
            const SizedBox(height: 20),
            blackText("Bank Account", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              keyBoardType: TextInputType.number,
              onchanged: (s) => bankAccountControler = s!,
              initialValue: bank != null
                  ? bank!.bankAccount ?? ""
                  : _customersController.customerToCreate.bank!.bankAccount ??
                      "",
            ),
            const SizedBox(height: 20),
            blackText("Iban", 16),
            SignUpTextField(
              padding: EdgeInsets.all(0),
              textInputAction: TextInputAction.done,
              onchanged: (s) => ibanControler = s!,
              keyBoardType: TextInputType.number,
              initialValue: bank != null
                  ? bank!.iban ?? ""
                  : _customersController.customerToCreate.bank!.iban ?? "",
            ),
            SizedBox(height: 50),
            Center(
              child: GestureDetector(
                onTap: () {
                  Bank tmpbank = Bank(
                    id: bankId,
                    iban: ibanControler,
                    bankAccount: bankAccountControler,
                    name: bankNameControler.text,
                  );
                  if (bank == null) {
                    _customersController.customerToCreate.bank = tmpbank;
                  } else {
                    _customersController.customerToEdit.bank = tmpbank;
                  }
                  logSuccess(
                      _customersController.customerToCreate.bank!.toJson());
                  MyDialogs.showSavedSuccessfullyDialoge(
                    title: "Saved Successfully",
                    btnTXT: "close",
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
                      "Save",
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
