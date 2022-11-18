import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:multiselect/multiselect.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/profile/pr_bank_details.dart';
import 'package:safqa/widgets/custom_drop_down.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import "package:sizer/sizer.dart";

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key});

  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  int isUserEnabled = 0;
  int userRole = 0;
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
  List<String> selected = [];
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: WhiteAppBar(title: "Add User"),
      body: ListView(
        primary: false,
        padding: EdgeInsets.all(20),
        children: [
          blackText("Full Name", 15),
          SignUpTextField(padding: const EdgeInsets.all(0)),
          const SizedBox(height: 20),
          blackText("Phone Number", 15),
          IntlPhoneField(
            flagsButtonPadding: EdgeInsets.symmetric(horizontal: 20),
            dropdownIconPosition: IconPosition.trailing,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              fillColor: Color(0xffF8F8F8),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
            ),
            initialCountryCode: 'AE',
            onChanged: (phone) {},
            onCountryChanged: (value) {},
          ),
          const SizedBox(height: 20),
          blackText("Email", 15),
          SignUpTextField(padding: const EdgeInsets.all(0)),
          const SizedBox(height: 20),
          blackText("Is User Enabled", 15),
          SizedBox(height: 5),
          Row(
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
                        value: 0,
                        groupValue: isUserEnabled,
                        onChanged: (value) {
                          setState(
                            () {
                              isUserEnabled = value;
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
                        value: 1,
                        groupValue: isUserEnabled,
                        onChanged: (value) {
                          setState(
                            () {
                              isUserEnabled = value;
                            },
                          );
                        }),
                  ),
                  greyText("No", 16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          blackText("United Arab Emirates - Roles", 15),
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
                    groupValue: userRole,
                    onChanged: (value) {
                      setState(
                        () {
                          selected = [];
                          userRole = value;
                        },
                      );
                    }),
              ),
              greyText("Normal User ", 16),
            ],
          ),
          SizedBox(height: 10),
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
                    value: 1,
                    groupValue: userRole,
                    onChanged: (value) {
                      setState(
                        () {
                          selected = [];
                          userRole = value;
                        },
                      );
                    }),
              ),
              greyText("Super Master", 16),
            ],
          ),
          SizedBox(height: 10),
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
                    value: 2,
                    groupValue: userRole,
                    onChanged: (value) {
                      setState(
                        () {
                          selected = [];
                          userRole = value;
                        },
                      );
                    }),
              ),
              greyText("API", 16),
            ],
          ),
          userRole == 0
              ? MyMultiDropdown(
                  options: normalUserOptions,
                  selected: selected,
                  onChanged: (p0) {
                    setState(() {
                      selected = p0;
                    });
                  },
                )
              : userRole == 1
                  ? MyMultiDropdown(
                      options: superMasterOptions,
                      selected: selected,
                      onChanged: (p0) {
                        setState(() {
                          selected = p0;
                        });
                      },
                    )
                  : Container(),
          SizedBox(height: 20),
          blackText("United Arab Emirates - Notification Settings", 14),
          CustomDropdown(
            width: w,
            items: ["item1", "item2"],
            onchanged: (s) {},
            hint: "Choose",
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                blackText("Add User", 16),
                SizedBox(width: 10),
                InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 22.0.sp,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
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
      required this.selected});
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
      ),
    );
  }
}
