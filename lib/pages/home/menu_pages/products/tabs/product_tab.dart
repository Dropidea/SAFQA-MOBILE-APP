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
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/create_product_link_page.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:safqa/pages/home/menu_pages/products/product_details.dart';
import 'package:safqa/pages/home/menu_pages/products/product_search_filter_page.dart';
import 'package:safqa/pages/home/menu_pages/products/products_create_page.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/product.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ProductsTab extends StatefulWidget {
  const ProductsTab({super.key});

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  ProductsController _productsController = Get.find();
  bool selectAllFlag = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productsController.getProducts();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Obx(() {
      if (_productsController.getProductsFlag.value) {
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
              textInputAction: TextInputAction.search,
              onchanged: (s) {
                _productsController.searchForProductsWithName(s!);
                setState(() {});
              },
              suffixIcon: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  Get.to(() => ProductSearchFilterPage());
                },
                child: GetBuilder<ProductsController>(builder: (c) {
                  return Badge(
                    badgeColor: Color(0xff1BAFB2),
                    showBadge: _productsController.productFilter.filterActive,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    //TODO:
                  },
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => ProductCreatePage());
                    },
                    child: Container(
                      width: 0.44 * w,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xff2F6782).withOpacity(0.16),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            child: Icon(
                              Icons.add_rounded,
                              color: Color(0xff428994),
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(
                            "create_product".tr,
                            style: TextStyle(
                              color: Color(0xff428994),
                              fontSize: 13.0.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 0.44 * w,
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
                        SizedBox(width: 5),
                        Text(
                          "import_product".tr,
                          style: TextStyle(
                            color: Color(0xff8B8B8B),
                            fontSize: 13.0.sp,
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
                children: [
                  selectAllFlag
                      ? listBTN(
                          text: "un_select_all".tr,
                          onTap: () {
                            setState(() {
                              selectAllFlag = false;
                              _productsController.productsToCreateLinks = [];
                            });
                          })
                      : listBTN(
                          text: "select_all".tr,
                          onTap: () {
                            setState(() {
                              selectAllFlag = true;
                              for (var i
                                  in _productsController.productsToShow) {
                                if (i.isActive == 1)
                                  _productsController.addProductLink(i);
                              }
                            });
                          }),
                  SizedBox(width: 5),
                  listBTN(
                      text: "create_link".tr,
                      onTap: () {
                        // Get.dialog(
                        //   AlertDialog(
                        //     actionsPadding: EdgeInsets.only(bottom: 30),
                        //     titlePadding: EdgeInsets.all(0),
                        //     actionsAlignment: MainAxisAlignment.center,
                        //     actions: [
                        //       MyButton(
                        //         width: 0.3 * w,
                        //         heigt: 35.0.sp,
                        //         color: Color(0xffF3F3F3),
                        //         borderRadius: 10,
                        //         textColor: Color(0xff2D5571),
                        //         text: "Open",
                        //         textSize: 15.0,
                        //         func: () {},
                        //       ),
                        //       MyButton(
                        //         width: 0.3 * w,
                        //         heigt: 35.0.sp,
                        //         color: Color(0xff2D5571),
                        //         borderRadius: 10,
                        //         text: "Copy Link",
                        //         textColor: Colors.white,
                        //         textSize: 13.0,
                        //         func: () {},
                        //       )
                        //     ],
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.all(
                        //         Radius.circular(32.0),
                        //       ),
                        //     ),
                        //     title: _dialogeTitle(),
                        //     content: Container(
                        //       width: w,
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(10.0),
                        //           border: Border.all(color: Color(0xffBBBBBB))),
                        //       child: TextFormField(
                        //         initialValue: "www.google.com",
                        //         decoration: InputDecoration(
                        //           border: OutlineInputBorder(
                        //               borderRadius: BorderRadius.circular(10.0),
                        //               borderSide: BorderSide.none),
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // );
                        if (!_productsController.productsToCreateLinks.isEmpty)
                          Get.to(() => CreateProductLink());
                      }),
                  SizedBox(width: 5),
                  listBTN(
                      text: "print/pdf".tr,
                      onTap: () {
                        saveProductsPDF(
                          _productsController.products,
                          context,
                        );
                      }),
                  // MyPopUpMenu(
                  //   menuList: [
                  //     PopupMenuItem(
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             EvaIcons.file,
                  //             color: Colors.grey.shade500,
                  //           ),
                  //           SizedBox(width: 10),
                  //           Text("PDF"),
                  //         ],
                  //       ),
                  //     ),
                  //     PopupMenuItem(
                  //       child: Row(
                  //         children: [
                  //           Icon(
                  //             Icons.print,
                  //             color: Colors.grey.shade500,
                  //           ),
                  //           SizedBox(
                  //             width: 10,
                  //           ),
                  //           Text("Printer"),
                  //         ],
                  //       ),
                  //     ),
                  //   ],
                  //   widget: Container(
                  //     padding:
                  //         EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  //     decoration: BoxDecoration(
                  //       color: const Color(0xffF9F9F9),
                  //       borderRadius: BorderRadius.circular(5),
                  //     ),
                  //     child: Center(
                  //       child: blueText("print", 12),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(width: 5),

                  listBTN(
                      text: "Excel",
                      onTap: () async {
                        await saveProductsExcel(
                            _productsController.products, context);
                      }),
                  SizedBox(width: 5),
                  listBTN(
                      text: "CSV",
                      onTap: () async {
                        await saveProductsCSV(
                            _productsController.products, context);
                      }),
                  SizedBox(width: 5),
                ],
              ),
            ),
            GetBuilder<ProductsController>(builder: (c) {
              return Expanded(
                  child: _productsController.productsToShow.isEmpty
                      ? Center(
                          child: greyText("nothing_to_show".tr, 20),
                        )
                      : ListView.builder(
                          primary: false,
                          itemCount: _productsController.productsToShow.length,
                          itemBuilder: (context, index) {
                            return ProductWidget(
                              product:
                                  _productsController.productsToShow[index],
                              checkedFlag: selectAllFlag,
                              onTap: () {
                                logSuccess(_productsController
                                    .productsToShow[index]
                                    .toJson());
                                Get.to(() => ProductDetailsPage(
                                      product: _productsController
                                          .productsToShow[index],
                                    ));
                              },
                            );
                          },
                        ));
            })
          ],
        );
      }
    });
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

Widget listBTN({String? text, void Function()? onTap, double? width}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20),
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

saveProductsPDF(
  List<Product> ll,
  BuildContext c,
) async {
  final doc = pw.Document();
  List<List<pw.ImageProvider>> images = [];
  List<pw.ImageProvider> subImages = [];
  int i = 1;
  for (var element in ll) {
    if (i % 5 != 0)
      subImages
          .add(await flutterImageProvider(NetworkImage(element.productImage)));
    else {
      subImages
          .add(await flutterImageProvider(NetworkImage(element.productImage)));
      images.add(subImages);
      subImages = [];
    }
    i++;
    // final x = await flutterImageProvider(NetworkImage(element.productImage));
    // images.add(x);
  }
  if (subImages.isNotEmpty) {
    images.add(subImages);
  }
  i = 1;
  List<List<Product>> tmp = [];
  List<Product> subTmp = [];
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
  for (var i = 0; i < tmp.length; i++) {
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
                  ("Products"),
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
                  itemCount: tmp[i].length,
                  itemBuilder: (context, index) {
                    return pw.Center(
                        child: ProductToPrint(
                      product: tmp[i][index],
                      image: images[i][index],
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
  // doc.addPage(pw.Page(
  //     pageFormat: PdfPageFormat.a4,
  //     theme: pw.ThemeData.withFont(
  //       base: pw.Font.ttf(
  //         await rootBundle.load('assets/fonts/Tajawal-Regular.ttf'),
  //       ),
  //       bold: pw.Font.ttf(
  //         await rootBundle.load('assets/fonts/Tajawal-Bold.ttf'),
  //       ),
  //     ),
  //     build: (pw.Context context) {
  //       return pw.Column(children: [
  //         pw.Text(
  //           ("Products"),
  //           textDirection: pw.TextDirection.rtl,
  //           style: pw.TextStyle(
  //             fontWeight: pw.FontWeight.bold,
  //             color: PdfColor.fromHex("111111"),
  //             fontSize: 20.0.sp,
  //           ),
  //         ),
  //         pw.SizedBox(height: 30),
  //         pw.Expanded(
  //             child: pw.ListView.separated(
  //           itemCount: ll.length,
  //           itemBuilder: (context, index) {
  //             return ProductToPrint(
  //                 product: ll[index], context: c, image: images[index]);
  //           },
  //           separatorBuilder: (pw.Context context, int index) {
  //             return pw.SizedBox(height: 20);
  //           },
  //         ))
  //       ]); // Center
  //     }));

  // await Printing.layoutPdf(
  //     onLayout: (PdfPageFormat format) async => doc.save());
}

saveProductsExcel(List<Product> ll, BuildContext context) async {
  var excel = Excel.createExcel();

  var sheet = excel["Sheet1"];
  excel.rename("Sheet 1", "Products");
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
      "Name En",
      "Name Ar",
      "Active",
      "Quantity",
      "Price",
      "Category(Ar)",
      "Category(En)",
      "Image"
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
      i.nameEn,
      i.nameAr,
      i.isActive == 1 ? "active".tr : "inactive".tr,
      i.quantity,
      i.price,
      i.category!.nameAr,
      i.category!.nameEn,
      i.productImage,
    ]);
  }
  await requestPermission(Permission.manageExternalStorage);
  if (await requestPermission(Permission.storage)) {
    {
      String folderInAppDocDir =
          await AppUtil.createFolderInAppDocDir('Safqa/Products/Excel');
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

  // Directory? dir = await getApplicationDocumentsDirectory();
  // String tmp = dir!.parent.parent.parent.parent.path + "/Safqa/Products/Excel";
  // logSuccess(tmp);
  // if (await requestPermission(Permission.storage)) logSuccess("msg");
  // await Directory(tmp).create();
  // await AccessPhoneStorage.instance.createSubDirectory(folderName: "Excel");

  //var now = new DateTime.now();
  //   var formatter = new DateFormat('yyyy-MM-dd');
  //   String outputFile = newDir.path + "/${formatter.format(now)}.xlsx";
  //   if (await File(outputFile).exists()) {
  //     await File(outputFile).delete();
  //   }
  //   //stopwatch.reset();
  //   List<int>? fileBytes = excel.save();
  //   if (fileBytes != null) {
  //     File(outputFile)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(fileBytes);
  //   }
  //   Utils.showSnackBar(
  //       context, "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد Safqa!!");
  // }

  // if (await requestPermission(Permission.storage)) {
  //   String tmp =
  //       dir!.parent.parent.parent.parent.path + "/Safqa/Products/Excel";
  //   logSuccess(tmp);
  //   Directory newDir = await Directory(tmp).create(recursive: true);
  //   var now = new DateTime.now();
  //   var formatter = new DateFormat('yyyy-MM-dd');
  //   String outputFile = newDir.path + "/${formatter.format(now)}.xlsx";
  //   if (await File(outputFile).exists()) {
  //     await File(outputFile).delete();
  //   }
  //   //stopwatch.reset();
  //   List<int>? fileBytes = excel.save();
  //   if (fileBytes != null) {
  //     File(outputFile)
  //       ..createSync(recursive: true)
  //       ..writeAsBytesSync(fileBytes);
  //   }
  //   Utils.showSnackBar(
  //       context, "تم حفظ الملف في الذاكرة الداخلية ضمن مجلد Safqa!!");
  // }
}

saveProductsCSV(List<Product> ll, BuildContext context) async {
  List<List<dynamic>> rows = [];
  List<dynamic> row = [];
  row.add("ID");
  row.add("Name En");
  row.add("Name Ar");
  row.add("Active");
  row.add("Quantity");
  row.add("Price");
  row.add("Category(Ar)");
  row.add("Category(En)");
  row.add("Image");
  rows.add(row);
  for (var i in ll) {
    List<dynamic> row = [];
    row.add(i.id);
    row.add(i.nameEn);
    row.add(i.nameAr);
    row.add(i.isActive);
    row.add(i.quantity);
    row.add(i.price);
    row.add(i.category!.nameAr);
    row.add(i.category!.nameEn);
    row.add(i.productImage);
    rows.add(row);
  }

  String csv = const ListToCsvConverter().convert(rows);
  await requestPermission(Permission.manageExternalStorage);
  if (await requestPermission(Permission.storage)) {
    String folderInAppDocDir =
        await AppUtil.createFolderInAppDocDir('Safqa/Products/CSV');
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

Future<bool> requestPermission(Permission permission) async {
  if (await permission.status.isGranted) {
    return true;
  } else {
    var res = await permission.request();
    if (res == await PermissionStatus.granted) {
      return true;
    } else
      return false;
  }
}
