import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WallpepredBTN extends StatelessWidget {
  const WallpepredBTN({super.key, this.width, this.text, this.onTap});
  final double? width;
  final String? text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff2F6782),
          image: DecorationImage(
            image: AssetImage("assets/images/btn_wallpaper.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: width,
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            text!,
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.0.sp,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}
