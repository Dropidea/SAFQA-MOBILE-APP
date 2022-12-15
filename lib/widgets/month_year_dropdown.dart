import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';

class myDropdown extends StatefulWidget {
  myDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<myDropdown> createState() => _myDropdownState();
}

class _myDropdownState extends State<myDropdown> {
  LocalsController localsController = Get.find();
  final List<String> items_en = ["This Month", "Last Year"];
  final List<String> items_ar = ["هذا الشهر", "العام الفائت"];

  String? selectedItem;
  @override
  void initState() {
    selectedItem =
        localsController.currenetLocale == 0 ? items_en[0] : items_ar[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: localsController.currenetLocale == 0
            ? items_en
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList()
            : items_ar
                .map((e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ))
                .toList(),
        value: selectedItem,
        onChanged: (value) {
          selectedItem = value!;
          setState(() {});
        },
      ),
    );
  }
}
