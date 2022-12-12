import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Themes {
  final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: "Tajawal",
    primaryColor: Color(0xff2F6782),
    canvasColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.white,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 16.0.sp),
    ),
    textTheme: TextTheme(),
    buttonTheme: ButtonThemeData(
      colorScheme: ColorScheme.light().copyWith(background: Color(0xff2F6782)),
    ),
  );

  //---------------------------------------------------------------------------//
  final darkTheme = ThemeData(
      brightness: Brightness.dark,
      fontFamily: "Tajawal",
      canvasColor: Colors.grey,
      appBarTheme: AppBarTheme(
        color: Colors.black,
        titleTextStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16.0.sp),
      ),
      buttonTheme: ButtonThemeData(
        colorScheme: ColorScheme.dark().copyWith(background: Colors.grey),
      ),
      backgroundColor: Colors.white,
      inputDecorationTheme: InputDecorationTheme(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        // iconColor: Colors.black,
        iconColor: MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.focused)) {
            return Colors.black;
          }
          if (states.contains(MaterialState.error)) {
            return Colors.red;
          }
          return Colors.grey;
        }),

        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
      ));

  static Color arrowColorLight = Colors.white;
  static Color arrowColorDark = Colors.black;
}
