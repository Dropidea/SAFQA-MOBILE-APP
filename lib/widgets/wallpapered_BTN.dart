import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WallpepredBTN extends StatelessWidget {
  const WallpepredBTN(
      {super.key,
      this.width,
      this.text,
      this.onTap,
      this.haveWallpaper = true,
      this.alignment});
  final double? width;
  final String? text;
  final void Function()? onTap;
  final AlignmentGeometry? alignment;
  final bool haveWallpaper;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color(0xff2F6782),
            image: haveWallpaper
                ? DecorationImage(
                    image: AssetImage("assets/images/btn_wallpaper.png"),
                    fit: BoxFit.cover,
                  )
                : null,
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
      ),
    );
  }
}
