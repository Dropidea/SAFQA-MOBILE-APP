import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/admin/pages/social%20media/controller/social_media_controller.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/business_datails_page.dart';
import 'package:safqa/pages/home/profile/controller/profile_controller.dart';
import 'package:safqa/pages/home/profile/docs_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/pages/home/profile/social_media_page.dart';
import 'package:safqa/widgets/popup_menu.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ProfileController _profileController = Get.put(ProfileController());
  SocialMediaController _socialMediaController =
      Get.put(SocialMediaController());
  GlobalDataController _globalDataController = Get.find();
  @override
  void initState() {
    _profileController.getProfileBusiness();
    _profileController.getSocialMediaLinks();
    _socialMediaController.getAllSocialMedias();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: blackText("profile".tr, 16),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          Stack(
            children: [
              SizedBox(
                child: Align(
                  child: Container(
                    margin: EdgeInsets.only(bottom: 10),
                    width: w / 3,
                    height: w / 3,
                    decoration: BoxDecoration(
                      // color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                      // border: Border.all(color: Colors.grey.shade400),
                      // color: Colors.grey.shade100,
                      image: DecorationImage(
                        image: AssetImage("assets/images/t2.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    // child: Center(
                    //   child: Icon(
                    //     EvaIcons.personOutline,
                    //     color: Colors.grey.shade400,
                    //     size: w / 4,
                    //   ),
                    // ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0,
                right: w / 3 - 35,
                child: MyPopUpMenu(
                    menuList: [
                      PopupMenuItem(
                        onTap: () {
                          // Future(() => Get.to(() => ProfilePage(),
                          //     transition: Transition.rightToLeft));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                EvaIcons.edit,
                                size: 20,
                                color: Color.fromARGB(255, 118, 118, 118),
                              ),
                            ),
                            SizedBox(width: 5),
                            greyText("Change Picture", 12,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {
                          // Future(() => Get.to(() => ProfilePage(),
                          //     transition: Transition.rightToLeft));
                        },
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child: Icon(
                                EvaIcons.trash2,
                                size: 20,
                                color: Color.fromARGB(255, 118, 118, 118),
                              ),
                            ),
                            SizedBox(width: 5),
                            greyText("Remove Picture", 12,
                                fontWeight: FontWeight.bold),
                          ],
                        ),
                      ),
                    ],
                    widget: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.photo_camera_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    )),
              ),
            ],
          ),
          SizedBox(height: 20),
          Align(
            child: blackText(_globalDataController.me.fullName!, 15),
          ),
          SizedBox(height: 40),
          profileOption(
            w,
            title: 'business_details'.tr,
            icon: EvaIcons.briefcase,
            onTap: () => Get.to(() => BusinessDetailsPage(),
                transition: Transition.rightToLeft),
          ),
          profileOption(
            w,
            title: 'bank_details'.tr,
            icon: EvaIcons.creditCard,
            onTap: () => Get.to(() => ProfileBankDetailsPage(),
                transition: Transition.rightToLeft),
          ),
          profileOption(
            w,
            title: 'social_media'.tr,
            icon: EvaIcons.globe,
            onTap: () => Get.to(() => SocialMediaPage(),
                transition: Transition.rightToLeft),
          ),
          profileOption(
            w,
            title: 'docs'.tr,
            icon: EvaIcons.fileAdd,
            onTap: () =>
                Get.to(() => DocsPage(), transition: Transition.rightToLeft),
          ),
        ],
      ),
    );
  }

  Container profileOption(double w,
      {required String title, void Function()? onTap, required IconData icon}) {
    return Container(
      width: w,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade100, width: 2),
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Icon(
                  icon,
                  color: Color(0xff484848),
                ),
              ),
              SizedBox(width: 10),
              prblackText(title, 14.5, fontWeight: FontWeight.w600),
            ],
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                Icons.arrow_forward,
              ),
            ),
          )
        ],
      ),
    );
  }
}
