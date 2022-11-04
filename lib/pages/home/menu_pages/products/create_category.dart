import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:safqa/pages/create_invoice/customer_info_page.dart';
import 'package:safqa/widgets/signup_text_field.dart';
import 'package:sizer/sizer.dart';

class CreateCategoryPage extends StatefulWidget {
  CreateCategoryPage({super.key});

  @override
  State<CreateCategoryPage> createState() => _CreateCategoryPageState();
}

class _CreateCategoryPageState extends State<CreateCategoryPage> {
  int isActive = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // toolbarHeight: 100,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.white,
          title: blackText("Create Category", 16),

          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            primary: false,
            children: [
              blackText("Category Name (En) ", 16),
              SignUpTextField(
                padding: EdgeInsets.all(0),
              ),
              SizedBox(height: 20),
              blackText("Category Name (Ar) ", 16),
              SignUpTextField(
                padding: EdgeInsets.all(0),
              ),
              SizedBox(height: 20),
              blackText("Is Active?", 16),
              const SizedBox(height: 10),
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFRadio(
                          activeBorderColor: Colors.transparent,
                          inactiveBorderColor: Colors.transparent,
                          radioColor: Color(0xff66B4D2),
                          inactiveIcon: Icon(
                            Icons.circle,
                            color: Color(0xffF8F8F8),
                          ),
                          size: GFSize.SMALL,
                          value: 0,
                          groupValue: isActive,
                          onChanged: (value) => setState(() {
                                isActive = value;
                              })),
                      greyText("Yes", 16),
                    ],
                  ),
                  SizedBox(width: 30),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GFRadio(
                          activeBorderColor: Colors.transparent,
                          radioColor: Color(0xff66B4D2),
                          inactiveIcon: Icon(
                            Icons.circle,
                            color: Color(0xffF8F8F8),
                          ),
                          size: GFSize.SMALL,
                          inactiveBorderColor: Colors.transparent,
                          value: 1,
                          groupValue: isActive,
                          onChanged: (value) => setState(() {
                                isActive = value;
                              })),
                      greyText("No", 16),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    blackText("Create Category", 16),
                    SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
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
              )
            ],
          ),
        ));
  }
}
