import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/colors/gf_color.dart';
import 'package:safqa/admin/pages/addresses/tabs/countries/country_details.dart';
import 'package:safqa/admin/pages/addresses/tabs/countries/create_country.dart';
import 'package:safqa/admin/pages/recurring%20interval/recurring_intervals_page.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/dialoges.dart';

class CountriesTab extends StatefulWidget {
  CountriesTab({super.key});

  @override
  State<CountriesTab> createState() => _CountriesTabState();
}

class _CountriesTabState extends State<CountriesTab> {
  final LocalsController _localsController = Get.put(LocalsController());
  GlobalDataController _globalDataController = Get.find();
  @override
  void initState() {
    _globalDataController.getCountries();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<GlobalDataController>(builder: (c) {
      return Column(
        children: [
          SizedBox(height: 70),
          AddNewButton(
            height: 50,
            width: w,
            onTap: () {
              Get.to(() => CreateCountryPage());
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: c.getCountriesFlag
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemBuilder: (context, index) =>
                        Builder(builder: (context) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(() => CountryDetailsPage(
                                  country: c.countries[index]));
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 234, 234, 234),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(children: [
                                        blackText("name_en".tr + ":", 13),
                                        SizedBox(width: 10),
                                        greyText(
                                            c.countries[index].nameEn!, 13),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        blackText("name_ar".tr + ":", 13),
                                        SizedBox(width: 10),
                                        greyText(
                                            c.countries[index].nameAr!, 13),
                                      ]),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        blackText("active".tr + ":", 13),
                                        SizedBox(width: 10),
                                        c.countries[index].countryActive == 0
                                            ? redText("no".tr, 13)
                                            : greenText("yes".tr, 13)
                                      ]),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(
                                            () => CreateCountryPage(
                                              countryToEdit: c.countries[index],
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
                                                c.deleteCountry(
                                                    c.countries[index]);
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
                            ),
                          );
                        }),
                    itemCount: _globalDataController.countries.length),
          )
        ],
      );
    });
  }
}
