import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/business%20types/controller/business_types_controller.dart';
import 'package:safqa/admin/pages/business%20types/create_business_tyoe_page.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class BusinessTypesMainPage extends StatefulWidget {
  BusinessTypesMainPage({super.key});

  @override
  State<BusinessTypesMainPage> createState() => BusinessCategTypesageState();
}

class BusinessCategTypesageState extends State<BusinessTypesMainPage> {
  LocalsController _localsController = Get.put(LocalsController());
  BusinessTypesController _businessTypesController =
      Get.put(BusinessTypesController());
  @override
  void initState() {
    _businessTypesController.getAllBusinessTypes();
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
                    whiteText("business_types".tr, 17,
                        fontWeight: FontWeight.w600),
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
                      // SignUpTextField(
                      //   hintText: "search".tr,
                      //   padding: EdgeInsets.all(0),
                      //   prefixIcon: Icon(
                      //     Icons.search_outlined,
                      //     color: Colors.grey,
                      //   ),
                      //   suffixIcon: GestureDetector(
                      //     onTap: () {
                      //       FocusScope.of(context).unfocus();
                      //       // Get.to(() => BanksSearchFilterPage(),
                      //       //     transition: Transition.downToUp);
                      //     },
                      //     child: Badge(
                      //       badgeColor: Color(0xff1BAFB2),
                      //       showBadge: true,
                      //       position: BadgePosition.topEnd(top: 8, end: 8),
                      //       child: Image(
                      //         image: AssetImage("assets/images/filter.png"),
                      //         width: 18,
                      //         height: 18,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(height: 20),
                      AddNewButton(
                        height: 50,
                        onTap: () {
                          Get.to(() => CreateBusinessTypePage());
                        },
                      ),
                      const SizedBox(height: 20),
                      Expanded(child:
                          GetBuilder<BusinessTypesController>(builder: (c) {
                        return c.getBusinessTypesFlag
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
                                        Row(
                                          children: [
                                            Container(
                                              child: c.businessTypes[index]
                                                          .businessLogo !=
                                                      null
                                                  ? Container(
                                                      width: 60.0.sp,
                                                      height: 60.0.sp,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: NetworkImage(c
                                                                  .businessTypes[
                                                                      index]
                                                                  .businessLogo))),
                                                    )
                                                  : Icon(
                                                      Icons.photo_rounded,
                                                      size: 60.0.sp,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                            ),
                                            SizedBox(width: 10),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                blackText(
                                                    c.businessTypes[index]
                                                        .nameAr!,
                                                    15),
                                                greyText(
                                                    c.businessTypes[index]
                                                        .nameEn!,
                                                    15),
                                              ],
                                            ),
                                          ],
                                        ),
                                        PositionedDirectional(
                                          end: 10,
                                          top: 10,
                                          child: MyPopUpMenu(
                                            menuList: [
                                              PopupMenuItem(
                                                onTap: () {
                                                  Future(
                                                    () => Get.to(
                                                      CreateBusinessTypePage(
                                                        businessTypeToEdit:
                                                            c.businessTypes[
                                                                index],
                                                      ),
                                                    ),
                                                  );
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
                                                onTap: () {
                                                  Future(
                                                    () => MyDialogs
                                                        .showDeleteDialoge(
                                                            onProceed:
                                                                () async {
                                                              Get.back();
                                                              await c.deleteBusinessType(
                                                                  c.businessTypes[
                                                                      index]);
                                                            },
                                                            message:
                                                                "are_you_sure"
                                                                    .tr),
                                                  );
                                                },
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
                                itemCount: c.businessTypes.length,
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
