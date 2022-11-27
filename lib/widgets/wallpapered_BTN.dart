import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WallpepredBTN extends StatelessWidget {
  const WallpepredBTN(
      {super.key,
      this.width,
      this.text,
      this.onTap,
      this.haveWallpaper = true,
      this.alignment,
      this.icon,
      this.height,
      this.borderRadius,
      this.color});
  final double? width;
  final double? height;
  final double? borderRadius;
  final String? text;
  final void Function()? onTap;
  final AlignmentGeometry? alignment;
  final bool haveWallpaper;
  final IconData? icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment ?? Alignment.center,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
            color: color ?? Color(0xff2F6782),
            image: haveWallpaper
                ? DecorationImage(
                    image: AssetImage("assets/images/btn_wallpaper.png"),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          width: width,
          height: height,
          padding: EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 7),
                child: icon != null
                    ? Icon(
                        icon,
                        // size: 26,
                        color: Colors.white,
                      )
                    : Container(),
              ),
              icon != null ? SizedBox(width: 10) : Container(),
              Text(
                text!,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0.sp,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
