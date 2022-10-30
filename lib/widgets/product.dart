import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget(
      {super.key,
      required this.active,
      this.onTap,
      this.orderedFlag = false,
      this.orderedState});
  final bool active;
  bool orderedFlag;
  String? orderedState;
  final void Function()? onTap;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: EdgeInsets.all(10),
        width: w,
        height: 150,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 80.0.sp,
              height: 80.0.sp,
              decoration: BoxDecoration(
                color: Color(0xffF5F5F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.photo_rounded,
                  size: 60.0.sp,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText("Nokia 105", 16),
                    greyText("Remaining : 5", 15),
                    !widget.orderedFlag
                        ? widget.active
                            ? greenText("Active", 15)
                            : redText("Inactive", 15)
                        : widget.active
                            ? greenText(widget.orderedState!, 15,
                                underline: true)
                            : greyText(widget.orderedState!, 15,
                                underline: true)
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    !widget.orderedFlag
                        ? GFCheckbox(
                            size: 24,
                            activeBorderColor: Colors.transparent,
                            inactiveBorderColor: Colors.grey,
                            activeBgColor: Color(0xff00A7B3),
                            onChanged: (value) {
                              setState(() {
                                checked = value;
                              });
                            },
                            value: checked)
                        : Container(),
                    Text(
                      "\$ 150",
                      style: TextStyle(
                          fontSize: 18.0.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff2F6782)),
                    )
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
