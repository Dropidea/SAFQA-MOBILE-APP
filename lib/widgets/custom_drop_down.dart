import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown(
      {super.key,
      required this.width,
      required this.items,
      this.selectedItem,
      this.hint,
      required this.onchanged,
      this.backgroundColor,
      this.borderColor,
      this.border,
      this.height,
      this.validator});
  final double? width;
  final double? height;
  final List<String> items;
  final String? selectedItem;
  final String? hint;
  final Function(String? s)? onchanged;
  final Color? backgroundColor;
  final Color? borderColor;
  final InputBorder? border;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          color: backgroundColor ?? Color(0xffF8F8F8),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor ?? Colors.transparent)),
      child: DropdownButtonFormField(
        validator: validator,
        decoration: InputDecoration(border: border ?? InputBorder.none),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: blackText(e, 13),
              ),
            )
            .toList(),
        value: selectedItem,
        hint: greyText(hint ?? "", 15),
        onChanged: onchanged,
      ),
    );
  }
}

class CustomDropdownV2 extends StatelessWidget {
  CustomDropdownV2(
      {super.key,
      required this.width,
      required this.items,
      this.selectedItem,
      this.hint,
      required this.onchanged,
      this.backgroundColor,
      this.borderColor,
      this.border,
      this.height,
      this.validator,
      this.focusNode});
  final double? width;
  final double? height;
  final List<String> items;
  final String? selectedItem;
  final String? hint;
  final Function(String? s)? onchanged;
  final Color? backgroundColor;
  final Color? borderColor;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      // margin: const EdgeInsets.symmetric(vertical: 5),
      // padding: const EdgeInsets.only(left: 15, right: 15),
      decoration: BoxDecoration(
          // color: backgroundColor ?? Color(0xffF8F8F8),
          // borderRadius: BorderRadius.circular(10.0),
          // border: Border.all(color: borderColor ?? Colors.transparent),
          ),
      child: DropdownButtonFormField(
        focusNode: focusNode,
        validator: validator,
        decoration: InputDecoration(
          border: border ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
          filled: true,
          fillColor: backgroundColor ?? Color(0xffF8F8F8),
        ),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: blackText(e, 12.5),
              ),
            )
            .toList(),
        value: selectedItem,
        hint: greyText(hint ?? "", 15),
        onChanged: onchanged,
      ),
    );
  }
}
