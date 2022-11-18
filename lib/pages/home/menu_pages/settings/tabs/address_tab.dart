import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_address_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/address_details.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:sizer/sizer.dart';

class AdressesTab extends StatelessWidget {
  const AdressesTab({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 60),
        GestureDetector(
          onTap: () {
            Get.to(() => AddAddressPage());
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
                ..arcToPoint(Offset(10, 0), radius: Radius.circular(10));
            },
            color: Color(0xff2F6782).withOpacity(0.4),
            strokeWidth: 1,
            dashPattern: [10, 5],
            child: Container(
              width: w,
              height: 45,
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
                    "Create a new one",
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
        SizedBox(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              listBTN(
                  text: "Select All",
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        actionsPadding: EdgeInsets.only(bottom: 30),
                        titlePadding: EdgeInsets.all(0),
                        actionsAlignment: MainAxisAlignment.center,
                        actions: [
                          MyButton(
                            width: 0.3 * w,
                            heigt: 35.0.sp,
                            color: Color(0xffF3F3F3),
                            borderRadius: 10,
                            textColor: Color(0xff2D5571),
                            text: "Open",
                            textSize: 15.0,
                            func: () {},
                          ),
                          MyButton(
                            width: 0.3 * w,
                            heigt: 35.0.sp,
                            color: Color(0xff2D5571),
                            borderRadius: 10,
                            text: "Copy Link",
                            textColor: Colors.white,
                            textSize: 13.0,
                            func: () {},
                          )
                        ],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(32.0),
                          ),
                        ),
                        title: _dialogeTitle(),
                        content: Container(
                          width: w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Color(0xffBBBBBB))),
                          child: TextFormField(
                            initialValue: "www.google.com",
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              SizedBox(width: 5),
              listBTN(text: "Copy", onTap: () {}),
              SizedBox(width: 5),
              // listBTN(text: "Print", onTap: () {}),
              MyPopUpMenu(
                menuList: [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          EvaIcons.file,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(width: 10),
                        Text("PDF"),
                      ],
                    ),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Icon(
                          Icons.print,
                          color: Colors.grey.shade500,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Printer"),
                      ],
                    ),
                  ),
                ],
                widget: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xffF9F9F9),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: blueText("print", 12),
                  ),
                ),
              ),
              SizedBox(width: 5),

              listBTN(text: "Excel", onTap: () {}),
              SizedBox(width: 5),
              listBTN(text: "CSV", onTap: () {}),
              SizedBox(width: 5),
            ],
          ),
        ),
        Expanded(
            child: ExpandableNotifier(
          child: ListView.separated(
              itemBuilder: (context, index) => index == 0
                  ? SizedBox(
                      height: 10,
                    )
                  : AddressWidget(
                      address: 'Dubai',
                      addressType: 'Appartment',
                      area: 'Sharka',
                      block: "21",
                      avenue: 'Lorem',
                      street: "Lorem absum, kghe wpfl bqwhd",
                      onTap: () => Get.to(() => AddressDetailsPage()),
                    ),
              separatorBuilder: (context, index) => SizedBox(
                    height: 20,
                  ),
              itemCount: 10),
        ))
      ],
    );
  }

  Widget _dialogeTitle() {
    return Stack(
      children: [
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 25.0),
            width: 55.0.sp,
            height: 70.0.sp,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/logo/logo.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          right: 25,
          top: 25,
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.close,
              color: Color.fromARGB(255, 0, 0, 0),
              size: 20,
            ),
          ),
        )
      ],
    );
  }
}

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.address,
    required this.addressType,
    required this.area,
    required this.block,
    required this.avenue,
    required this.street,
    this.onTap,
  }) : super(key: key);
  final String address;
  final String addressType;
  final String area;
  final String block;
  final String avenue;
  final String street;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ExpandablePanel(
            theme: ExpandableThemeData(iconColor: Color(0xff2F6782)),
            header: Container(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 7),
                    child: Icon(Icons.location_pin, color: Color(0xff2F6782)),
                  ),
                  SizedBox(width: 10),
                  blueText(address, 15, fontWeight: FontWeight.bold),
                ],
              ),
            ),
            controller: ExpandableController(initialExpanded: true),
            collapsed: Container(),
            expanded: Container(
              margin: EdgeInsets.only(top: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      greyText("Address Type:", 13),
                      SizedBox(width: 5),
                      blackText(addressType, 13)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      greyText("Area:", 13),
                      SizedBox(width: 5),
                      blackText(area, 13)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      greyText("Block:", 13),
                      SizedBox(width: 5),
                      blackText(block, 13)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      greyText("Avenue:", 13),
                      SizedBox(width: 5),
                      blackText(avenue, 13)
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      greyText("Street:", 13),
                      SizedBox(width: 5),
                      blackText(street, 13)
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          )),
    );
  }
}

Widget listBTN({String? text, void Function()? onTap, double? width}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 25),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: blueText(text!, 11),
      ),
    ),
  );
}
