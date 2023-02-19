import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/controllers/login_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/invoices/controller/invoices_controller.dart';
import 'package:safqa/services/auth_service.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateQuickInvoiceTab extends StatefulWidget {
  const CreateQuickInvoiceTab({super.key});

  @override
  State<CreateQuickInvoiceTab> createState() => _CreateQuickInvoiceTabState();
}

class _CreateQuickInvoiceTabState extends State<CreateQuickInvoiceTab> {
  int invoicesLangValue = 0;
  int termsAndConditions = 0;
  String filePath = "";
  AddInvoiceController addInvoiceController = Get.find();
  SignUpController _signUpController = Get.find();
  TextEditingController textEditingController1 =
      TextEditingController(text: 'dd/MM/yyyy');
  TextEditingController textEditingController2 =
      TextEditingController(text: '00:00');
  LoginController _loginController = Get.put(LoginController());
  InvoicesController _invoicesController = Get.find();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("invoice_id".tr, 14),
                const SizedBox(height: 5),
                greyText("${_invoicesController.invoices.length + 1}", 12),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                blackText("invoice_date".tr, 14),
                const SizedBox(height: 5),
                greyText(DateFormat('dd-MMM-y').format(DateTime.now()), 12),
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        blackText("currency".tr, 16),
        Obx(
          () {
            List countries = _signUpController.globalData['country'];
            List<String> ids = countries
                .map<String>(
                  (e) => e['id'].toString(),
                )
                .toSet()
                .toList();
            List<String> countriesCurrencies = countries
                .map<String>(
                  (e) => e['currency'].toString(),
                )
                .toSet()
                .toList();
            addInvoiceController.selectCurrencyDrop(countriesCurrencies[0]);

            return CustomDropdown(
                items: countriesCurrencies,
                selectedItem: addInvoiceController.selectedCurrencyDrop,
                width: w,
                onchanged: (s) {
                  addInvoiceController.selectCurrencyDrop(s);
                  addInvoiceController.dataToCreateQuickInvoice.currencyId =
                      ids[countriesCurrencies.indexOf(s!)];
                });
          },
        ),
        const SizedBox(height: 20),
        blackText("invoice_value".tr, 16),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          hintText: "0 LE",
          keyBoardType: TextInputType.number,
          onchanged: (s) {
            addInvoiceController.dataToCreateQuickInvoice.invoiceValue = s;
          },
        ),
        const SizedBox(height: 20),
        blackText("invoice_l_c_value".tr, 16),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          hintText: "0 AED",
          keyBoardType: TextInputType.number,
          onchanged: (s) {
            addInvoiceController.dataToCreateQuickInvoice.loacalCurrency = s!;
          },
        ),
        const SizedBox(height: 20),
        blackText("language_of_invoice".tr, 16),
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
                      groupValue: invoicesLangValue,
                      onChanged: (value) => setState(() {
                            invoicesLangValue = value;
                            addInvoiceController
                                .dataToCreateQuickInvoice.languageId = value;
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
                      groupValue: invoicesLangValue,
                      onChanged: (value) => setState(() {
                            invoicesLangValue = value;
                            addInvoiceController
                                .dataToCreateQuickInvoice.languageId = value;
                          })),
                ),
                greyText("arabic".tr, 16),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          width: w,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade100, width: 2),
              borderRadius: BorderRadius.circular(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              blackText("customer_info".tr, 16),
              GestureDetector(
                onTap: () {
                  Get.to(() => CustomerInfoPage(),
                      transition: Transition.rightToLeft);
                },
                child: Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Icon(
                    Icons.arrow_forward,
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              blackText("create_invoice".tr, 16),
              SizedBox(width: 10),
              GestureDetector(
                onTap: () async {
                  addInvoiceController.dataToCreateQuickInvoice.token =
                      await AuthService().loadToken();
                  if (addInvoiceController.customerInfo != null) {
                    addInvoiceController.dataToCreateQuickInvoice.customerName =
                        addInvoiceController.customerInfo!.customerName;
                    addInvoiceController
                            .dataToCreateQuickInvoice.customerEmail =
                        addInvoiceController.customerInfo!.customerEmail;
                    addInvoiceController
                            .dataToCreateQuickInvoice.customerRefrence =
                        addInvoiceController.customerInfo!.customerRefrence;
                    addInvoiceController
                            .dataToCreateQuickInvoice.customerSendBy =
                        addInvoiceController.customerInfo!.customerSendBy;
                    addInvoiceController
                            .dataToCreateQuickInvoice.customerMobileNumbrCode =
                        addInvoiceController
                            .customerInfo!.customerMobileNumbrCode;
                    addInvoiceController
                            .dataToCreateQuickInvoice.customerMobileNumbr =
                        addInvoiceController.customerInfo!.customerMobileNumbr;
                    addInvoiceController.dataToCreateQuickInvoice
                            .customerMobileNumbrCodeid =
                        addInvoiceController
                            .customerInfo!.customerMobileNumbrCodeID;
                  }
                  addInvoiceController.dataToCreateQuickInvoice.languageId =
                      invoicesLangValue;

                  await addInvoiceController.createQuickInvoice();
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
    );
  }
}
