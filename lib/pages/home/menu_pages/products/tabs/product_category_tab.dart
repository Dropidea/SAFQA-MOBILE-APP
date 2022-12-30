import 'dart:io';

import 'package:badges/badges.dart';
import 'package:csv/csv.dart';
// import 'package:dartarabic/dartarabic.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/category_details.dart';
import 'package:safqa/pages/home/menu_pages/products/category_search_filter.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/create_category.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsCategoryTab extends StatefulWidget {
  const ProductsCategoryTab({super.key});

  @override
  State<ProductsCategoryTab> createState() => _ProductsCategoryTabState();
}

class _ProductsCategoryTabState extends State<ProductsCategoryTab> {
  ProductsController _productController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productController.getProductCategories();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Obx(
      () {
        if (_productController.getProductsCategoryFlag.value) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Column(
            children: [
              SizedBox(height: 60),
              SignUpTextField(
                padding: EdgeInsets.all(0),
                hintText: "search".tr,
                prefixIcon: Icon(
                  Icons.search_outlined,
                  color: Colors.grey,
                ),
                onchanged: (s) {
                  _productController.searchForProductsCategoryWithName(s!);
                  setState(() {});
                },
                suffixIcon: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    Get.to(() => CategoryFilterPage());
                  },
                  child: GetBuilder<ProductsController>(builder: (c) {
                    return Badge(
                      badgeColor: Color(0xff1BAFB2),
                      showBadge:
                          _productController.productCategoryFilter.filterActive,
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
              const SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  // scrollDirection: Axis.horizontal,

                  children: [
                    listBTN(text: "copy".tr, onTap: () {}, width: w / 4.5),
                    const SizedBox(width: 5),
                    listBTN(
                        text: "print/pdf".tr,
                        onTap: () async {
                          await saveProductCategoryPDF(
                            _productController.productCategoriesToShow,
                            context,
                            w,
                          );
                        }),
                    const SizedBox(width: 5),
                    listBTN(
                        text: "Excel",
                        onTap: () async {
                          await saveProductCategoryExcel(
                              _productController.productCategoriesToShow,
                              context);
                        },
                        width: w / 4.5),
                    const SizedBox(width: 5),
                    listBTN(
                        text: "CSV",
                        onTap: () async {
                          await saveProductCategoryCSV(
                              _productController.productCategoriesToShow,
                              context);
                        },
                        width: w / 4.5),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Get.to(() => CreateCategoryPage());
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
                    height: 40,
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
                        SizedBox(width: 10),
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
              GetBuilder<ProductsController>(builder: (c) {
                return Expanded(
                    child: _productController.productCategoriesToShow.isEmpty
                        ? Center(
                            child: greyText("nothing_to_show".tr, 20),
                          )
                        : ListView.separated(
                            primary: false,
                            itemCount: _productController
                                .productCategoriesToShow.length,
                            itemBuilder: (context, index) {
                              return CategoryCard(
                                onToggle: () {
                                  ProductCategory c = _productController
                                      .productCategoriesToShow[index];
                                  c.isActive == 0
                                      ? c.isActive = 1
                                      : c.isActive = 0;
                                  return _productController
                                      .editProductCategory(c);
                                },
                                onTap: () {
                                  Get.to(() => CategoryDetailsPage(
                                        productCategory: _productController
                                            .productCategoriesToShow[index],
                                      ));
                                },
                                width: w,
                                isToggled: _productController
                                        .productCategoriesToShow[index]
                                        .isActive ==
                                    1,
                                nameEn: _productController
                                    .productCategoriesToShow[index].nameEn,
                                nameAr: _productController
                                    .productCategoriesToShow[index].nameAr,
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 20);
                            },
                          ));
              })
            ],
          );
        }
      },
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
}

class CategoryCard extends StatefulWidget {
  CategoryCard({
    super.key,
    required this.isToggled,
    required this.width,
    this.height,
    required this.nameAr,
    required this.nameEn,
    this.onTap,
    required this.onToggle,
  });
  bool isToggled;
  final double? width;
  final double? height;
  final String? nameAr;
  final String? nameEn;
  void Function()? onTap;
  Future<bool> Function() onToggle;
  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  LocalsController localsController = Get.find();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        // margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                blackText(widget.nameEn ?? "", 15),
                SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      widget.isToggled ? "active".tr : "inactive".tr,
                      style: TextStyle(
                        color:
                            widget.isToggled ? Color(0xff1BAFB2) : Colors.grey,
                        fontSize: 13.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(width: 10),
                    FlutterSwitch(
                      height: 25.0,
                      width: 50.0,
                      padding: 3.0,
                      toggleSize: 25.0,
                      borderRadius: 20.0,
                      activeColor: Color(0xff1BAFB2),
                      value: widget.isToggled,
                      onToggle: (value) async {
                        bool f = await widget.onToggle();
                        if (f) {
                          widget.isToggled = value;
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            greyText(widget.nameAr ?? "", 15),
          ],
        ),
      ),
    );
  }
}

saveProductCategoryExcel(List<ProductCategory> ll, BuildContext context) async {
  var excel = Excel.createExcel();

  var sheet = excel["Sheet1"];
  excel.rename("Sheet 1", "Product Categorirs");
  CellStyle cellStyle = CellStyle(
    bold: true,
    italic: true,
    textWrapping: TextWrapping.WrapText,
    fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
    rotation: 0,
  );
  sheet.appendRow(
    ["Name En", "Name Ar", "Active", "Created At", "Updated At"],
  );
  var cell1 = sheet.cell(CellIndex.indexByString("A1"));
  var cell2 = sheet.cell(CellIndex.indexByString("B1"));
  var cell3 = sheet.cell(CellIndex.indexByString("C1"));
  var cell4 = sheet.cell(CellIndex.indexByString("C1"));
  var cell5 = sheet.cell(CellIndex.indexByString("C1"));
  cell1.cellStyle = cellStyle;
  cell2.cellStyle = cellStyle;
  cell3.cellStyle = cellStyle;
  cell4.cellStyle = cellStyle;
  cell5.cellStyle = cellStyle;
  for (var i in ll) {
    sheet.appendRow([
      i.nameEn,
      i.nameAr,
      i.isActive == 1 ? "active".tr : "inactive".tr,
      i.createdAt,
      i.updatedAt,
    ]);
  }

  Directory? dir = await getExternalStorageDirectory();
  late PermissionStatus status;
  late PermissionStatus status2;
  try {
    status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    status2 = await Permission.manageExternalStorage.status;
    if (!status2.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  } catch (e) {
    logError(e);
  }
  if (status.isGranted || status2.isGranted) {
    String tmp = dir!.parent.parent.parent.parent.path +
        "/Safqa/Product Categories/Excel";
    Directory newDir = await Directory(tmp).create(recursive: true);
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String outputFile = newDir.path + "/${formatter.format(now)}.xlsx";
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
    Utils.showSnackBar(
        context, "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد Safqa!!");
  }
}

saveProductCategoryCSV(List<ProductCategory> ll, BuildContext context) async {
  List<List<dynamic>> rows = [];
  List<dynamic> row = [];
  row.add("Name En");
  row.add("Name Ar");
  row.add("Is Active");
  row.add("Created At");
  row.add("Updated At");
  rows.add(row);
  for (var i in ll) {
    List<dynamic> row = [];
    row.add(i.nameEn);
    row.add(i.nameAr);
    row.add(i.isActive);
    row.add(i.createdAt);
    row.add(i.updatedAt);
    rows.add(row);
  }

  String csv = const ListToCsvConverter().convert(rows);

  Directory? dir = await getExternalStorageDirectory();
  late PermissionStatus status;
  late PermissionStatus status2;
  try {
    status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    status2 = await Permission.manageExternalStorage.status;
    if (!status2.isGranted) {
      await Permission.manageExternalStorage.request();
    }
  } catch (e) {
    logError(e);
  }
  if (status.isGranted || status2.isGranted) {
    String tmp =
        dir!.parent.parent.parent.parent.path + "/Safqa/Product Categories/CSV";
    Directory newDir = await Directory(tmp).create(recursive: true);
    var now = new DateTime.now();
    var formatter = new DateFormat('yyyy-MM-dd');
    String outputFile = newDir.path + "/${formatter.format(now)}.csv";
    if (await File(outputFile).exists()) {
      await File(outputFile).delete();
    }
    File f = File(outputFile);
    await f.writeAsString(csv);
  }
  Utils.showSnackBar(
      context, "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد Safqa!!");
}

saveProductCategoryPDF(
    List<ProductCategory> ll, BuildContext context, double w) async {
  final doc = pw.Document();
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
        return pw.ListView.separated(
          itemCount: ll.length,
          itemBuilder: (context, index) {
            return CategoryForPrint(
              isToggled: ll[index].isActive == 1,
              width: w,
              nameAr: ll[index].nameAr,
              nameEn: ll[index].nameEn,
            );
          },
          separatorBuilder: (pw.Context context, int index) {
            return pw.SizedBox(height: 10);
          },
        ); // Center
      }));

  await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save());
}

CategoryForPrint({
  double? width,
  double? height,
  String? nameEn,
  String? nameAr,
  required bool isToggled,
}) {
  return pw.Center(
    child: pw.Container(
      // margin: EdgeInsets.symmetric(horizontal: 10),
      padding: pw.EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      width: width,
      height: height,
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex("F8F8F8FF"),
        borderRadius: pw.BorderRadius.circular(10),
      ),
      child: pw.Column(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(
                nameEn ?? "",
                style: pw.TextStyle(
                  color: PdfColor.fromHex("000000"),
                  fontSize: 15,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Row(
                children: [
                  pw.Text(
                    (isToggled ? "active".tr : "inactive".tr),
                    textDirection: pw.TextDirection.rtl,
                    style: pw.TextStyle(
                      color: isToggled
                          ? PdfColor.fromHex("1BAFB2FF")
                          : PdfColor.fromHex("808080"),
                      fontSize: 13.0.sp,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(width: 10),
                ],
              ),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            (nameAr ?? ""),
            style: pw.TextStyle(
              color: PdfColor.fromHex("888888"),
              fontSize: 15,
            ),
            textDirection: pw.TextDirection.rtl,
          )
        ],
      ),
    ),
  );
}
