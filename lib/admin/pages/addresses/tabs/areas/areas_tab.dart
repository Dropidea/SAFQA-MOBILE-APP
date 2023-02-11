import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import "package:get/get.dart";
import 'package:getwidget/getwidget.dart';
import 'package:safqa/admin/pages/addresses/tabs/areas/create_area.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';

class AreasTab extends StatefulWidget {
  const AreasTab({super.key});

  @override
  State<AreasTab> createState() => AreasTabState();
}

class AreasTabState extends State<AreasTab> {
  GlobalDataController _globalDataController = Get.find();

  @override
  void initState() {
    _globalDataController.getAreas();
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
              Get.to(() => CreateAreaPage());
            }),
        SizedBox(height: 20),
        Expanded(child: GetBuilder<GlobalDataController>(builder: (c) {
          return c.getAreaFlag
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
                              // greyText(c.contactPhones[index].type!, 15),
                            ]),
                            Row(children: [
                              blackText("number".tr + ":", 15),
                              SizedBox(width: 10),
                              // greyText(c.contactPhones[index].number!, 15),
                            ]),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(
                                  () => CreateAreaPage(
                                    areaToEdit: c.areas[index],
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
                  itemCount: c.areas.length,
                );
        }))
      ],
    );
  }
}
