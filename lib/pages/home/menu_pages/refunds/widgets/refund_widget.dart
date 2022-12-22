import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:safqa/controllers/locals_controller.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:sizer/sizer.dart';

class RefundWidget extends StatefulWidget {
  RefundWidget({
    super.key,
    this.onTap,
  });

  final void Function()? onTap;
  @override
  State<RefundWidget> createState() => _RefundWidgetState();
}

class _RefundWidgetState extends State<RefundWidget> {
  LocalsController _localsController = Get.put(LocalsController());
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
                // child: widget.product.productImage != null
                //     ? Image(
                //         image: NetworkImage(widget.product.productImage),
                //         fit: BoxFit.contain,
                //         width: 60.0.sp,
                //         height: 60.0.sp,
                //         loadingBuilder: (BuildContext context, Widget child,
                //             ImageChunkEvent? loadingProgress) {
                //           if (loadingProgress == null) return child;
                //           return Center(
                //             child: CircularProgressIndicator(
                //               value: loadingProgress.expectedTotalBytes != null
                //                   ? loadingProgress.cumulativeBytesLoaded /
                //                       loadingProgress.expectedTotalBytes!
                //                   : null,
                //             ),
                //           );
                //         },
                //       )
                //     :
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    blackText("Nokia", 15),
                    greyText("#1234123123", 14),
                    blueText("pending".tr, 14, underline: true),
                  ],
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
