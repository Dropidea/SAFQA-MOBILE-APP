import 'package:flutter/material.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class CircularGoBTN extends StatelessWidget {
  const CircularGoBTN({super.key, this.onTap, required this.text});
  final void Function()? onTap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          blackText(text, 16),
          SizedBox(width: 10),
          InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            onTap: onTap,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: EdgeInsets.all(20),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 22.0.sp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
