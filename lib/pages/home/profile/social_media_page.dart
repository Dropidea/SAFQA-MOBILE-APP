import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/controller/profile_controller.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class SocialMediaPage extends StatefulWidget {
  SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  String? selectedItem = null;
  TextEditingController socialMediaURLController = TextEditingController();
  ProfileController _profileController = Get.find();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: const WhiteAppBar(title: "Social Media"),
      body: ListView(
        padding: const EdgeInsets.all(20),
        primary: false,
        children: [
          blackText("Social Media Url", 14),
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
              decoration: InputDecoration(border: InputBorder.none),
              items: ["Facebook", "Instagram", "Twitter"]
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: DropdownMenuItem(
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 7),
                              child: Icon(
                                e == "Facebook"
                                    ? EvaIcons.facebook
                                    : e == "Twitter"
                                        ? EvaIcons.twitter
                                        : EvaIcons.globe,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 10),
                            greyText(e, 13)
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
              value: selectedItem,
              hint: greyText("Choose", 15),
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
            ),
          ),
          const SizedBox(height: 20),
          blackText("Social Media Url", 14),
          SignUpTextField(
            padding: const EdgeInsets.all(0),
            controller: socialMediaURLController,
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: MyButton(
              func: () {
                FocusScope.of(context).unfocus();

                SocialMediaItem item = SocialMediaItem(
                    name: selectedItem, link: socialMediaURLController.text);
                _profileController.addSocialMediaItem(item);
                socialMediaURLController.text = "";
                setState(() {});
              },
              heigt: 60,
              width: w / 2.5,
              color: Color(0xff2F6782),
              borderRadius: 10,
              text: "Create New",
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
              itemCount: c.socialMediaItems.length,
              itemBuilder: (context, index) => Container(
                width: w,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        greyText(c.socialMediaItems[index].name!, 15,
                            fontWeight: FontWeight.bold),
                        Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(7),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xffEBF8E8)),
                                child: Icon(
                                  EvaIcons.edit,
                                  color: Color(0xff58D241),
                                )),
                            SizedBox(width: 5),
                            GestureDetector(
                              onTap: () {
                                Get.dialog(AlertDialog(
                                  title: Text(
                                    "Delete Social Media",
                                    style: TextStyle(
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22),
                                  ),
                                  content: Text("Are You Sure?"),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("YES"),
                                      onPressed: () {
                                        c.deleteSocialMediaItem(index);
                                        Get.back();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("NO"),
                                      onPressed: () {
                                        Get.back();
                                      },
                                    ),
                                  ],
                                ));
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
                      c.socialMediaItems[index].link!,
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
