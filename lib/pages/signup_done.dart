import 'package:flutter/material.dart';
import 'package:safqa/widgets/zero_app_bar.dart';
import 'package:sizer/sizer.dart';

class SignUpDonePage extends StatelessWidget {
  const SignUpDonePage({super.key});
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ZeroAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/welcome_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.all(20),
        width: w,
        height: h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 25.0.sp,
            ),
            Container(
              width: 100.0.sp,
              height: 120.0.sp,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/done.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: 25.0.sp,
            ),
            Text(
              "Done!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25.0.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 25.0.sp,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: Text(
                "You are logged in successfully, you can go to the home page",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0.sp,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 80.0.sp,
            ),
            GestureDetector(
              onTap: () {},
              child: Container(
                width: 0.7 * w,
                height: 45.0.sp,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white.withOpacity(0.1),
                  border: Border.all(color: Colors.white, width: 1.5),
                ),
                child: Center(
                  child: Text(
                    "Home Page",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
