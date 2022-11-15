import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:sizer/sizer.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    this.width,
    this.heigt,
    required this.color,
    required this.borderRadius,
    required this.text,
    this.func,
    required this.textSize,
    this.textColor,
    this.padding,
    this.icon,
    this.border,
  });
  final double? width;
  final double? heigt;
  final Color color;
  final Color? textColor;
  final double borderRadius;
  final String text;
  final Callback? func;
  final double textSize;
  final Icon? icon;
  final EdgeInsetsGeometry? padding;
  final BoxBorder? border;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: func,
      child: Container(
        padding: padding,
        width: width,
        height: heigt,
        decoration: BoxDecoration(
            color: func == null ? Color(0xffE8E8E8) : color,
            borderRadius: BorderRadius.circular(borderRadius),
            border: border),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 7),
              child: icon,
            ),
            icon != null ? SizedBox(width: 5) : Container(),
            Text(
              text,
              style: TextStyle(
                color: func == null ? Color(0xffBBBBBB) : textColor,
                fontSize: textSize.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
