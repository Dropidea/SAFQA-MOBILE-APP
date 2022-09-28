import 'package:flutter/material.dart';

class SignUpTextField extends StatelessWidget {
  SignUpTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.keyBoardType,
    this.obsecureText = false,
    this.prefix,
  });

  final String hintText;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputType? keyBoardType;

  bool obsecureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15, top: 5),
        child: TextFormField(
          keyboardType: keyBoardType,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            prefixIcon: prefixIcon,
            prefix: prefix,
          ),
          obscureText: obsecureText,
        ),
      ),
    );
  }
}
