import 'dart:io';

import 'package:badges/badges.dart';
import 'package:csv/csv.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/main.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/tabs/product_tab.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/manage_users_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_user_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/user_details.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/users_search_filter_page.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ManageUsersTab extends StatefulWidget {
  ManageUsersTab({super.key});

  @override
  State<ManageUsersTab> createState() => _ManageUsersTabState();
}

class _ManageUsersTabState extends State<ManageUsersTab> {
  ManageUserController _manageUserController = Get.put(ManageUserController());
  GlobalDataController _globalDataController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _manageUserController.getManageUsers();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
            _manageUserController.searchForProductsWithName(s!);
            setState(() {});
          },
          suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(() => MUsersSearchFilterPage());
            },
            child: GetBuilder<ManageUserController>(builder: (c) {
              return Badge(
                badgeColor: Color(0xff1BAFB2),
                showBadge: c.manageUserFilter.filterActive,
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
        GestureDetector(
          onTap: () {
            Get.to(() => AddUserPage());
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
              SizedBox(width: 5),
              listBTN(text: "copy".tr, onTap: () {}),
              SizedBox(width: 5),
              listBTN(
                  text: "print/pdf".tr,
                  onTap: () {
                    saveManageUsersPDF(
                        _manageUserController.manageUsers, context);
                  }),
              SizedBox(width: 5),
              listBTN(
                  text: "Excel",
                  onTap: () async {
                    saveManageUsersExcel(
                        _manageUserController.manageUsers, context);
                  }),
              SizedBox(width: 5),
              listBTN(
                  text: "CSV",
                  onTap: () async {
                    await saveManageUsersCSV(
                        _manageUserController.manageUsers, context);
                  }),
              SizedBox(width: 5),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(child: GetBuilder<ManageUserController>(builder: (c) {
          return c.getManageUserFlag
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Get.to(() => ManageUserDetailsPage(
                              manageUser: c.manageUsersToShow[index],
                              activeToEdit: true,
                            )),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF9F9F9),
                              ),
                              child: Center(
                                child: greyText("A", 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText(
                                      c.manageUsersToShow[index].fullName!, 15),
                                  SizedBox(height: 5),
                                  blueText(
                                    c.manageUsersToShow[index].email!.length >
                                            20
                                        ? c.manageUsersToShow[index].email!
                                                .substring(0, 20) +
                                            "..."
                                        : c.manageUsersToShow[index].email!,
                                    14,
                                    // underline: true,
                                  ),
                                  SizedBox(height: 5),
                                  greyText(
                                      c.manageUsersToShow[index]
                                          .phoneNumberManager!,
                                      14),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: c.manageUsersToShow.length);
        }))
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

  saveManageUsersPDF(
    List<ManageUser> ll,
    BuildContext c,
  ) async {
    final doc = pw.Document();
    int i = 1;
    List<List<ManageUser>> tmp = [];
    List<ManageUser> sybTmp = [];
    for (var element in ll) {
      if (i % 5 != 0)
        sybTmp.add(element);
      else {
        sybTmp.add(element);
        tmp.add(sybTmp);
        sybTmp = [];
      }
      i++;
    }
    if (sybTmp.isNotEmpty) {
      tmp.add(sybTmp);
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
                    ("Manage Users"),
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
                          child: ManageUserToPrint(
                        manageuser: i[index],
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

  saveManageUsersExcel(List<ManageUser> ll, BuildContext context) async {
    var excel = Excel.createExcel();

    var sheet = excel["Sheet1"];
    excel.rename("Sheet 1", "Manage Users");
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
        "Enabled",
        "Country",
        "Phone Number",
        "Email",
        "User Role",
        "Notification Settings",
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
    cell1.cellStyle = cellStyle;
    cell2.cellStyle = cellStyle;
    cell3.cellStyle = cellStyle;
    cell4.cellStyle = cellStyle;
    cell5.cellStyle = cellStyle;
    cell6.cellStyle = cellStyle;
    cell7.cellStyle = cellStyle;
    cell8.cellStyle = cellStyle;
    for (var i in ll) {
      sheet.appendRow([
        i.id,
        i.fullName,
        i.isEnable == 1 ? "Yes" : "No",
        i.nationality!.nameEn,
        "${_globalDataController.getCountryCode(i.phoneNumberCodeManagerId)} ${i.phoneNumberManager!}",
        i.email,
        i.userRole!.nameEn,
        getNotificationString(i),
      ]);
    }
    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      {
        String folderInAppDocDir =
            await AppUtil.createFolderInAppDocDir('Safqa/Manage Users/Excel');
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

  saveManageUsersCSV(List<ManageUser> ll, BuildContext context) async {
    List<List<dynamic>> rows = [];
    List<dynamic> row = [];
    row.add("ID");
    row.add("Full Name");
    row.add("Enabled");
    row.add("Country");
    row.add("Phone Number");
    row.add("Email");
    row.add("User Role");
    row.add("Notification Settings");

    rows.add(row);
    for (var i in ll) {
      List<dynamic> row = [];
      row.add(i.id);
      row.add(i.fullName);
      row.add(i.isEnable == 1 ? "Yes" : "No");
      row.add(i.nationality!.nameEn);
      row.add(
          "${_globalDataController.getCountryCode(i.phoneNumberCodeManagerId)} ${i.phoneNumberManager!}");
      row.add(i.email);
      row.add(i.userRole!.nameEn);
      row.add(getNotificationString(i));

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);
    await requestPermission(Permission.manageExternalStorage);
    if (await requestPermission(Permission.storage)) {
      String folderInAppDocDir =
          await AppUtil.createFolderInAppDocDir('Safqa/Manage Users/CSV');
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
