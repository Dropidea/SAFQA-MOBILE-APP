import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/admin/pages/contact/tabs/contact%20phones/create_contact_phone.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';

class ContactPhonesTab extends StatefulWidget {
  const ContactPhonesTab({super.key});

  @override
  State<ContactPhonesTab> createState() => _ContactPhonesTabState();
}

class _ContactPhonesTabState extends State<ContactPhonesTab> {
  ContactController contactController = Get.find();

  @override
  void initState() {
    contactController.getContactPhones();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 70),
        AddNewButton(
            width: w,
            height: 50,
            onTap: () {
              Get.to(() => CreateContactPhonesPage());
            }),
        SizedBox(height: 20),
        Expanded(child: GetBuilder<ContactController>(builder: (c) {
          return c.getContactPhonesFlag
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => SizedBox(height: 10),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 234, 234, 234),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              blackText("type".tr + ":", 15),
                              SizedBox(width: 10),
                              greyText(c.contactPhones[index].type!, 15),
                            ]),
                            Row(children: [
                              blackText("number".tr + ":", 15),
                              SizedBox(width: 10),
                              greyText(c.contactPhones[index].number!, 15),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => CreateContactPhonesPage(
                                    contactPhoneToEdit: c.contactPhones[index],
                                  ),
                                );
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: GFColors.SUCCESS.withOpacity(0.2),
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
                                    },
                                    message: "are_you_sure".tr);
                              },
                              child: Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color: GFColors.DANGER.withOpacity(0.2),
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
                  ),
                  itemCount: c.contactPhones.length,
                );
        }))
      ],
    );
  }
}
