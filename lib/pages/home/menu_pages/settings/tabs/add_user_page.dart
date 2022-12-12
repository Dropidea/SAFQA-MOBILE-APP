import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:multiselect/multiselect.dart';
import 'package:safqa/controllers/global_data_controller.dart';
import 'package:safqa/controllers/signup_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/settings/controllers/manage_users_controller.dart';
import 'package:safqa/pages/home/menu_pages/settings/models/manage_user.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/circular_go_btn.dart';
import 'package:safqa/widgets/signup_text_field.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key, this.userToEdit});
  final ManageUser? userToEdit;

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  int isUserEnabled = 0;
  int userRole = -1;
  List<String> superMasterOptions = [
    "Create Invoice",
    'Create Batch Invoice',
    "Refund Transfered",
    "Approve Vendor Account",
    "Invoice Paid",
    "Deposit",
    "Notifications Service Request",
    "Create Shipping Invoice",
    "New Order",
    "Create Recurring Invoice",
    "Notifications Hourly Deposit Rejected",
  ];
  List<String> normalUserOptions = [
    "Batch Invoices",
    "Deposits",
    "Payment Links",
    "Profile",
    "Users",
    "Refund",
    "Show All Invoices",
    "View Refund",
    "Customers",
    "Invoices",
    "Products",
    "Commissions",
    "Account Statements",
    "Orders",
    "Suppliers"
  ];
  List<String> notificationSettings = [
    "Notification Create Invoice",
    "Notification Approve Vendor Account",
    "Notification Create Batch Invoice",
    "Notification Profile",
    "Notification Create Recurring Invoice",
    "Notification Create Shipping Invoice",
    "Notification Deposit",
    "Notification Invoice Paid",
    "Notification New Order",
    "Notification Notifications Hourly Deposit Rejected",
    "Notification Notifications Service Request",
    "Notification Refund Transfered",
  ];

  GlobalDataController globlDataController = Get.find();
  ManageUserController manageUserController = Get.find();
  UserRole role = UserRole(nameEn: "", nameAr: "", id: -1);

  ManageUser userToCreate = ManageUser();
  List<String> selectedRoles = [];
  List<String> selectedNotifications = [];
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.userToEdit != null) {
      userRole = widget.userToEdit!.userRole!.id!;
      role = widget.userToEdit!.userRole!;
      if (role.nameEn == "Super Master") widget.userToEdit!.superMaster();
      selectedRoles = widget.userToEdit!.getSelectedRoles();
      selectedNotifications = widget.userToEdit!.getSelectedNotifications();
    } else {
      userRole = globlDataController.roles[0].id!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          MyAppBar(title: widget.userToEdit != null ? "Edit User" : "Add User"),
      body: Form(
        key: formKey,
        child: ListView(
          primary: false,
          padding: EdgeInsets.all(20),
          children: [
            blackText("Full Name", 15),
            SignUpTextField(
              padding: const EdgeInsets.all(0),
              initialValue: widget.userToEdit != null
                  ? widget.userToEdit!.fullName
                  : null,
              onchanged: (s) {
                if (widget.userToEdit != null) {
                  widget.userToEdit!.fullName = s;
                } else {
                  userToCreate.fullName = s;
                }
              },
            ),
            const SizedBox(height: 20),
            blackText("Phone Number", 15),
            GetBuilder<SignUpController>(builder: (c) {
              List countries = c.globalData['country'];
              List<String> ids = countries
                  .map<String>(
                    (e) => e['id'].toString(),
                  )
                  .toSet()
                  .toList();
              List<String> countriesCodes = countries
                  .map<String>(
                    (e) => e['code'].toString(),
                  )
                  .toSet()
                  .toList();

              return SignUpTextField(
                padding: EdgeInsets.all(0),
                keyBoardType: TextInputType.number,
                prefixIcon: SizedBox(
                  width: 60,
                  child: DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: InputBorder.none),
                    isExpanded: true,
                    items: countriesCodes
                        .map((e) => DropdownMenuItem<String>(
                              child: Center(child: Text(e)),
                              value: e,
                            ))
                        .toList(),
                    value: widget.userToEdit != null
                        ? countriesCodes[ids.indexOf(widget
                            .userToEdit!.phoneNumberCodeManagerId
                            .toString())]
                        : countriesCodes[0],
                    onChanged: (value) {
                      if (widget.userToEdit != null) {
                        widget.userToEdit!.phoneNumberCodeManagerId =
                            int.parse(ids[countriesCodes.indexOf(value!)]);
                      } else {
                        userToCreate.phoneNumberCodeManagerId =
                            int.parse(ids[countriesCodes.indexOf(value!)]);
                      }
                    },
                  ),
                ),
                onchanged: (s) {
                  if (widget.userToEdit != null) {
                    widget.userToEdit!.phoneNumberManager = s;
                  } else {
                    userToCreate.phoneNumberManager = s;
                  }
                },
                initialValue: widget.userToEdit != null
                    ? widget.userToEdit!.phoneNumberManager
                    : null,
                validator: (s) {
                  if (s!.isEmpty) return "required";
                  return null;
                },
                hintText: 'Manager Mobile Number',
              );
            }),

            // IntlPhoneField(
            //   flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
            //   dropdownIconPosition: IconPosition.trailing,
            //   keyboardType: TextInputType.number,
            //   decoration: InputDecoration(
            //     fillColor: Color(0xffF8F8F8),
            //     filled: true,
            //     border: OutlineInputBorder(
            //         borderRadius: new BorderRadius.circular(10.0),
            //         borderSide: BorderSide.none),
            //   ),
            //   initialCountryCode: 'AE',
            //   onChanged: (phone) {},
            //   onCountryChanged: (value) {},
            // ),

            const SizedBox(height: 20),
            blackText("Email", 15),
            SignUpTextField(
              padding: const EdgeInsets.all(0),
              initialValue:
                  widget.userToEdit != null ? widget.userToEdit!.email : null,
              onchanged: (s) {
                if (widget.userToEdit != null) {
                  widget.userToEdit!.email = s;
                } else {
                  userToCreate.email = s;
                }
              },
              validator: (s) {
                if (s!.isEmpty) {
                  return "required";
                } else if (!EmailValidator.validate(s)) {
                  return "please enter a valid email!";
                }
              },
            ),
            const SizedBox(height: 20),
            widget.userToEdit != null
                ? blackText("Is User Enabled", 15)
                : Container(),
            widget.userToEdit != null ? SizedBox(height: 5) : Container(),
            widget.userToEdit != null
                ? Row(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: GFRadio(
                                activeBorderColor: Colors.transparent,
                                inactiveBorderColor: Colors.transparent,
                                radioColor: Color(0xff66B4D2),
                                inactiveIcon: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey.shade400,
                                ),
                                size: GFSize.SMALL,
                                value: 1,
                                groupValue: widget.userToEdit!.isEnable,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      widget.userToEdit!.isEnable = value;
                                    },
                                  );
                                }),
                          ),
                          greyText("Yes", 16),
                        ],
                      ),
                      SizedBox(width: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 7),
                            child: GFRadio(
                                activeBorderColor: Colors.transparent,
                                radioColor: Color(0xff66B4D2),
                                inactiveIcon: Icon(
                                  Icons.circle_outlined,
                                  color: Colors.grey.shade400,
                                ),
                                size: GFSize.SMALL,
                                inactiveBorderColor: Colors.transparent,
                                value: 0,
                                groupValue: widget.userToEdit!.isEnable,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      widget.userToEdit!.isEnable = value;
                                    },
                                  );
                                }),
                          ),
                          greyText("No", 16),
                        ],
                      ),
                    ],
                  )
                : Container(),
            const SizedBox(height: 20),
            blackText("United Arab Emirates - Roles", 15),

            ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: GFRadio(
                            activeBorderColor: Colors.transparent,
                            radioColor: Color(0xff66B4D2),
                            inactiveIcon: Icon(
                              Icons.circle_outlined,
                              color: Colors.grey.shade400,
                            ),
                            size: GFSize.SMALL,
                            inactiveBorderColor: Colors.transparent,
                            value: globlDataController.roles[index].id,
                            groupValue: userRole,
                            onChanged: (value) {
                              selectedRoles = [];

                              if (widget.userToEdit != null) {
                                if (globlDataController.roles[index].nameEn ==
                                    "Super Master") {
                                  widget.userToEdit!.superMaster();
                                } else {
                                  widget.userToEdit!.normalUser(selectedRoles);
                                }

                                role = globlDataController.roles[index];
                                widget.userToEdit!.roleId = role.id;
                                userRole = value!;
                              } else {
                                if (globlDataController.roles[index].nameEn ==
                                    "Super Master") {
                                  userToCreate.superMaster();
                                } else {
                                  userToCreate.normalUser(selectedRoles);
                                }

                                role = globlDataController.roles[index];
                                userToCreate.roleId = role.id;
                                userRole = value!;
                              }
                              setState(() {});
                            }),
                      ),
                      greyText(globlDataController.roles[index].nameEn!, 16),
                    ],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                itemCount: globlDataController.roles.length),

            role.nameEn! == "User Normal"
                ? MyMultiDropdown(
                    childBuilder: (selectedValues) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: selectedValues.isEmpty
                            ? greyText("Choose roles", 14)
                            : blackText("Edit selected roles", 14),
                      );
                    },
                    options: normalUserOptions,
                    selected: selectedRoles,
                    onChanged: (p0) {
                      if (widget.userToEdit != null) {
                        setState(() {
                          selectedRoles = p0;
                          widget.userToEdit!.normalUser(selectedRoles);
                        });
                      } else {
                        setState(() {
                          selectedRoles = p0;
                          userToCreate.normalUser(selectedRoles);
                        });
                      }
                    },
                  )
                : Container(),
            SizedBox(height: 20),
            blackText("United Arab Emirates - Notification Settings", 14),
            MyMultiDropdown(
              childBuilder: (selectedValues) {
                return Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: selectedValues.isEmpty
                      ? greyText("Choose Notification Settings", 14)
                      : blackText("Edit Selected Notification Settings", 14),
                );
              },
              width: w,
              // items: notificationSettings,
              // onchanged: (s) {},
              // hint: "Choose",
              onChanged: (List<String> s) {
                if (widget.userToEdit != null) {
                  setState(() {
                    selectedNotifications = s;
                    widget.userToEdit!.notificationSettingsSet(s);
                  });
                } else {
                  selectedNotifications = s;
                  userToCreate.notificationSettingsSet(s);
                }
                setState(() {});
              },
              options: notificationSettings, selected: selectedNotifications,
            ),
            SizedBox(height: 40),
            CircularGoBTN(
              text: "Add User",
              onTap: () async {
                FocusScope.of(context).unfocus();
                // logWarning(widget.userToEdit!.toJson());
                if (formKey.currentState!.validate()) {
                  if (widget.userToEdit != null) {
                    await manageUserController
                        .editManageUser(widget.userToEdit!);
                    // logSuccess(widget.userToEdit!.toJson());
                  } else {
                    userToCreate.nationalityId =
                        globlDataController.me.nationality!.id;
                    userToCreate.roleId = userRole;
                    await manageUserController.createManageUser(userToCreate);
                  }
                }
              },
            )
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     children: [
            //       blackText("Add User", 16),
            //       SizedBox(width: 10),
            //       InkWell(
            //         customBorder: RoundedRectangleBorder(
            //           borderRadius: BorderRadius.circular(40),
            //         ),
            //         onTap: () {},
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.black,
            //             borderRadius: BorderRadius.circular(40),
            //           ),
            //           padding: EdgeInsets.all(20),
            //           child: Icon(
            //             Icons.arrow_forward,
            //             color: Colors.white,
            //             size: 22.0.sp,
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

class MyMultiDropdown extends StatelessWidget {
  MyMultiDropdown(
      {super.key,
      this.hintText,
      this.prefixIcon,
      this.prefix,
      this.suffixIcon,
      this.suffix,
      this.width,
      this.height,
      this.textInputAction,
      this.keyBoardType,
      this.validator,
      this.initialValue,
      this.controller,
      this.fillColor,
      required this.onChanged,
      required this.options,
      required this.selected,
      required this.childBuilder});
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final double? width;
  final double? height;

  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final String? Function(String? s)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Color? fillColor;
  final Widget Function(List<String>) childBuilder;
  bool obsecureText = false;
  bool readOnly = false;
  AutovalidateMode? autovalidateMode;
  final dynamic Function(List<String>) onChanged;
  final List<String> options;
  final List<String> selected;

  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Container(
      width: w,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: new BorderRadius.circular(10.0),
        color: fillColor ?? Color(0xffF8F8F8),
      ),
      child: DropDownMultiSelect(
        onChanged: onChanged,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: new BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
            hintText: hintText,
            prefixIcon: prefixIcon,
            prefix: prefix,
            suffix: suffix,
            suffixIcon: suffixIcon),
        options: options,
        selectedValues: selected,
        whenEmpty: 'Choose',
        childBuilder: childBuilder,
      ),
    );
  }
}
