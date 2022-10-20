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
      required this.onchanged});
  final double width;
  final List<String> items;
  final String? selectedItem;
  final String? hint;
  final Function(String? s)? onchanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.only(left: 15, right: 15, top: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: DropdownButtonFormField(
        decoration: const InputDecoration(border: InputBorder.none),
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                ),
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
