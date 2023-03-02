import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:safqa/admin/pages/about/controller/about_controller.dart';
import 'package:safqa/admin/pages/about/create_about_page.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class AboutsMainPage extends StatefulWidget {
  AboutsMainPage({super.key});

  @override
  State<AboutsMainPage> createState() => AboutsMainPageState();
}

class AboutsMainPageState extends State<AboutsMainPage> {
  LocalsController _localsController = Get.put(LocalsController());
  AboutController _aboutController = Get.put(AboutController());
  @override
  void initState() {
    _aboutController.getAllAbouts();
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
                    whiteText("about".tr, 17, fontWeight: FontWeight.w600),
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
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CreateAboutPage());
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
                      Expanded(child: GetBuilder<AboutController>(builder: (c) {
                        return c.getAboutsFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  // onTap: () => Get.to(() => BankDetailsPage()),
                                  child: Container(
                                    width: w,
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        blackText(c.abouts[index].about!, 14,
                                            textAlign: TextAlign.justify,
                                            fontWeight: FontWeight.w500),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                Get.to(() => CreateAboutPage(
                                                      aboutToEdit:
                                                          c.abouts[index],
                                                    ));
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: GFColors.SUCCESS
                                                      .withOpacity(0.2),
                                                ),
                                                child: Icon(
                                                  EvaIcons.edit,
                                                  size: 30,
                                                  color: GFColors.SUCCESS,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            GestureDetector(
                                              onTap: () {
                                                MyDialogs.showDeleteDialoge(
                                                    onProceed: () async {
                                                      Get.back();
                                                      await c.deleteAbout(
                                                          c.abouts[index]);
                                                    },
                                                    message: "are_you_sure".tr);
                                              },
                                              child: Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                  color: GFColors.DANGER
                                                      .withOpacity(0.2),
                                                ),
                                                child: Icon(
                                                  EvaIcons.trash2,
                                                  size: 30,
                                                  color: GFColors.DANGER,
                                                ),
                                              ),
                                            )
                                          ],
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
                                itemCount: c.abouts.length,
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
