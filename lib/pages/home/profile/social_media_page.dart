import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/controller/profile_controller.dart';
import 'package:safqa/pages/home/profile/models/social_media_link.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/dialoges.dart';
import 'package:safqa/widgets/gradient_icon.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class SocialMediaPage extends StatefulWidget {
  SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int? selectedItemId;
  String? selectedItem;
  TextEditingController socialMediaURLController = TextEditingController();
  ProfileController _profileController = Get.find();
  final LocalsController _localsController = Get.put(LocalsController());
  bool engflag = true;
  @override
  void initState() {
    engflag = _localsController.currenetLocale == 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: MyAppBar(title: "social_media".tr),
      body: ListView(
        padding: const EdgeInsets.all(20),
        primary: false,
        children: [
          blackText("social_media_url".tr, 14),
          Container(
            width: w,
            height: 50,
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.only(left: 15, right: 15),
            decoration: BoxDecoration(
                color: Color(0xffF8F8F8),
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.transparent)),
            child: DropdownButtonFormField(
              onSaved: (newValue) {},
              decoration: InputDecoration(border: InputBorder.none),
              items: ["Facebook", "Instagram", "Twitter", "Whatsapp"]
                  .map(
                    (e) => DropdownMenuItem(
                      onTap: () {
                        socialMediaURLController.text = "https://www.$e.com/";
                      },
                      value: e,
                      child: DropdownMenuItem(
                        child: Row(
                          children: [
                            e == "Instagram"
                                ? GradientIcon(
                                    FontAwesomeIcons.instagram,
                                    24,
                                    LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [
                                        Color(0xfffbad50),
                                        Color(0xffe95950),
                                        Color(0xff8a3ab9),
                                      ],
                                    ))
                                : Icon(
                                    e == "Facebook"
                                        ? FontAwesomeIcons.facebook
                                        : e == "Twitter"
                                            ? FontAwesomeIcons.twitter
                                            : FontAwesomeIcons.whatsapp,
                                    color: e == "Facebook"
                                        ? Color(0xff4267B2)
                                        : e == "Twitter"
                                            ? Color(0xff1DA1F2)
                                            : Color(0xff4FCE5D),
                                  ),
                            const SizedBox(width: 10),
                            blackText(e, 13)
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: selectedItem,
              hint: greyText("choose".tr, 15),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                  switch (value) {
                    case "Facebook":
                      selectedItemId = 1;
                      break;
                    case "Instagram":
                      selectedItemId = 2;
                      break;
                    case "Twitter":
                      selectedItemId = 3;
                      break;
                    case "Whatsapp":
                      selectedItemId = 4;
                      break;
                    default:
                  }
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          blackText("social_media_url".tr, 14),
          Directionality(
            textDirection: TextDirection.ltr,
            child: SignUpTextField(
              padding: const EdgeInsets.all(0),
              controller: socialMediaURLController,
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: MyButton(
              func: () async {
                FocusScope.of(context).unfocus();
                if (selectedItemId != null) {
                  SocialMediaLink item = SocialMediaLink(
                    socialId: selectedItemId,
                    url: socialMediaURLController.text,
                  );
                  bool v = await _profileController.addSocialMediaItem(item);
                  if (v) {
                    socialMediaURLController.text = "";
                    selectedItemId = null;
                    selectedItem = null;
                    setState(() {});
                  }
                }
              },
              heigt: 60,
              width: w / 2.5,
              color: Color(0xff2F6782),
              borderRadius: 10,
              text: "c_n".tr,
              textSize: 13,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 10),
              icon: Icon(
                EvaIcons.plus,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 30),
          GetBuilder<ProfileController>(builder: (c) {
            return ListView.builder(
              shrinkWrap: true,
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              itemCount: c.socialMediaLinks.length,
              itemBuilder: (context, index) => Container(
                width: w,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        greyText(
                            engflag
                                ? c.socialMediaLinks[index].socialMedia!.nameAr!
                                : c.socialMediaLinks[index].socialMedia!
                                    .nameAr!,
                            15,
                            fontWeight: FontWeight.bold),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xffEBF8E8)),
                                  child: Icon(
                                    EvaIcons.edit,
                                    color: Color(0xff58D241),
                                  )),
                            ),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                MyDialogs.showDeleteDialoge(
                                  onProceed: () async {
                                    await c.deleteSocialMediaItem(
                                        c.socialMediaLinks[index].id!);
                                    Get.back();
                                  },
                                  message: "Are You Sure?",
                                );
                              },
                              child: Container(
                                  padding: EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color:
                                          Color(0xffE47E7B).withOpacity(0.1)),
                                  child: Icon(
                                    EvaIcons.trash2,
                                    color: Color(0xffE47E7B),
                                  )),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 5),
                    greyText(
                      c.socialMediaLinks[index].url!,
                      15,
                    ),
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }
}
