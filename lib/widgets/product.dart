import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/checkbox/gf_checkbox.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/pages/home/menu_pages/products/controller/products_controller.dart';
import 'package:safqa/pages/home/menu_pages/products/models/product.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  ProductWidget({
    super.key,
    this.onTap,
    this.orderedFlag = false,
    this.checkedFlag = false,
    this.orderedState,
    required this.product,
    this.onCheckChanged,
  });

  final Product product;
  bool orderedFlag;
  bool checkedFlag;
  String? orderedState;
  final void Function()? onTap;
  final void Function(bool)? onCheckChanged;
  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  LocalsController _localsController = Get.put(LocalsController());
  ProductsController _productsController = Get.put(ProductsController());
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
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
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
                    _localsController.currenetLocale == 0
                        ? blackText(
                            widget.product.nameEn!.length < 15
                                ? widget.product.nameEn!
                                : widget.product.nameEn!.substring(0, 15) +
                                    "...",
                            15)
                        : blackText(
                            widget.product.nameAr!.length < 15
                                ? widget.product.nameAr!
                                : widget.product.nameAr!.substring(0, 15) +
                                    "...",
                            15),
                    greyText(
                        "${"remaining".tr} : ${widget.product.quantity!}", 14),
                    !widget.orderedFlag
                        ? widget.product.isActive == 1
                            ? greenText("active".tr, 14)
                            : redText("inactive".tr, 14)
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
                        ? widget.product.isActive == 1
                            ? GFCheckbox(
                                size: 24,
                                activeBorderColor: Colors.transparent,
                                inactiveBorderColor: Colors.grey,
                                activeBgColor: Color(0xff00A7B3),
                                onChanged: (value) {
                                  setState(() {
                                    widget.checkedFlag = value;
                                    if (widget.onCheckChanged != null) {
                                      widget.onCheckChanged!(value);
                                    } else {
                                      if (value) {
                                        _productsController
                                            .addProductLink(widget.product);
                                      } else {
                                        _productsController
                                            .removeProductLink(widget.product);
                                      }
                                    }
                                  });
                                },
                                value: widget.checkedFlag,
                              )
                            : Container()
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

ProductToPrint(
    {required Product product,
    required pw.ImageProvider image,
    required BuildContext context}) {
  double width = MediaQuery.of(context).size.width;
  return pw.Container(
    padding: pw.EdgeInsets.all(10),
    decoration: pw.BoxDecoration(
      color: PdfColor.fromHex("F8F8F8FF"),
      borderRadius: pw.BorderRadius.circular(10),
    ),
    child: pw.Row(children: [
      pw.Image(image, width: 120, height: 120),
      pw.SizedBox(width: 25),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            ("Name (Ar): " + product.nameAr!),
            style: pw.TextStyle(
              color: PdfColor.fromHex("000000"),
              fontSize: 13.0.sp,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            ("Name (EN): " + product.nameEn!),
            style: pw.TextStyle(
              color: PdfColor.fromHex("000000"),
              fontSize: 13.0.sp,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            ("Remaining: " + product.quantity.toString()),
            style: pw.TextStyle(
              color: PdfColor.fromHex("000000"),
              fontSize: 13.0.sp,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
        ],
      ),
      pw.SizedBox(width: 25),
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            ("Is Active: " + (product.isActive == 1 ? "Yes" : "No")),
            style: pw.TextStyle(
              color:
                  PdfColor.fromHex(product.isActive == 1 ? "00DD00" : "DD0000"),
              fontSize: 13.0.sp,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
          pw.SizedBox(height: 10),
          pw.Text(
            ("Price: " + product.price.toString() + "\$"),
            style: pw.TextStyle(
              color: PdfColor.fromHex("0000DD"),
              fontSize: 13.0.sp,
            ),
            textDirection: pw.TextDirection.rtl,
          ),
        ],
      ),
    ]),
  );
}
