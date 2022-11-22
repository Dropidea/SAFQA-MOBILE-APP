import 'package:flutter/material.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget(
      {super.key,
      this.onTap,
      this.orderedFlag = false,
      this.orderedState,
      required this.product});
  final Product product;
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
                child: widget.product.productImage != null
                    ? Image(
                        image: NetworkImage(widget.product.productImage),
                        fit: BoxFit.contain,
                        width: 60.0.sp,
                        height: 60.0.sp,
                      )
                    : Icon(
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
                    blackText(widget.product.nameEn!, 15),
                    greyText("Remaining : ${widget.product.quantity!}", 14),
                    !widget.orderedFlag
                        ? widget.product.isActive == 1
                            ? greenText("Active", 14)
                            : redText("Inactive", 14)
                        : widget.product.isActive == 1
                            ? greenText(widget.orderedState!, 14,
                                underline: true)
                            : greyText(widget.orderedState!, 14,
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
                      "\$ ${widget.product.price! < 10000 ? widget.product.price : widget.product.price.toString().substring(0, 3) + ".."}",
                      style: TextStyle(
                          fontSize: 15.0.sp,
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
