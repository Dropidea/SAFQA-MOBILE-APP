import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/bank_search_filter.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/admin/pages/banks/create_bank_page.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class BanksMainPage extends StatefulWidget {
  BanksMainPage({super.key});

  @override
  State<BanksMainPage> createState() => BanksMainPageState();
}

class BanksMainPageState extends State<BanksMainPage> {
  BankController _bankController = Get.put(BankController());
  LocalsController _localsController = Get.put(LocalsController());
  @override
  void initState() {
    _bankController.getAllBanks();
    super.initState();
  }

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
                    whiteText("banks".tr, 17, fontWeight: FontWeight.w600),
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
                  padding: EdgeInsets.all(20),
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
                        padding: EdgeInsets.all(0),
                        onchanged: (s) {
                          _bankController.searchForBanksWithName(s!);
                        },
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => BanksSearchFilterPage(),
                                transition: Transition.downToUp);
                          },
                          child: GetBuilder<BankController>(builder: (c) {
                            return Badge(
                              badgeColor: Color(0xff1BAFB2),
                              showBadge: c.bankFilter.filterActive,
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
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CreateBankPage());
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
                              ..arcToPoint(Offset(10, 0),
                                  radius: Radius.circular(10));
                          },
                          color: Color(0xff2F6782).withOpacity(0.4),
                          strokeWidth: 1,
                          dashPattern: [10, 5],
                          child: Container(
                            width: w,
                            height: 50,
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
                      Expanded(child: GetBuilder<BankController>(builder: (c) {
                        return c.getBanksFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  // onTap: () => Get.to(() => BankDetailsPage()),
                                  child: Container(
                                    width: w,
                                    height: 160,
                                    padding: EdgeInsets.all(10),
                                    child: Stack(
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            blackText(
                                                c.banksToShow[index].name!, 15),
                                            greyText(
                                                _localsController
                                                            .currenetLocale ==
                                                        0
                                                    ? c.banksToShow[index]
                                                        .country!.nameEn!
                                                    : c.banksToShow[index]
                                                        .country!.nameAr!,
                                                15),
                                            c.banksToShow[index].isActive == 0
                                                ? redText("inactive".tr, 15,
                                                    fontWeight: FontWeight.bold)
                                                : greenText("active".tr, 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ],
                                        ),
                                        PositionedDirectional(
                                          end: 10,
                                          top: 10,
                                          child: MyPopUpMenu(
                                            menuList: [
                                              PopupMenuItem(
                                                onTap: () {
                                                  Future(() => Get.to(() =>
                                                      CreateBankPage(
                                                        bankToEdit:
                                                            _bankController
                                                                .banks[index],
                                                      )));
                                                },
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Icon(
                                                        EvaIcons.edit,
                                                        size: 20,
                                                        color: Color.fromARGB(
                                                            255, 118, 118, 118),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    greyText("edit".tr, 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                ),
                                              ),
                                              PopupMenuItem(
                                                onTap: () {},
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 5),
                                                      child: Icon(
                                                        EvaIcons.trash2,
                                                        size: 20,
                                                        color: Color.fromARGB(
                                                            255, 118, 118, 118),
                                                      ),
                                                    ),
                                                    SizedBox(width: 5),
                                                    greyText("remove".tr, 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF8F8F8),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                  ),
                                ),
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: 20),
                                itemCount: c.banksToShow.length,
                              );
                      }))
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
}
