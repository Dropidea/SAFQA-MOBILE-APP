import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/edit_product_link_page.dart';
import 'package:safqa/utils.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductLinksPage extends StatefulWidget {
  ProductLinksPage({super.key});

  @override
  State<ProductLinksPage> createState() => _ProductLinksPageState();
}

class _ProductLinksPageState extends State<ProductLinksPage> {
  final LocalsController _localsController = Get.put(LocalsController());
  ProductsController productsController = Get.find();
  @override
  void initState() {
    productsController.getProductLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GetBuilder<ProductsController>(builder: (c) {
      return Column(
        children: [
          SizedBox(height: 70),
          // SignUpTextField(
          //   padding: EdgeInsets.all(0),
          //   hintText: "search".tr,
          //   onchanged: (s) {
          //     c.searchForProductsStoreWithName(s!);
          //   },
          //   prefixIcon: Icon(
          //     Icons.search_outlined,
          //     color: Colors.grey,
          //   ),
          //   suffixIcon: GestureDetector(
          //     onTap: () {
          //       FocusScope.of(context).unfocus();
          //       Get.to(() => ProductStoreSearchFilterPage());
          //     },
          //     child: Badge(
          //       badgeColor: Color(0xff1BAFB2),
          //       showBadge: c.productStoreFilter.filterActive,
          //       position: BadgePosition.topEnd(top: 8, end: 8),
          //       child: Image(
          //         image: AssetImage("assets/images/filter.png"),
          //         width: 18,
          //         height: 18,
          //       ),
          //     ),
          //   ),
          // ),
          // const SizedBox(height: 20),
          // SizedBox(
          //   height: 40,
          //   child: ListView(
          //     scrollDirection: Axis.horizontal,
          //     children: [
          //       MyStoreBTN(text: "All", onTap: () {}, selected: true),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "Electronic Devices", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //       MyStoreBTN(text: "lorem ipsum", onTap: () {}),
          //       SizedBox(width: 5),
          //     ],
          //   ),
          // ),
          // SizedBox(height: 20),
          Expanded(
              child: c.getProductsLinksFlag
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : c.productLinks.isEmpty
                      ? Center(
                          child: greyText("nothing_to_show".tr, 20),
                        )
                      : ListView.separated(
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 10),
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 234, 234, 234),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      blackText("name_en".tr + ":", 13),
                                      SizedBox(width: 10),
                                      greyText(
                                          c.productLinks[index].nameEn!, 13),
                                    ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      blackText("name_ar".tr + ":", 13),
                                      SizedBox(width: 10),
                                      greyText(
                                          c.productLinks[index].nameAr!, 13),
                                    ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      blackText("is_active".tr + ":", 13),
                                      SizedBox(width: 10),
                                      c.productLinks[index].isActive == 1
                                          ? greenText("yes".tr, 13)
                                          : redText("no".tr, 13)
                                      // greyText(c.contactPhones[index].number!, 13),
                                    ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      blackText("product_link".tr + ":", 13),
                                      SizedBox(width: 10),
                                      GestureDetector(
                                        onTap: () async {
                                          String tmp = _localsController
                                                      .currenetLocale ==
                                                  0
                                              ? c.productLinks[index].urlEn
                                                  .toString()
                                              : c.productLinks[index].urlAr
                                                  .toString();
                                          final Uri _url = Uri.parse(tmp);

                                          if (!await launchUrl(_url)) {
                                            Utils.showSnackBar(context,
                                                'Could not launch $_url');
                                            ;
                                          }
                                        },
                                        child: blueText(
                                            _localsController.currenetLocale ==
                                                    0
                                                ? c.productLinks[index].urlEn
                                                    .toString()
                                                : c.productLinks[index].urlAr
                                                    .toString(),
                                            13,
                                            underline: true),
                                      ),
                                    ]),
                                    SizedBox(height: 10),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await Clipboard.setData(ClipboardData(
                                              text: _localsController
                                                          .currenetLocale ==
                                                      0
                                                  ? c.productLinks[index].urlEn
                                                      .toString()
                                                  : c.productLinks[index].urlAr
                                                      .toString()));
                                          Utils.showSnackBar(context, "Copied");
                                        },
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            whiteText("copy ".tr, 13),
                                            SizedBox(width: 10),
                                            Icon(EvaIcons.copy)
                                          ],
                                        )),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      blackText(
                                          "terms_conditions".tr + ":", 13),
                                      SizedBox(width: 10),
                                      greyText(
                                          c.productLinks[index]
                                              .termsAndConditions!,
                                          13),
                                    ]),
                                  ],
                                ),
                              ),
                              PositionedDirectional(
                                end: 10,
                                top: 10,
                                child: MyPopUpMenu(
                                  menuList: [
                                    PopupMenuItem(
                                      onTap: () {
                                        Future(
                                            () => Get.to(() => EditProductLink(
                                                  payLinkId: productsController
                                                      .productLinks[index].id!,
                                                )));
                                      },
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
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
                                              fontWeight: FontWeight.bold),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          itemCount: c.productLinks.length,
                        ))
        ],
      );
    });
  }

  Widget MyStoreBTN(
      {String? text, void Function()? onTap, bool selected = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        decoration: BoxDecoration(
            color: const Color(0xffF9F9F9),
            borderRadius: BorderRadius.circular(5),
            border: selected ? Border.all(color: Color(0xff2F6782)) : null),
        child: Center(
          child: selected ? blueText(text!, 12) : greyText(text!, 12),
        ),
      ),
    );
  }
}
