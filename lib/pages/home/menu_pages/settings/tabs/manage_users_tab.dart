import 'package:badges/badges.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/manage_users_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/add_user_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/user_details.dart';
import 'package:safqa/pages/home/menu_pages/settings/tabs/users_search_filter_page.dart';
import 'package:safqa/widgets/my_button.dart';
import 'package:safqa/widgets/popup_menu.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class ManageUsersTab extends StatefulWidget {
  ManageUsersTab({super.key});

  @override
  State<ManageUsersTab> createState() => _ManageUsersTabState();
}

class _ManageUsersTabState extends State<ManageUsersTab> {
  ManageUserController _manageUserController = Get.put(ManageUserController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _manageUserController.getManageUsers();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(height: 60),
        SignUpTextField(
          padding: EdgeInsets.all(0),
          hintText: "search".tr,
          prefixIcon: Icon(
            Icons.search_outlined,
            color: Colors.grey,
          ),
          onchanged: (s) {
            _manageUserController.searchForProductsWithName(s!);
            setState(() {});
          },
          suffixIcon: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
              Get.to(() => MUsersSearchFilterPage());
            },
            child: GetBuilder<ManageUserController>(builder: (c) {
              return Badge(
                badgeColor: Color(0xff1BAFB2),
                showBadge: c.manageUserFilter.filterActive,
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
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            Get.to(() => AddUserPage());
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
        SizedBox(height: 20),
        Expanded(child: GetBuilder<ManageUserController>(builder: (c) {
          return c.getManageUserFlag
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) => GestureDetector(
                        onTap: () => Get.to(() => ManageUserDetailsPage(
                              manageUser: c.manageUsersToShow[index],
                            )),
                        child: Row(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xffF9F9F9),
                              ),
                              child: Center(
                                child: greyText("A", 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  blackText(
                                      c.manageUsersToShow[index].fullName!, 15),
                                  SizedBox(height: 5),
                                  blueText(
                                    c.manageUsersToShow[index].email!.length >
                                            20
                                        ? c.manageUsersToShow[index].email!
                                                .substring(0, 20) +
                                            "..."
                                        : c.manageUsersToShow[index].email!,
                                    14,
                                    // underline: true,
                                  ),
                                  SizedBox(height: 5),
                                  greyText(
                                      c.manageUsersToShow[index]
                                          .phoneNumberManager!,
                                      14),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => SizedBox(
                        height: 20,
                      ),
                  itemCount: c.manageUsersToShow.length);
        }))
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
