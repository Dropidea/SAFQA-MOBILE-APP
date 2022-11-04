import 'package:flutter/material.dart';

class MyPopUpMenu extends StatelessWidget {
  const MyPopUpMenu(
      {super.key,
      required this.menuList,
      this.onSelected,
      this.iconColor,
      this.widget,
      this.icon});
  final List<PopupMenuEntry> menuList;
  final Color? iconColor;
  final Function(dynamic)? onSelected;
  final Widget? icon;
  final Widget? widget;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      position: PopupMenuPosition.under,
      elevation: 5,
      onSelected: onSelected,
      itemBuilder: (context) => menuList,
      icon: widget == null
          ? icon ??
              Icon(
                Icons.more_vert,
                color: iconColor == null ? Color(0xff6A6A6A) : iconColor,
              )
          : null,
      child: icon == null ? widget : null,
    );
  }
}
