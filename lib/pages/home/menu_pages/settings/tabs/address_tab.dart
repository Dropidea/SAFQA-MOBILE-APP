import 'dart:io';

import 'package:csv/csv.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/addresses_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/address.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_address_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/address_details.dart';
import 'package:safqa/utils.dart';
import 'package:sizer/sizer.dart';

class AdressesTab extends StatefulWidget {
  AdressesTab({super.key});

  @override
  State<AdressesTab> createState() => _AdressesTabState();
}

class _AdressesTabState extends State<AdressesTab> {
  AddressesController _addressesController = Get.put(AddressesController());
  GlobalDataController _globalDataController = Get.find();
  LocalsController _localsController = Get.put(LocalsController());

  @override
  void initState() {
    _addressesController.getAddresses();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 60),
        GestureDetector(
          onTap: () {
            Get.to(() => AddAddressPage());
          },
          child: DottedBorder(
            padding: EdgeInsets.all(0),
            customPath: (size) {
              return Path()
                ..moveTo(10, 0)
                ..lineTo(size.width - 10, 0)
                ..arcToPoint(Offset(size.width, 10),
                    radius: Radius.circular(10))
                ..lineTo(size.width, size.height - 10)
                ..arcToPoint(Offset(size.width - 10, size.height),
                    radius: Radius.circular(10))
                ..lineTo(10, size.height)
                ..arcToPoint(Offset(0, size.height - 10),
                    radius: Radius.circular(10))
                ..lineTo(0, 10)
                ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
            },
            color: Color(0xff2F6782).withOpacity(0.4),
            strokeWidth: 1,
            dashPattern: [10, 5],
            child: Container(
              width: w,
              height: 45,
              decoration: BoxDecoration(
                color: Color(0xff2F6782).withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: Color(0xff2F6782),
                  ),
                  Text(
                    "create_new".tr,
                    style: TextStyle(
                      color: Color(0xff2F6782),
                      fontSize: 13.0.sp,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              listBTN(text: "copy".tr, onTap: () {}),
              SizedBox(width: 5),
              // listBTN(text: "Print", onTap: () {}),
              listBTN(
                text: "print/pdf".tr,
                onTap: () {
                  saveAddressesPDF(_addressesController.addresses, context);
                },
              ),
              SizedBox(width: 5),
              listBTN(
                  text: "Excel",
                  onTap: () async {
                    await saveAddressesExcel(
                        _addressesController.addresses, context);
                  }),
              SizedBox(width: 5),
              listBTN(
                  text: "CSV",
                  onTap: () async {
                    await saveAddressesCSV(
                        _addressesController.addresses, context);
                  }),
              SizedBox(width: 5),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(child: ExpandableNotifier(
          child: GetBuilder<AddressesController>(builder: (c) {
            if (c.getAddressFlag) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return c.addresses.isEmpty
                  ? Center(
                      child: greyText("nothing_to_show".tr, 20),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        Address address = c.addresses[index];
                        return AddressWidget(
                          address: address.city != null
                              ? address.city!.nameEn!
                              : "No City",
                          addressType: _localsController.currenetLocale == 0
                              ? address.addressType!.nameEn!
                              : address.addressType!.nameAr!,
                          area: _localsController.currenetLocale == 0
                              ? address.area!.nameEn!
                              : address.area!.nameAr!,
                          block: address.block ?? "not_available".tr,
                          avenue: address.avenue ?? "not_available".tr,
                          street: address.street ?? "not_available".tr,
                          onTap: () => Get.to(
                              () => AddressDetailsPage(address: address)),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                            height: 20,
                          ),
                      itemCount: c.addresses.length);
            }
          }),
        ))
      ],
    );
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            width: 55.0.sp,
            height: 70.0.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/logo/logo.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 25,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
          ),
        )
      ],
    );
  }

  saveAddressesExcel(List<Address> ll, BuildContext context) async {
    var excel = Excel.createExcel();

    var sheet = excel["Sheet1"];
    excel.rename("Sheet 1", "Addresses");
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
        "Address Type",
        "City",
        "Area",
        "Block",
        "Avenue",
        "House/Bldg No",
        "Sreet",
        "Floor",
        "Appartment",
        "Instructions",
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
    var cell10 = sheet.cell(CellIndex.indexByString("J1"));
    var cell11 = sheet.cell(CellIndex.indexByString("K1"));
    cell1.cellStyle = cellStyle;
    cell2.cellStyle = cellStyle;
    cell3.cellStyle = cellStyle;
    cell4.cellStyle = cellStyle;
    cell5.cellStyle = cellStyle;
    cell6.cellStyle = cellStyle;
    cell7.cellStyle = cellStyle;
    cell8.cellStyle = cellStyle;
    cell9.cellStyle = cellStyle;
    cell10.cellStyle = cellStyle;
    cell11.cellStyle = cellStyle;
    for (var i in ll) {
      sheet.appendRow([
        i.id,
        i.addressType!.nameEn,
        i.city!.nameEn,
        i.area!.nameEn,
        i.block,
        i.avenue,
        i.bldgNo,
        i.street,
        i.floor,
        i.appartment,
        i.instructions,
      ]);
    }

    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      {
        String folderInAppDocDir =
            await AppUtil.createFolderInAppDocDir('Safqa/Addresses/Excel');
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

  saveAddressesCSV(List<Address> ll, BuildContext context) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("ID");
    row.add("Address Type");
    row.add("City");
    row.add("Area");
    row.add("Block");
    row.add("Avenue");
    row.add("House/Bldg No");
    row.add("Sreet");
    row.add("Floor");
    row.add("Appartment");
    row.add("Instructions");

    rows.add(row);
    for (var i in ll) {
      List<dynamic> row = [];
      row.add(i.id);
      row.add(i.addressType!.nameEn);
      row.add(i.city!.nameEn);
      row.add(i.area!.nameEn);
      row.add(i.block);
      row.add(i.avenue);
      row.add(i.bldgNo);
      row.add(i.street);
      row.add(i.floor);
      row.add(i.appartment);
      row.add(i.instructions);

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      String folderInAppDocDir =
          await AppUtil.createFolderInAppDocDir('Safqa/Addresses/CSV');
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

  saveAddressesPDF(
    List<Address> ll,
    BuildContext c,
  ) async {
    final doc = pw.Document();
    int i = 1;
    List<List<Address>> tmp = [];
    List<Address> subTmp = [];
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
                    ("Addresses"),
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
                          child: AddressToPrint(
                        address: i[index],
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

AddressToPrint({required Address address, required BuildContext context}) {
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
          ("City: " + address.city!.nameEn!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          ("Area:" + address.area!.nameEn!),
          style: pw.TextStyle(
            color: PdfColor.fromHex("000000"),
            fontSize: 13.0.sp,
          ),
          textDirection: pw.TextDirection.rtl,
        ),
        pw.SizedBox(height: 10),
        pw.Text(
          ("Address Type: " + address.addressType!.nameEn!),
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

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.address,
    required this.addressType,
    required this.area,
    required this.block,
    required this.avenue,
    required this.street,
    this.onTap,
  }) : super(key: key);
  final String address;
  final String addressType;
  final String area;
  final String block;
  final String avenue;
  final String street;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ExpandablePanel(
          theme: ExpandableThemeData(iconColor: Color(0xff2F6782)),
          header: Container(
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 7),
                  child: Icon(Icons.location_pin, color: Color(0xff2F6782)),
                ),
                SizedBox(width: 10),
                blueText(address, 15, fontWeight: FontWeight.bold),
              ],
            ),
          ),
          controller: ExpandableController(initialExpanded: true),
          collapsed: Container(),
          expanded: Container(
            margin: EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    greyText("Address Type:", 13),
                    SizedBox(width: 5),
                    blackText(addressType, 13)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    greyText("Area:", 13),
                    SizedBox(width: 5),
                    blackText(area, 13)
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    greyText("Block:", 13),
                    SizedBox(width: 5),
                    blackText(block, 13)
                  ],
                ),
                SizedBox(height: 10),
                GestureDetector(
                  onTap: onTap,
                  child: blueText("More", 13,
                      fontWeight: FontWeight.bold,
                      underline: true,
                      decorationThickness: 10),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ));
  }
}

Widget listBTN({String? text, void Function()? onTap, double? width}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: blueText(text!, 11),
      ),
    ),
  );
}
