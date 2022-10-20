import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:safqa/controllers/add_invoice_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/models/invoice_item.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/number_increase_decrese.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class InvoiceItemsPage extends StatelessWidget {
  InvoiceItemsPage({super.key});
  int quantity = 0;
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
          "Invoice Items",
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
            child: ListView(
              primary: false,
              children: [
                blueText("Invoice Items", 15),
                Divider(thickness: 1.5),
                const SizedBox(height: 20),
                blackText("Productn name", 16),
                SignUpTextField(
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
                blackText("Unit Price", 16),
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
                blackText("Quantitiy", 16),
                Row(
                  children: [
                    Container(
                      width: w / 2,
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: NumericStepButton(
                        minValue: 0,
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
                      if (formKey.currentState!.validate()) {
                        InvoiceItem item = InvoiceItem(
                          productName: t1.text,
                          unitPrice: t2.text,
                          quantity: quantity,
                        );
                        addInvoiceController.addInvoiceItem(item);
                        addInvoiceController.addInvoiceItemAsArrays(item);
                        logSuccess(
                            addInvoiceController.dataToCreateInvoice.toJson());
                      }
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
                ),
                GetBuilder<AddInvoiceController>(builder: (_) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (context, index) {
                      InvoiceItem item =
                          addInvoiceController.invoiceItems[index];
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      greyText("Product Name", 11),
                                      const SizedBox(height: 10),
                                      blackText(item.productName!, 11)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      greyText("Unit Price", 11),
                                      SizedBox(height: 10),
                                      blackText("\$${item.unitPrice}", 11)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      greyText("Quantity", 11),
                                      SizedBox(height: 10),
                                      blackText(
                                          item.quantity!.round().toString(), 11)
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: GFColors.DANGER
                                                    .withOpacity(0.2)),
                                            child: Icon(Icons.delete,
                                                color: GFColors.DANGER
                                                    .withAlpha(200)),
                                          ),
                                          SizedBox(width: 2),
                                          Container(
                                            padding: EdgeInsets.all(2),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: GFColors.SUCCESS
                                                    .withOpacity(0.2)),
                                            child: Icon(
                                                Icons.mode_edit_outlined,
                                                color: GFColors.SUCCESS
                                                    .withAlpha(200)),
                                          )
                                        ],
                                      )
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
                                  blackText("Total", 18),
                                  SizedBox(width: 20),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    child: Text(
                                      "\$ 400",
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
                    itemCount: addInvoiceController.invoiceItems.length,
                  );
                })
              ],
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
