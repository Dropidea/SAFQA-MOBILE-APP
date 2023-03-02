import 'dart:io';

import 'package:badges/badges.dart';
import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/controller/customers_controller.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_add_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_details.dart';
import 'package:safqa/pages/home/menu_pages/customers/customer_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/customers/models/customer_model.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class CustomersMainPage extends StatefulWidget {
  CustomersMainPage({super.key});

  @override
  State<CustomersMainPage> createState() => CustomersMainPageState();
}

class CustomersMainPageState extends State<CustomersMainPage> {
  CustomersController _customersController = Get.find();
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: const ZeroAppBar(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome_background.png"),
                fit: BoxFit.cover,
              ),
            ),
            width: w,
            height: h,
          ),
          Column(
            children: [
              Container(
                height: 90,
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 22.0.sp,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                    ),
                    whiteText("customers".tr, 17, fontWeight: FontWeight.w600),
                    Opacity(
                      opacity: 0,
                      child: whiteText("text", 16),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: w,
                  padding: EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      SignUpTextField(
                        hintText: "search".tr,
                        onchanged: (s) {
                          _customersController.searchForCustomerWithName(s!);
                          setState(() {});
                        },
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => CustomerSearchFilterPage());
                          },
                          child: GetBuilder<CustomersController>(builder: (c) {
                            return Badge(
                              badgeColor: Color(0xff1BAFB2),
                              showBadge: c.customerFilter.filterActive,
                              position: BadgePosition.topEnd(top: 8, end: 8),
                              child: Image(
                                image: AssetImage("assets/images/filter.png"),
                                width: 18,
                                height: 18,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.to(() => AddCustomerPage());
                            },
                            child: Container(
                              width: 0.45 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xff2F6782).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.add_rounded,
                                      color: Color(0xff2F6782),
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  Text(
                                    "create_customer".tr,
                                    style: TextStyle(
                                      color: Color(0xff2F6782),
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              //TODO:
                            },
                            child: Container(
                              width: 0.45 * w,
                              height: 60,
                              decoration: BoxDecoration(
                                color: Color(0xff8B8B8B).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 5),
                                    child: Icon(
                                      Icons.file_download_outlined,
                                      color: Color(0xff8B8B8B),
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  Text(
                                    "import_customer".tr,
                                    style: TextStyle(
                                      color: Color(0xff8B8B8B),
                                      fontSize: 12.0.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        height: 40,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          children: [
                            listBTN(
                                text: "copy".tr, onTap: () {}, width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(
                              text: "print/pdf".tr,
                              onTap: () async {
                                await saveCustomersPDF(
                                    _customersController.customers, context);
                              },
                            ),
                            SizedBox(width: 5),
                            listBTN(
                                text: "Excel",
                                onTap: () async {
                                  await saveCustomersExcel(
                                      _customersController.customers, context);
                                },
                                width: w / 4.5),
                            SizedBox(width: 5),
                            listBTN(
                                text: "CSV",
                                onTap: () async {
                                  await saveCustomersCSV(
                                      _customersController.customers, context);
                                },
                                width: w / 4.5),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Expanded(
                        child: GetBuilder<CustomersController>(builder: (c) {
                          return c.getCustomerFlag
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : c.customersToShow.length == 0
                                  ? Center(
                                      child: greyText("nothing_to_show".tr, 20),
                                    )
                                  : ListView.separated(
                                      physics: BouncingScrollPhysics(),
                                      primary: false,
                                      itemBuilder: (context, index) => ListTile(
                                          onTap: () {
                                            Get.to(() => CustomerDetailsPage(
                                                  customer:
                                                      c.customersToShow[index],
                                                ));
                                          },
                                          title: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              blackText(
                                                c.customersToShow[index]
                                                    .fullName!,
                                                14,
                                                fontWeight: FontWeight.normal,
                                              ),
                                              greyText(
                                                  c.customersToShow[index]
                                                      .phoneNumber!,
                                                  13)
                                            ],
                                          ),
                                          dense: true,
                                          visualDensity:
                                              VisualDensity(vertical: 4),
                                          leading: Container(
                                            width: 60,
                                            height: 60,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: Color(0xffF9F9F9),
                                            ),
                                            child: Center(
                                              child: greyText(
                                                  c.customersToShow[index]
                                                      .fullName![0],
                                                  15,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )),
                                      separatorBuilder: (context, index) =>
                                          SizedBox(
                                        height: 20,
                                      ),
                                      itemCount: c.customersToShow.length,
                                    );
                        }),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  saveCustomersExcel(List<Customer> ll, BuildContext context) async {
    var excel = Excel.createExcel();

    var sheet = excel["Sheet1"];
    excel.rename("Sheet 1", "Customers");
    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      textWrapping: TextWrapping.WrapText,
      fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
      rotation: 0,
    );

    sheet.appendRow(
      [
        "ID",
        "Full Name",
        "Email",
        "Phone Number",
        "Customer Refrence",
        "Bank Account",
        "IBAN",
        "country",
        "Bank",
      ],
    );
    var cell1 = sheet.cell(CellIndex.indexByString("A1"));
    var cell2 = sheet.cell(CellIndex.indexByString("B1"));
    var cell3 = sheet.cell(CellIndex.indexByString("C1"));
    var cell4 = sheet.cell(CellIndex.indexByString("D1"));
    var cell5 = sheet.cell(CellIndex.indexByString("E1"));
    var cell6 = sheet.cell(CellIndex.indexByString("F1"));
    var cell7 = sheet.cell(CellIndex.indexByString("G1"));
    var cell8 = sheet.cell(CellIndex.indexByString("H1"));
    var cell9 = sheet.cell(CellIndex.indexByString("I1"));

    cell1.cellStyle = cellStyle;
    cell2.cellStyle = cellStyle;
    cell3.cellStyle = cellStyle;
    cell4.cellStyle = cellStyle;
    cell5.cellStyle = cellStyle;
    cell6.cellStyle = cellStyle;
    cell7.cellStyle = cellStyle;
    cell8.cellStyle = cellStyle;
    cell9.cellStyle = cellStyle;

    for (var i in ll) {
      sheet.appendRow([
        i.id,
        i.fullName,
        i.email,
        i.phoneNumber,
        i.customerReference,
        i.bankAccount,
        i.iban,
        i.country!.nameEn,
        i.bank!.name,
      ]);
    }
    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      {
        String folderInAppDocDir =
            await AppUtil.createFolderInAppDocDir('Safqa/Customers/Excel');
        logSuccess(folderInAppDocDir);
        var now = new DateTime.now();
        var formatter = new DateFormat('yyyy-MM-dd');
        String outputFile = folderInAppDocDir + "${formatter.format(now)}.xlsx";
        if (await File(outputFile).exists()) {
          await File(outputFile).delete();
        }
        //stopwatch.reset();
        List<int>? fileBytes = excel.save();
        if (fileBytes != null) {
          File(outputFile)
            ..createSync(recursive: true)
            ..writeAsBytesSync(fileBytes);
        }
        Utils.showSnackBar(context,
            "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد\n$folderInAppDocDir");
      }
    }
  }

  saveCustomersCSV(List<Customer> ll, BuildContext context) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("ID");
    row.add("Full Name");
    row.add("Email");
    row.add("Phone Number");
    row.add("Customer Refrence");
    row.add("Bank Account");
    row.add("IBAN");
    row.add("country");
    row.add("Bank");

    rows.add(row);
    for (var i in ll) {
      List<dynamic> row = [];
      row.add(i.id);
      row.add(i.fullName);
      row.add(i.email);
      row.add(i.phoneNumber);
      row.add(i.customerReference);
      row.add(i.bankAccount);
      row.add(i.iban);
      row.add(i.country!.nameEn);
      row.add(i.bank!.name);

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      String folderInAppDocDir =
          await AppUtil.createFolderInAppDocDir('Safqa/Customers/CSV');
      logSuccess(folderInAppDocDir);

      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String outputFile = folderInAppDocDir + "${formatter.format(now)}.csv";
      if (await File(outputFile).exists()) {
        await File(outputFile).delete();
      }
      File f = File(outputFile);
      await f.writeAsString(csv);
      Utils.showSnackBar(context,
          "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد\n$folderInAppDocDir");
    }
  }

  saveCustomersPDF(
    List<Customer> ll,
    BuildContext c,
  ) async {
    final doc = pw.Document();
    int i = 1;
    List<List<Customer>> tmp = [];
    List<Customer> subTmp = [];
    for (var element in ll) {
      if (i % 5 != 0)
        subTmp.add(element);
      else {
        subTmp.add(element);
        tmp.add(subTmp);
        subTmp = [];
      }
      i++;
    }
    if (subTmp.isNotEmpty) {
      tmp.add(subTmp);
    }
    for (var i in tmp) {
      doc.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          theme: pw.ThemeData.withFont(
            base: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Tajawal-Regular.ttf'),
            ),
            bold: pw.Font.ttf(
              await rootBundle.load('assets/fonts/Tajawal-Bold.ttf'),
            ),
          ),
          build: (pw.Context context) {
            return pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.center,
                children: [
                  pw.Text(
                    ("Customers"),
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold,
                      color: PdfColor.fromHex("111111"),
                      fontSize: 20.0.sp,
                    ),
                  ),
                  pw.SizedBox(height: 30),
                  pw.Expanded(
                      child: pw.ListView.separated(
                    itemCount: i.length,
                    itemBuilder: (context, index) {
                      logSuccess(i.length);
                      return pw.Center(
                          child: CustomerToPrint(
                        customer: i[index],
                        context: c,
                      ));
                    },
                    separatorBuilder: (pw.Context context, int index) {
                      return pw.SizedBox(height: 20);
                    },
                  ))
                ]); // Center
          }));
    }
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }
}

CustomerToPrint({required Customer customer, required BuildContext context}) {
  double width = MediaQuery.of(context).size.width;
  return pw.Container(
    width: width,
    padding: pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColor.fromHex("F8F8F8FF"),
      borderRadius: pw.BorderRadius.circular(10),
    ),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          (customer.fullName!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          (customer.email!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          (customer.phoneNumber!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
      ],
    ),
  );
}
