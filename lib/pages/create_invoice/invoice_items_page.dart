import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/number_increase_decrese.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class InvoiceItemsPage extends StatefulWidget {
  InvoiceItemsPage({super.key});

  @override
  State<InvoiceItemsPage> createState() => _InvoiceItemsPageState();
}

class _InvoiceItemsPageState extends State<InvoiceItemsPage> {
  int quantity = 0;

  TextEditingController t1 = TextEditingController();

  TextEditingController t2 = TextEditingController();
  AddInvoiceController addInvoiceController = Get.find();

  final formKey = GlobalKey<FormState>();
  FocusNode d = FocusNode();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AddInvoiceController addInvoiceController = Get.find();
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "invoice_items".tr,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 16.0.sp,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
          width: w,
          height: h,
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  blueText("invoice_items".tr, 15),
                  Divider(thickness: 1.5),
                  const SizedBox(height: 20),
                  blackText("product_name".tr, 16),
                  SignUpTextField(
                    focusNode: d,
                    padding: EdgeInsets.all(0),
                    controller: t1,
                    validator: (s) {
                      if (s!.isEmpty || s == "") {
                        return "cant be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  blackText("unit_price".tr, 16),
                  SignUpTextField(
                    padding: EdgeInsets.all(0),
                    hintText: "0 AED",
                    controller: t2,
                    keyBoardType: TextInputType.number,
                    validator: (s) {
                      if (s!.isEmpty || s == "") {
                        return "cant be empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  blackText("quantity".tr, 16),
                  Row(
                    children: [
                      Container(
                        width: w / 2,
                        margin: EdgeInsets.symmetric(vertical: 5),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        decoration: BoxDecoration(
                          color: Color(0xffF8F8F8),
                          borderRadius: new BorderRadius.circular(10.0),
                        ),
                        child: NumericStepButton(
                          minValue: 0,
                          value: quantity.roundToDouble(),
                          onChanged: (value) {
                            quantity = value.round();
                            logWarning(quantity);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        InvoiceItem item = InvoiceItem(
                          productName: t1.text,
                          unitPrice: t2.text,
                          quantity: quantity,
                        );
                        if (formKey.currentState!.validate()) {
                          // logSuccess(t2.text)
                          InvoiceItem item = InvoiceItem(
                            productName: t1.text,
                            unitPrice: t2.text,
                            quantity: quantity,
                          );
                          t1.text = "";
                          t2.text = "";
                          quantity = 0;
                          setState(() {});
                          if (addInvoiceController.dataToEditInvoice != null) {
                            addInvoiceController.dataToEditInvoice!.invoiceItems
                                .add(item);
                          } else {
                            addInvoiceController.addInvoiceItem(item);
                          }

                          // addInvoiceController.addInvoiceItemAsArrays(item);
                          FocusScope.of(context).unfocus();

                          MyDialogs.showSavedSuccessfullyDialoge(
                              title: "Added Successfully", btnTXT: "close");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xff2F6782),
                          image: DecorationImage(
                            image:
                                AssetImage("assets/images/btn_wallpaper.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        width: 0.7 * w,
                        padding: EdgeInsets.all(15),
                        child: Center(
                          child: Text(
                            "add".tr,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17.0.sp,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    ),
                  ),
                  GetBuilder<AddInvoiceController>(builder: (_) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemBuilder: (context, index) {
                        InvoiceItem item;
                        if (addInvoiceController.dataToEditInvoice != null) {
                          item = addInvoiceController
                              .dataToEditInvoice!.invoiceItems[index];
                        } else {
                          item = addInvoiceController.invoiceItems[index];
                        }
                        return Container(
                          width: w,
                          height: h / 4,
                          margin: EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            color: Color(0xffF8F8F8),
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: AssetImage("assets/images/inv_item.png"),
                                fit: BoxFit.fill),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(
                                height: h / 8,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        greyText("product_name".tr, 11),
                                        const SizedBox(height: 10),
                                        blackText(item.productName!, 11)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        greyText("unit_price".tr, 11),
                                        SizedBox(height: 10),
                                        blackText("\$${item.unitPrice}", 11)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        greyText("quantity".tr, 11),
                                        SizedBox(height: 10),
                                        blackText(
                                            item.quantity!.round().toString(),
                                            11)
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        GetBuilder<AddInvoiceController>(
                                            builder: (c) {
                                          return Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  MyDialogs.showDeleteDialoge(
                                                      onProceed: () {
                                                        if (addInvoiceController
                                                                .dataToEditInvoice !=
                                                            null) {
                                                          addInvoiceController
                                                              .dataToEditInvoice!
                                                              .invoiceItems
                                                              .removeAt(index);
                                                          setState(() {});
                                                        } else {
                                                          c.removeInvoiceItem(
                                                              index);
                                                        }
                                                        Get.back();
                                                      },
                                                      message: "Are you sure?");
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: GFColors.DANGER
                                                          .withOpacity(0.2)),
                                                  child: Icon(EvaIcons.trash2,
                                                      color: GFColors.DANGER
                                                          .withAlpha(200)),
                                                ),
                                              ),
                                              SizedBox(width: 2),
                                              GestureDetector(
                                                onTap: () {
                                                  t1.text = item.productName!;
                                                  t2.text = item.unitPrice!;
                                                  quantity = item.quantity!;
                                                  if (addInvoiceController
                                                          .dataToEditInvoice !=
                                                      null) {
                                                    addInvoiceController
                                                        .dataToEditInvoice!
                                                        .invoiceItems
                                                        .removeAt(index);
                                                  } else {
                                                    c.removeInvoiceItem(index);
                                                  }
                                                  setState(() {});
                                                  d.requestFocus();
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.all(3),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: GFColors.SUCCESS
                                                          .withOpacity(0.2)),
                                                  child: Icon(EvaIcons.edit,
                                                      color: GFColors.SUCCESS
                                                          .withAlpha(200)),
                                                ),
                                              )
                                            ],
                                          );
                                        })
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    blackText("total".tr, 18),
                                    SizedBox(width: 20),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 20),
                                      child: Text(
                                        "\$ ${item.total}",
                                        style: TextStyle(
                                            fontSize: 15.0.sp,
                                            color: Colors.white),
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: addInvoiceController.dataToEditInvoice != null
                          ? addInvoiceController
                              .dataToEditInvoice!.invoiceItems.length
                          : addInvoiceController.invoiceItems.length,
                    );
                  })
                ],
              ),
            ),
          )),
    );
  }

  Widget buildMenuItem(InvoiceItem item) => ListTile(
        title: Text(
          item.productName!,
          style: TextStyle(
            color: Color(0xffE47E7B),
            fontSize: 15.0.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      );
}
