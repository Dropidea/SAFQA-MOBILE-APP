import "package:flutter/material.dart";

class myDropdown extends StatefulWidget {
  myDropdown({
    Key? key,
  }) : super(key: key);

  @override
  State<myDropdown> createState() => _myDropdownState();
}

class _myDropdownState extends State<myDropdown> {
  final items = ["This Month", "Last Year"];

  String selectedItem = "This Month";

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton(
        items: items
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
