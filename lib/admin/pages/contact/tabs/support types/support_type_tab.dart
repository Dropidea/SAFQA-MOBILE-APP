import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/contact/controller/contact_controller.dart';
import 'package:safqa/admin/pages/contact/tabs/support%20types/create_support_type.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';

class SupportTypesTab extends StatefulWidget {
  const SupportTypesTab({super.key});

  @override
  State<SupportTypesTab> createState() => _SupportTypesTabState();
}

class _SupportTypesTabState extends State<SupportTypesTab> {
  ContactController contactController = Get.find();

  @override
  void initState() {
    contactController.getSupportTypes();
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
              Get.to(() => CreateSupportTypePage());
            }),
        SizedBox(height: 20),
        Expanded(child: GetBuilder<ContactController>(builder: (c) {
          return c.getSupportTypesFlag
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
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(children: [
                          blackText("name".tr + ":", 15),
                          SizedBox(width: 10),
                          greyText(c.supportTypes[index].name!, 15),
                        ]),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => CreateSupportTypePage(
                                    SupportTypeToEdit: c.supportTypes[index],
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
                                      await c.deleteSupportType(
                                          c.supportTypes[index]);
                                    },
                                    message: "Are You Sure");
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
                  itemCount: c.supportTypes.length,
                );
        }))
      ],
    );
  }
}
