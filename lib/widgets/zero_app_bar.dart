import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

class ZeroAppBar extends StatelessWidget implements PreferredSizeWidget {
  const ZeroAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xff2F6782),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(0);
}
