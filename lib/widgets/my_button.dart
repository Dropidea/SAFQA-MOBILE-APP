import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    super.key,
    required this.width,
    required this.heigt,
    required this.color,
    required this.borderRadius,
    required this.text,
    this.func,
    required this.textSize,
    this.textColor,
  });
  final double width;
  final double heigt;
  final Color color;
  final Color? textColor;
  final double borderRadius;
  final String text;
  final Callback? func;
  final double textSize;
  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: func,
      child: Container(
        width: width,
        height: heigt,
        decoration: BoxDecoration(
          color: func == null ? Color(0xffE8E8E8) : color,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: func == null ? Color(0xffBBBBBB) : textColor,
              fontSize: textSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
