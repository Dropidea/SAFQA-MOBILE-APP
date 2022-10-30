import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    super.key,
    this.hintText,
    this.prefixIcon,
    this.keyBoardType,
    this.obsecureText = false,
    this.readOnly = false,
    this.prefix,
    this.validator,
    this.onchanged,
    this.initialValue,
    this.controller,
    this.inputFormatters,
    this.padding = const EdgeInsets.only(left: 15, right: 15, top: 5),
    this.suffixIcon,
    this.suffix,
    this.fillColor,
    this.textInputAction,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final TextInputAction? textInputAction;
  final TextInputType? keyBoardType;
  final String? Function(String? s)? validator;
  final String? initialValue;
  final TextEditingController? controller;
  final Function(String? s)? onchanged;
  List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  bool obsecureText = false;
  bool readOnly = false;
  EdgeInsetsGeometry? padding = EdgeInsets.only(left: 15, right: 15, top: 5);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Padding(
        padding: padding!,
        child: TextFormField(
          textInputAction: textInputAction ?? TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          keyboardType: keyBoardType,
          decoration: InputDecoration(
              fillColor: fillColor ?? Colors.grey.shade200,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
              hintText: hintText,
              prefixIcon: prefixIcon,
              prefix: prefix,
              suffix: suffix,
              suffixIcon: suffixIcon),
          validator: validator,
          inputFormatters: inputFormatters,
          obscureText: obsecureText,
          initialValue: initialValue,
          onChanged: onchanged,
          readOnly: readOnly,
          controller: controller,
        ),
      ),
    );
  }
}
