import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  const MyPopUpMenu(
      {super.key, required this.menuList, this.onSelected, this.iconColor});
  final List<PopupMenuEntry> menuList;
  final Color? iconColor;
  final Function(dynamic)? onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      elevation: 5,
      onSelected: onSelected,
      itemBuilder: (context) => menuList,
      icon: Icon(
        Icons.more_vert,
        color: iconColor == null ? Color(0xff6A6A6A) : iconColor,
      ),
    );
  }
}
