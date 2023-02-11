import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/banks/controller/bank_controller.dart';
import 'package:safqa/admin/pages/profiles/controller/profiles_controller.dart';
import 'package:safqa/admin/pages/profiles/profile_details.dart';
import 'package:safqa/admin/pages/profiles/profiles_filter_page.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class ProfilesMainPage extends StatefulWidget {
  ProfilesMainPage({super.key});

  @override
  State<ProfilesMainPage> createState() => ProfilesMainPageState();
}

class ProfilesMainPageState extends State<ProfilesMainPage> {
  ProfilesController _profilesController = Get.put(ProfilesController());
  BankController _bankController = Get.put(BankController());
  @override
  void initState() {
    _profilesController.getAllprofiles();
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
                    whiteText("profiles".tr, 17, fontWeight: FontWeight.w600),
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
                        onchanged: (s) {
                          _profilesController.searchForProfilesWithName(s!);
                        },
                        padding: EdgeInsets.all(0),
                        prefixIcon: Icon(
                          Icons.search_outlined,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            Get.to(() => ProfilesSearchFilterPage());
                          },
                          child: GetBuilder<ProfilesController>(builder: (c) {
                            return Badge(
                              badgeColor: Color(0xff1BAFB2),
                              showBadge: c.profilesFilter.filterActive,
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
                      Expanded(
                          child: GetBuilder<ProfilesController>(builder: (c) {
                        return c.getprofilesFlag
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.separated(
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                  onTap: () => Get.to(() => ProfileDetailsPage(
                                      profile: c.profilesToShow[index])),
                                  child: Container(
                                    width: w,
                                    height: 160,
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        blackText(
                                            c.profilesToShow[index]
                                                .companyName!,
                                            15),
                                        greyText(
                                            c.profilesToShow[index].workEmail!,
                                            15),
                                        blueText(
                                            c.profilesToShow[index]
                                                .phoneNumber!,
                                            15,
                                            fontWeight: FontWeight.bold),
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
                                itemCount: c.profilesToShow.length,
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
