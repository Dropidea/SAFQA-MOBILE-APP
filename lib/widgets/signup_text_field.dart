import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';

class SignUpTextField extends StatefulWidget {
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
    this.textDirection,
    this.suffix,
    this.fillColor,
    this.textInputAction,
    this.autovalidateMode,
    this.width,
    this.height,
    this.focusNode,
    this.style,
  });
  final TextStyle? style;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Widget? suffix;
  final double? width;
  final double? height;
  final FocusNode? focusNode;
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
  AutovalidateMode? autovalidateMode;
  EdgeInsetsGeometry? padding = EdgeInsets.only(left: 15, right: 15, top: 5);
  TextDirection? textDirection;

  @override
  State<SignUpTextField> createState() => _SignUpTextFieldState();
}

class _SignUpTextFieldState extends State<SignUpTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Padding(
        padding: widget.padding!,
        child: TextFormField(
          textDirection: widget.textDirection,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction ?? TextInputAction.next,
          autovalidateMode:
              widget.autovalidateMode ?? AutovalidateMode.disabled,
          keyboardType: widget.keyBoardType,
          decoration: InputDecoration(
              fillColor: widget.fillColor ?? Color(0xffF8F8F8),
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(10.0),
                  borderSide: BorderSide.none),
              hintText: widget.hintText,
              prefixIcon: widget.prefixIcon,
              prefix: widget.prefix,
              suffix: widget.suffix,
              suffixIcon: widget.suffixIcon),
          validator: widget.validator,
          inputFormatters: widget.inputFormatters,
          obscureText: widget.obsecureText,
          initialValue: widget.initialValue,
          style: widget.style ?? blackText("text", 12.5).style,
          onChanged: widget.onchanged,
          readOnly: widget.readOnly,
          controller: widget.controller,
        ),
      ),
    );
  }
}
